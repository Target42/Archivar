unit f_df_EnumList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.ExtCtrls, Vcl.StdCtrls,
  i_datafields, Vcl.Buttons, Vcl.ExtDlgs;

type
  TDFEnumListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LB: TListBox;
    Panel1: TPanel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    m_prop : IProperty;
    m_list : TStringList;
    procedure setProp( value : IProperty );
  public
    property Prop : IProperty read m_prop write setProp;
  end;

var
  DFEnumListForm: TDFEnumListForm;

implementation

{$R *.dfm}

procedure TDFEnumListForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_list.Assign(LB.Items);
  m_prop.Value := m_list.DelimitedText;
end;

procedure TDFEnumListForm.FormCreate(Sender: TObject);
begin
  m_prop                  := NIL;
  m_list                  := TStringList.Create;
  m_list.StrictDelimiter  := true;
  m_list.Delimiter        := ';';
end;

procedure TDFEnumListForm.FormDestroy(Sender: TObject);
begin
  m_list.Free;
end;

procedure TDFEnumListForm.setProp(value: IProperty);
begin
  m_prop := value;
  m_list.DelimitedText := m_prop.Value;
  LB.Items.Assign(m_list);
end;

procedure TDFEnumListForm.SpeedButton1Click(Sender: TObject);
var
  s : string;
begin
  s := trim(Edit1.Text);
  if LB.Items.IndexOf(s) = -1 then
    LB.Items.Add(s);
end;

procedure TDFEnumListForm.SpeedButton2Click(Sender: TObject);
begin
  if LB.ItemIndex = -1 then begin
    SpeedButton1Click(sender);
    exit;
  end;
  LB.Items.Strings[LB.ItemIndex] := Trim(Edit1.Text);
end;

procedure TDFEnumListForm.SpeedButton3Click(Sender: TObject);
begin
  if LB.ItemIndex = -1 then
    exit;

  LB.Items.Delete(LB.ItemIndex);
end;

procedure TDFEnumListForm.SpeedButton4Click(Sender: TObject);
begin
  if (LB.ItemIndex <1) or ( LB.Items.Count = 1 ) then
    exit;
  LB.Items.Exchange(LB.ItemIndex, LB.ItemIndex-1);
end;

procedure TDFEnumListForm.SpeedButton5Click(Sender: TObject);
begin
  if (LB.ItemIndex = -1) or ( LB.ItemIndex = LB.Items.Count-1) then
    exit;
  LB.Items.Exchange(LB.ItemIndex, LB.ItemIndex+1);
end;

procedure TDFEnumListForm.SpeedButton6Click(Sender: TObject);
begin
  if OpenTextFileDialog1.Execute then begin
      m_list.LoadFromFile(OpenTextFileDialog1.FileName);
      LB.Items.Assign(m_list);
  end;
end;

end.
