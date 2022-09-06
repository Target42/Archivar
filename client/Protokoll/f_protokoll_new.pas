unit f_protokoll_new;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_gremium, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, System.JSON;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LBClick(Sender: TObject);
  private
    m_obj : TJSONObject;
    procedure updateTree;
  public
    { Public-Deklarationen }
  end;

var
  ProtokollNewForm: TProtokollNewForm;

implementation

uses
  m_fileCache, u_json;

{$R *.dfm}

procedure TProtokollNewForm.FormCreate(Sender: TObject);
begin
  m_obj := NIL;

  GremiumFrame1.init;
  FileCacheMod.fillList('protokoll', Lb.Items);
end;

procedure TProtokollNewForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release;
  if Assigned(m_obj) then
    m_obj.Free;
end;

procedure TProtokollNewForm.LBClick(Sender: TObject);
var
  fname : string;
begin
  if LB.ItemIndex = -1 then exit;

  fname := FileCacheMod.getFile('protokoll', LB.Items[LB.ItemIndex]);
  if not FileExists(fname) then exit;

  if Assigned(m_obj) then
    m_obj.Free;

  m_obj := loadJSON(fname);
  updateTree;
end;

procedure TProtokollNewForm.updateTree;
  procedure addChapter( root : TTreeNode; arr : TJSONArray ); forward;

  procedure addTitel( root : TTreeNode; obj : TJSONObject );
  var
    row : TJSONObject;
    arr : TJSONArray;
    i   : integer;
    j   : integer;
    node : TTreenode;
    sub  : TTreeNode;
  begin
    node := TV.Items.AddChild(root, JString( obj, 'titel'));

    arr := JArray( obj, 'kapitel');
    if Assigned(arr) then begin
      for j := 0 to pred(arr.Count) do begin
        row := getRow(arr, j);
        sub := TV.Items.AddChild( node, JString(row, 'titel'));

        addChapter(sub, JArray(row, 'chapter'));
      end;
    end;

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

  addChapter(NIL, JArray(m_obj, 'chapter'));

  TV.Items.EndUpdate;
end;

end.
