unit f_df_listbox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base, i_datafields;

type
  TListBoxForm = class(TForm)
    BaseFrame1: TBaseFrame;
    LB: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_prop : Iproperty;
    m_list : IDataFieldList;

    procedure setProp( value : IProperty );
    procedure setFieldList( value : IDataFieldList );
  public
    property FieldList : IDataFieldList read m_list write setFieldList;
    property Prop : IProperty read m_prop write setProp;
  end;

var
  ListBoxForm: TListBoxForm;

implementation

{$R *.dfm}

{ TListBoxForm }

procedure TListBoxForm.BaseFrame1OKBtnClick(Sender: TObject);
begin
  m_prop.Value :='';
  if LB.ItemIndex = -1 then
    exit;
  m_prop.Value := LB.Items.Strings[LB.ItemIndex];
end;

procedure TListBoxForm.FormCreate(Sender: TObject);
begin
  m_prop := NIL;
end;

procedure TListBoxForm.setFieldList(value: IDataFieldList);
var
  i : integer;
begin
  m_list := value;
  if not Assigned(m_list) then
    exit;

  for i := 0 to pred(m_list.Count) do
  begin
    if SameText(m_list.Items[i].Typ, 'table') then
      Lb.Items.Add(m_list.Items[i].Name);
  end;
end;

procedure TListBoxForm.setProp(value: IProperty);
begin
  m_prop := value;
  LB.ItemIndex := Lb.Items.IndexOf(m_prop.Value)
end;

end.
