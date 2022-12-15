unit u_bookmark;

interface

uses
  System.JSON, u_json, u_berTypes;

type
  TBookmark = class( TObject )
    private
      FID       : integer;
      FCLID     : string;
      FTitel    : string;
      FGroup    : string;
      FInternal: boolean;
      FTypeID: integer;
      FDocType : tDocType;
    FGremiumID: integer;
    public
      constructor create;
      Destructor Destroy; override;

      property Group: string read FGroup write FGroup;
      property ID: integer read FID write FID;
      property Titel: string read FTitel write FTitel;
      property CLID : string read FCLID write FCLID;
      property Internal: boolean read FInternal write FInternal;
      property TypeID: integer read FTypeID write FTypeID;
      property DocType : tDocType read FDocType write FDocType;
      property GremiumID: integer read FGremiumID write FGremiumID;

      function getJSON: TJSONObject;
      procedure setJSON( obj :  TJSONObject );
  end;

implementation

{ TBookmark }

constructor TBookmark.create;
begin

end;

destructor TBookmark.Destroy;
begin
  inherited;
end;

function TBookmark.getJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  JReplace( Result, 'id', FID);
  JReplace( Result, 'title', FTitel);
  JReplace( Result, 'internal', FInternal);
  JReplace( Result, 'typeid', FTypeID);
  JReplace( Result, 'group', FGroup);
  JReplace( Result, 'clid', FClID);
  JReplace( Result, 'doctype', integer(FDocType));
  JReplace( Result, 'gremiumid', FGremiumID);
end;

procedure TBookmark.setJSON(obj: TJSONObject);
begin
  FID       := JInt( obj, 'id');
  FTitel    := JString( obj, 'title');
  FInternal := JBool( obj, 'internal');
  FTypeID   := JInt( obj, 'typeid');
  FGroup    := JString( obj, 'group');
  FCLID     := JString( obj, 'clid');
  FDocType  := tDocType( JInt( obj, 'doctype'));
  FGremiumID:= JInt(obj, 'gremiumid');
end;

end.
