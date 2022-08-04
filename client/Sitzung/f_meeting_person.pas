unit f_meeting_person;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, u_stub, System.JSON, Vcl.Grids;

type
  TMeetingPersonForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TNQuery: TClientDataSet;
    OptTnQry: TClientDataSet;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    TNsrc: TDataSource;
    optSrc: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_prid : integer;
    m_client : TdsMeeingClient;
    procedure setPRID( value : integer );

    procedure send( req : TJSONObject );
  public
    property PR_ID : integer write setPRID;
    procedure open( tn, opt : TClientDataSet );
  end;

var
  MeetingPersonForm: TMeetingPersonForm;

implementation

uses
  m_glob_client, u_json;

{$R *.dfm}

procedure TMeetingPersonForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;

  m_prid    := 0;
  m_client  := NIL;
end;

procedure TMeetingPersonForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_client) then
    FreeAndNil(m_client);
end;

procedure TMeetingPersonForm.open(tn, opt: TClientDataSet);
begin
  if Assigned(tn) then
  begin
    TNsrc.DataSet := tn;
  end;
  if Assigned(opt) then
  begin
    optSrc.DataSet := opt;
  end;

  if not TNsrc.DataSet.Active then
    TNsrc.DataSet.Open;
  if not optSrc.DataSet.Active then
    optSrc.DataSet.Open;
end;

procedure TMeetingPersonForm.send(req: TJSONObject);
begin
  if not Assigned(m_client) then
    m_client := TdsMeeingClient.Create( GM.SQLConnection1.DBXConnection );

  m_client.changeUser(req);

  TNsrc.DataSet.Refresh;
  optSrc.DataSet.Refresh;
end;

procedure TMeetingPersonForm.setPRID(value: integer);
begin
  m_prid  := value;

  TNQuery.ParamByName('PR_ID').AsInteger  := m_prid;
  OptTnQry.ParamByName('PR_ID').AsInteger := m_prid;
end;

procedure TMeetingPersonForm.SpeedButton1Click(Sender: TObject);
var
  req : TJSONObject;
  arr : TJSONArray;
begin
  if optSrc.DataSet.IsEmpty then
    exit;
  req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'cmd', 'add');
  JReplace( req, 'prid', m_prid);

  DBGrid2.Enabled := false;

  with optSrc.DataSet do
  begin
    first;
    while not eof do
    begin
      arr.AddElement(TJSONNumber.Create( FieldByName('PE_ID').AsInteger));
      next;
    end;
  end;
  JReplace( req, 'idlist', arr);
  DBGrid2.Enabled := true;

  send(req);
end;

procedure TMeetingPersonForm.SpeedButton2Click(Sender: TObject);
var
  req : TJSONObject;
  arr : TJSONArray;
  i   : integer;
begin
  if optSrc.DataSet.IsEmpty then
    exit;
  req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'cmd', 'add');
  JReplace( req, 'prid', m_prid);

  DBGrid2.Enabled := false;
  for i := 0 to pred(DBGrid2.SelectedRows.Count) do
  begin
    optSrc.DataSet.GotoBookmark(DBGrid2.SelectedRows.Items[i]);
    arr.AddElement(TJSONNumber.Create( optSrc.DataSet.FieldByName('PE_ID').AsInteger));
  end;

  JReplace( req, 'idlist', arr);
  DBGrid2.Enabled := true;

  send(req);
end;

procedure TMeetingPersonForm.SpeedButton3Click(Sender: TObject);
var
  req : TJSONObject;
  arr : TJSONArray;
  i   : integer;
begin
  if TNsrc.DataSet.IsEmpty then
    exit;
  req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'cmd', 'remove');
  JReplace( req, 'prid', m_prid);

  DBGrid1.Enabled := false;
  for i := 0 to pred(DBGrid1.SelectedRows.Count) do
  begin
    TNsrc.DataSet.GotoBookmark(DBGrid1.SelectedRows.Items[i]);
    arr.AddElement(TJSONNumber.Create( TNsrc.DataSet.FieldByName('TN_ID').AsInteger));
  end;

  JReplace( req, 'idlist', arr);
  DBGrid1.Enabled := true;

  send(req);

end;

procedure TMeetingPersonForm.SpeedButton4Click(Sender: TObject);
var
  req : TJSONObject;
  arr : TJSONArray;
begin
  if TNsrc.DataSet.IsEmpty then
    exit;
  req := TJSONObject.Create;
  arr := TJSONArray.Create;
  JReplace( req, 'cmd', 'remove');
  JReplace( req, 'prid', m_prid);

  DBGrid1.Enabled := false;

  with TNsrc.DataSet do
  begin
    first;
    while not eof do
    begin
      arr.AddElement(TJSONNumber.Create( FieldByName('TN_ID').AsInteger));
      next;
    end;
  end;
  JReplace( req, 'idlist', arr);
  DBGrid1.Enabled := true;

  send(req);
end;

end.
