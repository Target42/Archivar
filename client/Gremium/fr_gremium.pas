unit fr_gremium;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, u_gremium;

type
  TGremiumFrame = class(TFrame)
    TV: TTreeView;
  private
    m_list : array of TGremium;

    function findParent( gr : TGremium ) : TGremium;
    procedure add( root : TTreeNode ; gr :  TGremium);

    procedure setGremiumID( value : integer );
    function getGremiumID : Integer;

    function getGremium : TGremium;
    function GetShortGremium: string;
    procedure SetShortGremium(const Value: string);

  public
    property GremiumID : integer read getGremiumId write setGremiumID;
    property Gremium : TGremium read getGremium;
    property ShortGremium: string read GetShortGremium write SetShortGremium;

    procedure init;
    procedure release;

    procedure selectFirst;
  end;

implementation

uses
  m_glob_client;

{$R *.dfm}

{ TGremiumFrame }

procedure TGremiumFrame.add(root: TTreeNode; gr: TGremium);
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

function TGremiumFrame.findParent(gr: TGremium): TGremium;
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

function TGremiumFrame.getGremium: TGremium;
begin
  Result := NIL;
  if not Assigned(TV.Selected) then
    exit;
  Result := TGremium(TV.Selected.Data);
end;

function TGremiumFrame.getGremiumID: Integer;
var
  gr : TGremium;
begin
  Result := -1;
  if not Assigned(TV.Selected) then
    exit;
  gr := TGremium(TV.Selected.Data);
  Result := gr.ID;
end;

function TGremiumFrame.GetShortGremium: string;
var
  gr : TGremium;
begin
  Result := '';

  gr := getGremium;
  if Assigned(gr) then begin
    Result := gr.ShortName;
  end;

end;

procedure TGremiumFrame.init;
var
  i : integer;
  p  : TGremium;
begin
  TV.Images := GM.ImageList1;

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

  selectFirst;
end;

procedure TGremiumFrame.release;
var
  i : integer;
begin
  for i := low(m_list) to High(m_list) do
    m_list[i].Free;
  SetLength(m_list, 0);
end;

procedure TGremiumFrame.selectFirst;
begin
  if TV.Items.Count > 0 then
    TV.Select( TV.Items.GetFirstNode);
end;

procedure TGremiumFrame.setGremiumID(value: integer);
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

procedure TGremiumFrame.SetShortGremium(const Value: string);
var
  gr : TGremium;
  node : TTreeNode;
begin
  node := TV.Items.GetFirstNode;
  while Assigned(node) do begin
    gr := TGremium(node.Data);
    if Assigned(gr) then begin
      if SameText(value, gr.ShortName) then begin
        TV.Selected := node;
        break;
      end;
    end;
    node := node.GetNext;
  end;

end;

end.
