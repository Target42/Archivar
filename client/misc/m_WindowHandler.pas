unit m_WindowHandler;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Vcl.Forms, f_taskEdit,
  f_protokoll;

type
  TWindowHandler = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_taskMap     : TDictionary<integer,TTaskEditForm>;
    m_protocolMap : TDictionary<integer,TProtokollForm>;

  public
    procedure openTaskWindow( id, typeID : integer; ro : boolean );
    procedure closeTaskWindow( id : integer );
    function isTaskOpen( id : integer ) : Boolean;
    procedure closeTaksWindowMsg( id : integer; text : string );

    procedure openProtoCclWindow( id : integer ; ro : Boolean );
    procedure closeProtoclWindow( id : integer );
    function isProtocolOpen( id : integer ) : boolean;
    procedure closeProtocolWindowMsg( id : integer;  text : string );
  end;

var
  WindowHandler: TWindowHandler;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWindowHandler.closeTaskWindow(id: integer);
begin
  m_taskMap.Remove(id);
end;

procedure TWindowHandler.closeProtoclWindow(id: integer);
begin
  m_protocolMap.Remove(id);
end;

procedure TWindowHandler.closeProtocolWindowMsg(id: integer; text: string);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.ContainsKey(id) then
  begin
    frm := m_protocolMap[id];
    frm.Close;
    ShowMessage(text);
  end;
end;

procedure TWindowHandler.closeTaksWindowMsg(id: integer; text: string);
var
  frm : TTaskEditForm;
begin
  if m_taskMap.ContainsKey(id) then
  begin
    frm := m_taskMap[id];
    frm.Close;
    ShowMessage( text );
  end;
end;

procedure TWindowHandler.DataModuleCreate(Sender: TObject);
begin
  m_taskMap     := TDictionary<integer,TTaskEditForm>.create;
  m_protocolMap := TDictionary<integer,TProtokollForm>.Create;
end;

procedure TWindowHandler.DataModuleDestroy(Sender: TObject);
begin
  m_taskMap.Free;
  m_protocolMap.Free;
end;

function TWindowHandler.isProtocolOpen(id: integer): boolean;
begin
  Result := m_protocolMap.ContainsKey(id);
end;

function TWindowHandler.isTaskOpen(id: integer): Boolean;
begin
  Result := m_taskMap.ContainsKey(id);
end;

procedure TWindowHandler.openProtoCclWindow(id: integer; ro: Boolean);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.ContainsKey(id) then
  begin
    frm := m_protocolMap[id];
    frm.BringToFront;
    frm.WindowState := wsMaximized;
  end
  else
  begin
    Application.CreateForm(TProtokollForm, frm);
    frm.ID := id;
    frm.Show;
  end;
  frm.RO := ro;
  frm.Show;
end;

procedure TWindowHandler.openTaskWindow(id, typeID: integer; ro : boolean);
var
  TaskEditForm : TTaskEditForm;
begin
  if m_taskMap.ContainsKey(id) then
  begin
    TaskEditForm := m_taskMap[id];
    TaskEditForm.BringToFront;
    TaskEditForm.WindowState := wsMaximized;
  end
  else
  begin
    Application.CreateForm(TTaskEditForm, TaskEditForm);
    m_taskMap.Add(id, TaskEditForm);
    TaskEditForm.setID( id, typeID );
  end;
  TaskEditForm.RO := ro;
  TaskEditForm.Show;
  TaskEditForm.LockCheck;

end;

end.
