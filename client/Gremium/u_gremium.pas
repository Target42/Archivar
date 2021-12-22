unit u_gremium;

interface

uses
  System.Generics.Collections, System.JSON;

type
  TGremium = class(TObject)
  private
    m_childs    : TList<TGremium>;
    FID         : integer;
    FName       : String;
    FShortName  : String;
    FParentShort: string;
    FImageName  : string;
    FStorageID  : integer;
  public

    constructor create;
    Destructor Destroy; override;

    property ID         : integer         read FID            write FID;
    property StorageID  : integer         read FStorageID     write FStorageID;
    property Name       : String          read FName          write FName;
    property ShortName  : String          read FShortName     write FShortName;
    property ParentShort: string          read FParentShort   write FParentShort;
    property Childs     : TList<TGremium> read m_childs;
    property ImageName  : string          read FImageName     write FImageName;

    procedure setJSON( data : TJSONObject );
    function clone : TGremium;
  end;

implementation

uses
  u_json, System.SysUtils;

{ TGremium }

function TGremium.clone: TGremium;
var
  i : integer;
begin
  Result              := TGremium.create;
  Result.FID          := FID;
  Result.FName        := FName;
  Result.FShortName   := FShortName;
  Result.FParentShort := FParentShort;
  Result.FImageName   := FImageName;
  Result.FStorageID   := FStorageID;

  for i := 0 to pred(m_childs.Count) do
    Result.Childs.Add(m_childs.Items[i].clone);
end;

constructor TGremium.create;
begin
  FStorageID  := -1;
  m_childs    := TList<TGremium>.create;
end;

destructor TGremium.Destroy;
begin
  m_childs.Free;
  inherited;
end;

procedure TGremium.setJSON(data: TJSONObject);
begin
  FID           := JInt(data, 'id');
  FName         := JString( data, 'name');
  FShortName    := UpperCase(JString( data, 'short'));
  FParentShort  := UpperCase(JString( data, 'parent'));
  FImageName    := lowerCase(JString( data, 'image' ));
  FStorageID    := JInt( data, 'sid');
end;

end.
