unit u_lockInfo;

interface

uses
  System.JSON;

type
  TLockInfo = class
    private
      FID: integer;
      FCLID: string;
      FLocked: boolean;
      FHost: string;
      FTimeStamp: TDateTime;
      FUser: string;
      FPEID: integer;
      FSessionID : NativeInt;
    public
      constructor create;
      Destructor Destroy; override;

      property ID: integer read FID write FID;
      property CLID: string read FCLID write FCLID;
      property Locked: boolean read FLocked write FLocked;
      property Host: string read FHost write FHost;
      property TimeStamp: TDateTime read FTimeStamp write FTimeStamp;
      property User: string read FUser write FUser;
      property PEID: integer read FPEID write FPEID;
      property SessionID: NativeInt  read FSessionID write FSessionID;

      procedure setJSON( obj : TJSONObject );
      function  getJSON : TJSONObject;
  end;

implementation

uses
  u_json;

{ TLockInfo }

constructor TLockInfo.create;
begin
  FID  := 0 ;
  FLocked := false;
  FPEID   := 0;
end;

destructor TLockInfo.Destroy;
begin

  inherited;
end;

function TLockInfo.getJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, 'id', FID);
  JReplace( Result, 'clid', FCLID);
  JReplace( Result, 'locked', FLocked);
  JReplace( Result, 'host', FHost);
  JReplaceDouble( Result, 'timestamp', FTimeStamp);
  JReplace( Result, 'user', FUser);
  JReplace( Result, 'peid', FPEID);
end;

procedure TLockInfo.setJSON(obj: TJSONObject);
begin
  FID         := JInt( obj, 'id', FID);
  FCLID       := JString( obj, 'clid', FCLID);
  FLocked     := JBool( obj, 'locked', FLocked);
  FHost       := JString( obj, 'host', FHost);
  FTimeStamp  := JDouble( obj, 'timestamp', FTimeStamp);
  FUser       := JString(obj, 'user', FUser);
  FPEID       := JInt(obj, 'peid', FPEID);

end;

end.
