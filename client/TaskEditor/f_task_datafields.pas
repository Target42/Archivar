unit f_task_datafields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.Grids, Vcl.DBGrids, Data.SqlExpr, i_datafields;

type
  TTaskDatafieldsForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    Datafields: TClientDataSet;
    DataFieldsSrc: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_fields : IDataFieldList;

    procedure updateProps( field : IDataField );
  public
    property Fields : IDataFieldList read m_fields write m_fields;
    procedure setServer( serv : TCustomRemoteServer  );
    procedure open;
  end;

var
  TaskDatafieldsForm: TTaskDatafieldsForm;

implementation

uses
  m_glob_client, u_DataField2XML;

{$R *.dfm}

procedure TTaskDatafieldsForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  i    : integer;
  mark : TBookmark;
  fd   : IDataField;
begin
  for i := 0 to  pred(DBGrid1.SelectedRows.Count) do
  begin
    mark := DBGrid1.SelectedRows.Items[i];
    Datafields.GotoBookmark(mark);

    fd := m_fields.getByName( Datafields.FieldByName('DA_NAME').AsString);
    if not Assigned(fd) then
    begin
      fd := m_fields.newField( Datafields.FieldByName('DA_NAME').AsString,
      Datafields.FieldByName('DA_TYPE').AsString );
    end;
    updateProps( fd );
  end;
end;

procedure TTaskDatafieldsForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  Datafields.RemoteServer
end;


procedure TTaskDatafieldsForm.open;
begin
  Datafields.Open;
end;

procedure TTaskDatafieldsForm.setServer(serv: TCustomRemoteServer);
begin
  Datafields.RemoteServer := serv;
end;

procedure TTaskDatafieldsForm.updateProps(field: IDataField);
var
  st : TStream;
  ds : IDataField;
  xw : TDataField2XML;
  i  : integer;
begin
  field.isGlobal := true;

  xw := TDataField2XML.create;
  st := Datafields.CreateBlobStream(Datafields.FieldByName('DA_PROPS'), bmRead );
  ds := xw.loadFromStream(st);
  st.Free;
  xw.free;

  field.Rem   := ds.Rem;
  field.CLID  := ds.CLID;

  field.Properties.Clear;
  for i := 0 to pred(ds.Properties.Count) do
  begin
    field.Properties.Add(ds.Properties.Items[i]);
  end;

  ds.release;
  ds := NIL;

end;

end.
