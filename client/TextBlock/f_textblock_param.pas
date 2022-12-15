unit f_textblock_param;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, fr_base, xsd_TextBlock;

type
  TTextBlockParameterForm = class(TForm)
    BaseFrame1: TBaseFrame;
    SG: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
  private
    x_block : IXMLBlock;
    m_content : string;
    procedure setBlock( value : IXMLBlock);
    procedure setColWidth;
    function checkValues : boolean;
  public
    property Xblock : IXMLBlock read x_block write setBlock;

    function getContext : string;
  end;

var
  TextBlockParameterForm: TTextBlockParameterForm;

implementation

{$R *.dfm}

uses m_glob_client;

{ TTextBlockParameterForm }

procedure TTextBlockParameterForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i : integer;
  key, val : string;
begin
  if not checkValues then
    exit;
  for i := 0 to pred(x_block.Fields.Count) do
  begin
    key := x_block.Fields[i].Name;
    val := SG.Cells[1, i+1];
    m_content := StringReplace( m_content, '%%'+key+'%%', val, [rfReplaceAll, rfIgnoreCase]);
  end;
  ModalResult := mrOk;
end;

function TTextBlockParameterForm.checkValues: boolean;
var
  i     : integer;
  val   : string;
  ival  : integer;
  dval  : TDateTime;
begin
  Result := false;
  for i := 0 to pred(x_block.Fields.Count) do begin
    val := SG.Cells[1, i+1];

    if SameText( Xblock.Fields.Field[i].Fieldtype, 'zahl') then begin
      if not TryStrToInt( val, ival) then begin
        ShowMessage(format('Der Parameter "%s" muss eine Zahl sein!', [Xblock.Fields.Field[i].Caption]));
        exit;
      end;
    end else if SameText(Xblock.Fields.Field[i].Fieldtype, 'datum') then begin
      if not TryStrToDate(val, dval) then begin
        ShowMessage(format('Der Parameter "%s" muss ein Datum sein!', [Xblock.Fields.Field[i].Caption]));
        exit;
      end;
    end;

  end;
  Result := true;
end;

procedure TTextBlockParameterForm.FormCreate(Sender: TObject);
begin
  SG.Cells[0, 0] := 'Variable';
  SG.Cells[1, 0] := 'Wert';
  SG.Cells[2, 0] := 'Beschreibung';

  x_block := NIL;
end;

procedure TTextBlockParameterForm.FormDestroy(Sender: TObject);
begin
  x_block := NIL;
end;

function TTextBlockParameterForm.getContext: string;
begin
  Result := m_content;
end;

procedure TTextBlockParameterForm.setBlock(value: IXMLBlock);
var
  i   : integer;
  def : string;
begin
  x_block := value;
  m_content := Xblock.Content;

  SG.RowCount := x_block.Fields.Count + 1;
  for i := 0 to pred(x_block.Fields.Count) do
  begin
    SG.Cells[0, i+1]:= x_block.Fields[i].Caption;
    SG.Cells[2, i+1]:= x_block.Fields[i].Rem;
    def := trim(x_block.Fields[i].DefaultValue);
    if def <> '' then begin
      if SameText( def, '$$date') then
        SG.Cells[1, i+1]:= DateToStr(date)
      else if SameText( def, '$$time') then
        SG.Cells[1, i+1]:= FormatDateTime('hh:nn', now)
      else if SameText(def, '$$user') then
        SG.Cells[1, i+1]:= GM.Vorname+' '+GM.Name
      else
        SG.Cells[1, i+1]:= def;
    end;
  end;

  setColWidth;

  SG.Row   := 1;
  SG.Col   := 1;

  SG.FixedRows := 1;
  SG.FixedCols := 1;

end;

procedure TTextBlockParameterForm.setColWidth;
  function length(ACol : integer) : integer;
  var
    i : integer;
    len : integer;
  begin
    Result := SG.DefaultColWidth;
    for i := 0 to pred(SG.RowCount) do begin
      len := SG.Canvas.TextWidth(SG.Cells[Acol, i]) + 8;
      if len > Result then
        Result := len;
    end;
  end;
begin
  SG.ColWidths[0] := length(0);
  SG.ColWidths[2] := length(2);
end;

procedure TTextBlockParameterForm.SGKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) or ( key = #8) then begin
    if SG.Row < SG.RowCount-1 then
      SG.Row := SG.Row + 1
    else
      BaseFrame1.OKBtn.SetFocus;
  end;
end;

procedure TTextBlockParameterForm.SGSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := Acol = 1;
end;

end.
