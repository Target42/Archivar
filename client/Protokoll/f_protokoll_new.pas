unit f_protokoll_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_gremium, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, System.JSON, Vcl.Buttons, u_gremium;

type
  TProtokollNewForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    GremiumFrame1: TGremiumFrame;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LB: TListBox;
    TV: TTreeView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LBClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure GremiumFrame1TVClick(Sender: TObject);
  private
    m_obj : TJSONObject;
    procedure updateTree;
    function getGremium  : TGremium;
    function getTemplate : TJSONObject;
    procedure setGremium( name : string );
  public
    property Template : TJSONObject read getTemplate;
    property Gremium  : TGremium read getGremium;
  end;

var
  ProtokollNewForm: TProtokollNewForm;

implementation

uses
  m_fileCache, u_json;

{$R *.dfm}

procedure TProtokollNewForm.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    if Assigned(m_obj) then
      m_obj.Free;
    m_obj := loadJSON( OpenDialog1.FileName );

    setGremium(JString( m_obj, 'gremium'));
    updateTree;
  end;
end;

procedure TProtokollNewForm.BitBtn2Click(Sender: TObject);
begin
  if Assigned(m_obj) then
    FreeAndNil(m_obj);
  updateTree;

end;

procedure TProtokollNewForm.FormCreate(Sender: TObject);
var
  i     : integer;
  obj   : TJSONObject;
  fname : string;
  list  : TStringList;
  title : string;
begin
  m_obj := NIL;

  list := TStringList.Create;
  GremiumFrame1.init;
  FileCacheMod.fillList('protokoll', list);

  for i := 0 to pred(list.Count) do begin
    fname := FileCacheMod.getFile('protokoll', list[i]);
    obj := loadJSON(fname);

    title := trim(JString( obj, 'titel'));
    if title = '' then
      title := list[i];

    Lb.Items.AddObject(title, obj);
  end;
  list.Free;
end;

procedure TProtokollNewForm.FormDestroy(Sender: TObject);
var
  i   : integer;
begin
  for i := 0 to pred(LB.Items.Count) do begin
    Lb.Items.Objects[i].Free;
  end;

  GremiumFrame1.release;
  if Assigned(m_obj) then
    m_obj.Free;
end;

function TProtokollNewForm.getGremium: TGremium;
begin
  Result := GremiumFrame1.Gremium;
end;

function TProtokollNewForm.getTemplate: TJSONObject;
begin
  Result := NIL;

  if Assigned(m_obj) then
    Result := m_obj.Clone as TJSONObject;
end;

procedure TProtokollNewForm.GremiumFrame1TVClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Enabled := Assigned(GremiumFrame1.Gremium);
end;

procedure TProtokollNewForm.LBClick(Sender: TObject);
var
  obj : TJSONObject;
begin
  if LB.ItemIndex = -1 then exit;

  if Assigned(m_obj) then
    m_obj.Free;

  obj := TJSONObject(LB.Items.Objects[LB.ItemIndex]);

  m_obj := obj.Clone as TJSONObject;
  setGremium(JString( m_obj, 'gremium'));
  updateTree;
end;

procedure TProtokollNewForm.setGremium(name: string);
begin
  if name = '' then exit;
  GremiumFrame1.ShortGremium := name;


  BaseFrame1.OKBtn.Enabled := Assigned(TV.Selected);
end;

procedure TProtokollNewForm.updateTree;

  procedure addTitel( root : TTreeNode; obj : TJSONObject );
  var
    row : TJSONObject;
    arr : TJSONArray;
    j   : integer;
    node : TTreenode;
    sub  : TTreeNode;
  begin
    node                := TV.Items.AddChild(root, JString( obj, 'titel'));
    node.ImageIndex     := 0;
    node.SelectedIndex  := 0;

    arr := JArray( obj, 'kapitel');
    if Assigned(arr) then begin
      for j := 0 to pred(arr.Count) do begin
        row := getRow(arr, j);
        sub := TV.Items.AddChild( node, JString(row, 'titel'));
        sub.ImageIndex     := 2;
        sub.SelectedIndex  := 2;
      end;
    end;
    node.Expand(true);

  end;

  procedure addChapter( root : TTreeNode; arr : TJSONArray );
  var
    row : TJSONObject;
    i   : integer;
  begin
    if not Assigned(arr) then exit;

    for i := 0 to pred(arr.Count) do begin
      row := getRow(arr, i);
      addTitel(root, row);
    end;
  end;
begin
  TV.Items.BeginUpdate;
  TV.Items.Clear;

  if Assigned(m_obj) then begin
    addChapter(NIL, JArray(m_obj, 'chapter'));
  end;

  TV.Items.EndUpdate;
end;

end.
