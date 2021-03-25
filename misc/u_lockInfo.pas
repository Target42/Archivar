unit u_lockInfo;

interface

uses
  System.JSON, System.Generics.Collections;

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
      FChilds : TList<TLockInfo>;
    FSub: integer;
    public
      constructor create;
      Destructor Destroy; override;

      property ID         : integer   read FID        write FID;
      property Sub        : integer   read FSub       write FSub;
      property CLID       : string    read FCLID      write FCLID;
      property Locked     : boolean   read FLocked    write FLocked;
      property Host       : string    read FHost      write FHost;
      property TimeStamp  : TDateTime read FTimeStamp write FTimeStamp;
      property User       : string    read FUser      write FUser;
      property PEID       : integer   read FPEID      write FPEID;
      property SessionID  : NativeInt read FSessionID write FSessionID;
      property Childs     : TList<TLockInfo> read FChilds;

      function findChild( id : integer ) : TLockInfo;
      function addChild( li : TLockInfo ) : Boolean;
      function removeChild( id : integer ) : TLockInfo;

      procedure setJSON( obj : TJSONObject );
      function  getJSON : TJSONObject;
  end;

implementation

uses
  u_json;

{ TLockInfo }

function TLockInfo.addChild(li: TLockInfo): Boolean;
begin
  Result := false;
  if not FChilds.Contains(li) then
  begin
    FChilds.Add(li);
    Result := true;
  end;
end;

constructor TLockInfo.create;
begin
  FID  := 0 ;
  FLocked := false;
  FPEID   := 0;
  FChilds := TList<TLockInfo>.create;
end;

destructor TLockInfo.Destroy;
var
  lk : TLockInfo;
begin
  for lk in FChilds do
    lk.Free;
  FChilds.Free;
  inherited;
end;

function TLockInfo.findChild(id: integer): TLockInfo;
var
  li : TLockInfo;
begin
  Result := NIL;
  for li in FChilds do
    if li.ID = id then
    begin
      Result := li;
      break;
    end;
end;

function TLockInfo.getJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace( Result, 'id', FID);
  JReplace( Result, 'sub',FSub);
  JReplace( Result, 'clid', FCLID);
  JReplace( Result, 'locked', FLocked);
  JReplace( Result, 'host', FHost);
  JReplaceDouble( Result, 'timestamp', FTimeStamp);
  JReplace( Result, 'user', FUser);
  JReplace( Result, 'peid', FPEID);
end;

function TLockInfo.removeChild(id: integer): TLockInfo;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred( FChilds.Count) do
  begin
    if FChilds[i].ID = id then
    begin
      Result := FChilds[i];
      FChilds.Delete(i);
      break;
    end;
  end;
end;

procedure TLockInfo.setJSON(obj: TJSONObject);
begin
  FID         := JInt(    obj, 'id',        FID);
  FSub        := JInt(    obj, 'sub',       FSub);
  FCLID       := JString( obj, 'clid',      FCLID);
  FLocked     := JBool(   obj, 'locked',    FLocked);
  FHost       := JString( obj, 'host',      FHost);
  FTimeStamp  := JDouble( obj, 'timestamp', FTimeStamp);
  FUser       := JString( obj, 'user',      FUser);
  FPEID       := JInt(    obj, 'peid',      FPEID);

end;

end.
