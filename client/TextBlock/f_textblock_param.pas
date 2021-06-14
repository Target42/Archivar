unit f_textblock_param;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, fr_base, xsd_TextBlock,
  System.Generics.Collections;

type
  TTextBlockParameterForm = class(TForm)
    BaseFrame1: TBaseFrame;
    SG: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    x_block : IXMLBlock;
    m_content : string;
    procedure setBlock( value : IXMLBlock);
  public
    property Xblock : IXMLBlock read x_block write setBlock;

    function getContext : string;
  end;

var
  TextBlockParameterForm: TTextBlockParameterForm;

implementation

{$R *.dfm}

{ TTextBlockParameterForm }

procedure TTextBlockParameterForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i : integer;
  key, val : string;
begin
  for i := 0 to pred(x_block.Fields.Count) do
  begin
    key := SG.Cells[0, i+1];
    val := SG.Cells[1, i+1];
    m_content := StringReplace( m_content, '%%'+key+'%%', val, [rfReplaceAll, rfIgnoreCase]);
  end;
end;

procedure TTextBlockParameterForm.FormCreate(Sender: TObject);
begin
  SG.Cells[0, 0] := 'Variable';
  SG.Cells[1, 0] := 'Wert';

  x_block := NIL;
  SG.ColWidths[1] := 100;
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
  i : integer;
begin
  x_block := value;
  m_content := Xblock.Content;

  SG.RowCount := x_block.Fields.Count + 1;
  for i := 0 to pred(x_block.Fields.Count) do
  begin
    SG.Cells[0, i+1]:= x_block.Fields[i].Name;
   end;

   SG.Row   := 1;
   SG.Col   := 1;

   SG.FixedRows := 1;
   SG.FixedCols := 1;

end;

end.
