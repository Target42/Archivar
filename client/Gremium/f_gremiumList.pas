unit f_gremiumList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base, u_gremium;

type
  TGremiumListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    TV: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_list : array of TGremium;

    function findParent( gr : TGremium ) : TGremium;
    procedure add( root : TTreeNode ; gr :  TGremium);

    procedure setGremiumID( value : integer );
    function getGremiumID : Integer;

    function getGremium : TGremium;
  public
    property GremiumID : integer read getGremiumId write setGremiumID;
    property Gremium : TGremium read getGremium;
  end;

var
  GremiumListForm: TGremiumListForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TGremiumListForm.add(root: TTreeNode; gr: TGremium);
var
  node : TTreeNode;
  i    : integer;
  s    : string;
begin
  s := gr.ShortName + ' : ' + gr.Name;
  node := TV.Items.AddChildObject( root, s, gr);
  node.ImageIndex := GM.getImageID( gr.ImageName);
  node.SelectedIndex := node.ImageIndex;

  for i := 0 to pred(gr.Childs.Count) do
    add( node, gr.Childs.Items[i]);
  if root = NIL then
    node.Expand(true);
end;

function TGremiumListForm.findParent(gr: TGremium): TGremium;
var
  i : integer;
begin
  Result := NIL;
  for i := low(m_list) to High(m_list) do
  begin
    if SameText(m_list[i].ShortName, gr.ParentShort) then
    begin
      Result := m_list[i];
      break;
    end;
  end;
end;

procedure TGremiumListForm.FormCreate(Sender: TObject);
var
  i : integer;
  p  : TGremium;
begin
  TV.Items.BeginUpdate;
  SetLength(m_list, GM.Gremien.Count);
  for i := 0 to pred(GM.Gremien.Count) do
  begin
    m_list[i] := GM.Gremien.Items[i].clone;
  end;
  for i := low(m_list) to High(m_list) do
  begin
    p := findParent(m_list[i]);
    if Assigned(p) then
      p.Childs.Add(m_list[i]);
  end;
  for i := low(m_list) to High(m_list) do
  begin
    if m_list[i].ParentShort = '' then
      add( NIL, m_list[i]);
  end;

  TV.Items.EndUpdate;
end;

procedure TGremiumListForm.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for i := low(m_list) to High(m_list) do
    m_list[i].Free;
  SetLength(m_list, 0);
end;

function TGremiumListForm.getGremium: TGremium;
begin
  Result := NIL;
  if not Assigned(TV.Selected) then
    exit;
  Result := TGremium(TV.Selected.Data);
end;

function TGremiumListForm.getGremiumID: Integer;
var
  gr : TGremium;
begin
  Result := -1;
  if not Assigned(TV.Selected) then
    exit;
  gr := TGremium(TV.Selected.Data);
  Result := gr.ID;
end;

procedure TGremiumListForm.LVDblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TGremiumListForm.setGremiumID(value: integer);
var
  i : integer;
  gr : TGremium;
begin
  for i := 0 to pred(TV.Items.Count) do
    begin
      gr := TGremium(TV.Items.Item[i].Data);
      if gr.ID = value then
      begin
        TV.Selected := TV.Items.Item[i];
        break;
      end;
    end;
end;

end.
