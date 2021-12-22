unit fr_gremiumTree;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, System.JSON, Vcl.ComCtrls,
  System.Generics.Collections, u_gremium, Vcl.Menus;

type
  TGremiumTreeFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    TV: TTreeView;
    PopupMenu1: TPopupMenu;
    Ablageffnen1: TMenuItem;
    procedure TVClick(Sender: TObject);
    procedure TVDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Ablageffnen1Click(Sender: TObject);
  private
    m_list : array of TGremium;
    procedure buildTree( data : TJSONObject );
    procedure FillList( arr : TJSONArray);
    procedure add( root : TTreeNode ; gr :  TGremium);

    procedure setGrID( value : integer );
    function  getGrID : integer;
    function getGremium : TGremium;
  public
    property GRID : integer read getGrID write setGrID;
    property Gremium : TGremium read getGremium;

    procedure updateTree;
    procedure selectFirst;
    procedure clear;
  end;

implementation

uses
  m_glob_client, u_stub, u_json, m_WindowHandler;

{$R *.dfm}

{ TGremiumTreeFrame }

procedure TGremiumTreeFrame.Ablageffnen1Click(Sender: TObject);
var
 gr   : TGremium;
begin
  if not Assigned(TV.Selected) then exit;

  gr := TGremium(TV.Selected.Data);

  WindowHandler.openStorage( gr.StorageID, Format('Ablage : %s', [gr.Name]));
end;

procedure TGremiumTreeFrame.add(root: TTreeNode; gr: TGremium);
var
  node : TTreeNode;
  i    : integer;
  s    : string;
begin
  s := gr.ShortName + ' : ' + gr.Name;
  node := TV.Items.AddChildObject( root, s, gr);
  node.ImageIndex := GM.getImageID( gr.ImageName );
  node.SelectedIndex := node.ImageIndex;
  for i := 0 to pred(gr.Childs.Count) do
    add( node, gr.Childs.Items[i]);
  if root = NIL then
    node.Expand(true);
end;

procedure TGremiumTreeFrame.buildTree(data: TJSONObject);
begin
  if not Assigned(data) then
    exit;

  TV.Items.BeginUpdate;
  TV.Items.Clear;
  FillList( JArray(data, 'items') );
  TV.Items.EndUpdate;
end;

procedure TGremiumTreeFrame.clear;
var
  i : integer;
begin
  for i := low(m_list) to High(m_list) do
    m_list[i].Free;

  if Length(m_list) > 0 then
    SetLength(m_list, 0);
end;

procedure TGremiumTreeFrame.FillList(arr : TJSONArray);

  function findParent( name : string ) : TGremium;
  var
    j : integer;
  begin
    Result := NIL;
    for j := low(m_list) to High(m_list) do
    begin
      if m_list[j].ShortName = name then
      begin
        Result := m_list[j];
        break;
      end;
    end;
  end;

var
  i   : integer;
  row : TJSONObject;
  p   : TGremium;
begin
  if not Assigned( arr) then
    exit;

  SetLength(m_list, arr.Count);
  for i := 0 to pred(arr.Count) do
  begin
    row := getRow(arr, i);
    m_list[i]             := TGremium.create;
    m_list[i].setJSON(row);
  end;
  for i := low(m_list) to High(m_list) do
  begin
    p := findParent(m_list[i].ParentShort);
    if Assigned(p) then
      p.Childs.Add(m_list[i]);
  end;

  for i := low(m_list) to High(m_list) do
  begin
    if m_list[i].ParentShort = '' then
      add( NIL, m_list[i]);
  end;

end;

function TGremiumTreeFrame.getGremium: TGremium;
begin
  Result := NIL;
   if not Assigned( TV.Selected) then
     exit;
  Result := TGremium( TV.Selected.Data);
end;

function TGremiumTreeFrame.getGrID: integer;
var
  gr :  TGremium;
begin
  Result := 0;
  if not Assigned(TV.Selected)  then
    exit;
  gr := TGremium(TV.Selected.Data);
  Result := gr.ID;
end;

procedure TGremiumTreeFrame.selectFirst;
begin
  if TV.Items.Count = 0 then
    exit;
  TV.Selected := TV.Items.Item[0];
  TVClick(TV);
end;

procedure TGremiumTreeFrame.setGrID(value: integer);
var
  i : integer;
  gr : TGremium;
begin
  for i := 0 to pred(TV.Items.Count) do
  begin
    gr := TGremium(TV.Items.Item[i]);
    if gr.ID = value then
    begin
      TV.Selected := TV.Items.Item[i];
      break;
    end;
  end;
end;

procedure TGremiumTreeFrame.TVClick(Sender: TObject);
var
  gr :  TGremium;
begin
  if TV.Selected = NIL then
    exit;

  gr := TGremium(TV.Selected.Data);
  PostMessage( Application.MainFormHandle, msgFilterTasks,0, gr.ID );
  PostMessage( Application.MainFormHandle, msgUpdateGremium, 0, gr.ID);
end;

procedure TGremiumTreeFrame.TVDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TGremiumTreeFrame.updateTree;
var
  data : TJSONObject;
  client : TAdminModClient;
begin
  if not Assigned(GM.SQLConnection1.DBXConnection) then
    exit;

  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  TV.Images := GM.ImageList1;
  client := NIL;
  clear;
  try
    client := TAdminModClient.Create(GM.SQLConnection1.DBXConnection);
    data := client.getGremiumList;
    buildTree(data);
    GM.FillGremien( JArray( data, 'items'));
  finally
    client.Free;
  end;
end;

end.
