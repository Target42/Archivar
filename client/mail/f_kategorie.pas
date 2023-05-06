unit f_kategorie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList;

type
  TKategorieForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LV: TListView;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_kats  : TStringList;
    m_split : TStringList;
    procedure setKats( value : TStringList );
    procedure setSelection( value : string );
    function  getSelection : string;
  public
    property Kategorien : TStringList read m_kats write setKats;

    property Selection : string read getSelection write setSelection;
  end;

var
  KategorieForm: TKategorieForm;

implementation

{$R *.dfm}

procedure TKategorieForm.FormCreate(Sender: TObject);
begin
  m_split := TStringList.Create;
  m_split.StrictDelimiter := true;
  m_split.Delimiter := ';';
end;

procedure TKategorieForm.FormDestroy(Sender: TObject);
begin
  m_split.Free;
end;

function TKategorieForm.getSelection: string;
var
  i : integer;
begin
  m_split.Clear;
  for i := 0 to pred(LV.Items.Count) do begin
    if LV.Items[i].Checked then
      m_split.Add(LV.Items[i].Caption);
  end;

  Result := m_split.DelimitedText;
end;

procedure TKategorieForm.setKats(value: TStringList);
var
  item : TListitem;
  i    : integer;
  bmp  : TBitmap;
  re   : TRect;
begin
  m_kats := value;
  bmp := TBitmap.Create;
  bmp.SetSize(16, 16);
  re := Rect( 0, 0, bmp.Width, bmp.Height);

  for i := 0 to pred(m_kats.Count) do begin
    item := Lv.Items.Add;
    item.Caption := m_kats.Names[i];
    bmp.Canvas.Brush.Color := TColor(StrToInt(m_kats.ValueFromIndex[i]));
    bmp.Canvas.FillRect(re);
    item.ImageIndex := ImageList1.Add(bmp, NIL);
  end;
  bmp.Free;
end;

procedure TKategorieForm.setSelection(value: string);
var
  i, j : integer;
begin
  m_split.DelimitedText := value;

  for i := 0 to pred(m_split.Count) do begin
    for j := 0 to pred(Lv.Items.Count) do begin
      if SameText( m_split[i], Lv.Items[j].Caption) then begin
        Lv.Items[j].Checked := true;
        break;
      end;
    end;
  end;
end;

end.
