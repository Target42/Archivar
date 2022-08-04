unit f_task_datafields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.DBGrids, i_datafields, Vcl.Grids;

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

    procedure setFields( value : IDataFieldList );
  public
    property Fields : IDataFieldList read m_fields write setFields;
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

    fd  := TDataField2XML.createFromDB(Datafields.FieldByName('DA_PROPS'));
    if not Assigned(fd) then
    begin
      fd := m_fields.newField(
        Datafields.FieldByName('DA_NAME').AsString,
        Datafields.FieldByName('DA_TYPE').AsString
      );
    end;
    fd.isGlobal := true;
    m_fields.add(fd);
  end;
end;

procedure TTaskDatafieldsForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
end;


procedure TTaskDatafieldsForm.open;
begin
  Datafields.Open;
end;

procedure TTaskDatafieldsForm.setFields(value: IDataFieldList);
begin
  m_fields := value;
end;

procedure TTaskDatafieldsForm.setServer(serv: TCustomRemoteServer);
begin
  Datafields.RemoteServer := serv;
end;

end.
