unit f_gremium_MA_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, fr_base, Vcl.ExtCtrls, Vcl.DBGrids, u_stub,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.StdCtrls;

type
  TGremiumMAForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    AllUsers: TClientDataSet;
    GremiumUser: TClientDataSet;
    Panel1: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    AllUserSrc: TDataSource;
    GremiumSrc: TDataSource;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox1: TGroupBox;
    Panel4: TDBGrid;
    GroupBox2: TGroupBox;
    Panel2: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Panel2DblClick(Sender: TObject);
    procedure Panel4DblClick(Sender: TObject);
    procedure Berater1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2DblClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    m_title : string;
    m_id : integer;
    m_client : TdsGremiumClient;
    procedure setTile( value : string );
    function GetGremiumID: integer;
    procedure SetGremiumID(const Value: integer);
  public
    property GremiumTitel: String read m_title write setTile;
    property GremiumID: integer read GetGremiumID write SetGremiumID;
  end;

var
  GremiumMAForm: TGremiumMAForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TGremiumMAForm.Berater1Click(Sender: TObject);
var
  roll : string;
begin
  if GremiumUser.IsEmpty then
    exit;

  roll := arrRolls[(Sender as TMenuItem).Tag];

  m_client.changeRoll(m_id, GremiumUser.FieldByName('PE_ID').AsInteger, roll);

  GremiumUser.Refresh;
end;

procedure TGremiumMAForm.FormCreate(Sender: TObject);
var
  i : integer;
  item : TMenuItem;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_client := TdsGremiumClient.Create(GM.SQLConnection1.DBXConnection);
  AllUsers.Open;

  for i := low(arrRolls) to high(arrRolls) do
  begin
    item := TMenuItem.Create(PopupMenu1);
    PopupMenu1.Items.Add(item);
    item.Tag := i;
    if i = 0 then
      item.Caption := 'Rolle entfernen'
    else
      item.Caption := arrRolls[i];
    item.OnClick := Berater1Click;
  end;
end;

procedure TGremiumMAForm.FormDestroy(Sender: TObject);
begin
  AllUsers.Close;
  if GremiumUser.Active then
    GremiumUser.Close;

  m_client.Free;
end;

function TGremiumMAForm.GetGremiumID: integer;
begin
  Result := m_id;
end;

procedure TGremiumMAForm.Panel2DblClick(Sender: TObject);
begin
  if AllUsers.IsEmpty then
    exit;

  m_client.AddMA(m_id, AllUsers.FieldByName('PE_ID').AsInteger);

  GremiumUser.Refresh;
end;

procedure TGremiumMAForm.Panel4DblClick(Sender: TObject);
begin
  if GremiumUser.IsEmpty then
    exit;

  m_client.RemoveMA(m_id, GremiumUser.FieldByName('PE_ID').AsInteger);

  GremiumUser.Refresh;
end;

procedure TGremiumMAForm.SetGremiumID(const Value: integer);
begin
  m_id := Value;
  GremiumUser.ParamByName('gr_id').AsInteger := m_id;
  GremiumUser.Open;
end;

procedure TGremiumMAForm.setTile(value: string);
begin
  m_title := value;
  Panel1.Caption := m_title;
end;

procedure TGremiumMAForm.SpeedButton1Click(Sender: TObject);
begin
  if AllUsers.IsEmpty then
    exit;

  AllUsers.First;
  while not AllUsers.Eof do
  begin
    m_client.AddMA(m_id, AllUsers.FieldByName('PE_ID').AsInteger);
    AllUsers.Next;
  end;
  GremiumUser.Refresh;
end;

procedure TGremiumMAForm.SpeedButton2DblClick(Sender: TObject);
var
  mark : TBookmark;
  i    : integer;
begin
  for i := 0 to pred(Panel2.SelectedRows.Count) do
    begin
      mark := Panel2.SelectedRows.Items[i];
      AllUsers.GotoBookmark(mark);
      m_client.AddMA(m_id, AllUsers.FieldByName('PE_ID').AsInteger);
    end;
  AllUsers.Refresh;
end;

procedure TGremiumMAForm.SpeedButton3Click(Sender: TObject);
var
  mark : TBookmark;
  i    : integer;
begin
  for i := 0 to pred(Panel4.SelectedRows.Count) do
    begin
      mark := Panel4.SelectedRows.Items[i];
      GremiumUser.GotoBookmark(mark);
      m_client.RemoveMA(m_id, AllUsers.FieldByName('PE_ID').AsInteger);
    end;
  GremiumUser.Refresh;
end;

procedure TGremiumMAForm.SpeedButton4Click(Sender: TObject);
begin
  if GremiumUser.IsEmpty then
    exit;

  GremiumUser.First;
  while not GremiumUser.Eof do
  begin
    m_client.RemoveMA(m_id, GremiumUser.FieldByName('PE_ID').AsInteger);
    GremiumUser.Next;
  end;
  GremiumUser.Refresh;
end;

end.
