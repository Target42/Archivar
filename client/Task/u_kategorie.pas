unit u_kategorie;

interface

uses
  Vcl.Graphics, System.Generics.Collections;

type
  TKategorie = class
    private
    FName: string;
    FColor: TColor;

    public
      constructor create;
      Destructor Destroy; override;

      property Name: string read FName write FName;
      property Color: TColor read FColor write FColor;
  end;

  TKategorien = class
    private
      m_list : TList<TKategorie>;
      m_dict : TDictionary<TColor, TKategorie>;
      function getCount : integer;

      function  getItem( inx : integer ) : TKategorie;
      procedure setItem( inx : integer; const value : TKategorie );

    public
      constructor create;
      Destructor Destroy; override;

      procedure load( fname : string );

      property count : integer read getCount;
      property Items[inx : integer ] : TKategorie read getItem write setItem;

      function getColorName( color : TColor ) : string;
  end;

var
  Kategorien : TKategorien;

implementation

uses
  System.JSON, u_json, System.SysUtils;

{ TKategorie }

constructor TKategorie.create;
begin

end;

destructor TKategorie.Destroy;
begin

  inherited;
end;

{ TKategorien }

constructor TKategorien.create;
begin
  m_list := TList<TKategorie>.create;
  m_dict := TDictionary<TColor, TKategorie>.create;
end;

destructor TKategorien.Destroy;
var
  kat : TKategorie;
begin
  for kat in m_list do
    kat.Free;
  m_list.Clear;
  m_list.Free;

  m_dict.Free;

  inherited;
end;

function TKategorien.getColorName(color: TColor): string;
begin
  Result := '';

  if m_dict.ContainsKey(color) then
    Result := m_dict[color].Name;
end;

function TKategorien.getCount: integer;
begin
  Result := m_list.Count;
end;

function TKategorien.getItem(inx: integer): TKategorie;
begin
  Result := m_list[inx];
end;

procedure TKategorien.load(fname: string);
var
  obj : TJSONObject;
  arr : TJSONArray;
  row : TJSONObject;
  i   : integer;
  kat : TKategorie;

  function fromHTML( text : string ) : TColor;
  var
    r, g, b : byte;
  begin
    Result := clWhite;
    text := trim(text);
    if length(text)<>7 then
      exit;
    try
      r := StrToInt( '$' + copy( text, 2, 2 ));
      g := StrToInt( '$' + copy( text, 4, 2 ));
      b := StrToInt( '$' + copy( text, 6, 2 ));

      Result :=  R or (G shl 8) or (B shl 16);
    except

    end;
  end;
begin
  if not FileExists(fname) then
    exit;

  obj := loadJSON(fname);
  arr := JArray( obj, 'Kategorie');
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    kat := TKategorie.create;
    m_list.Add(kat);

    kat.Name  := JString(row, 'name');
    kat.Color := fromHTML( JString( row, 'farbe'));

    m_dict.AddOrSetValue(kat.Color, kat);
  end;

  obj.Free;
end;

procedure TKategorien.setItem(inx: integer; const value: TKategorie);
begin
    m_list[inx] := value;
end;

initialization
  Kategorien := TKategorien.create;

finalization
  Kategorien.Free;
end.
