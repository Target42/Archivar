unit fr_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, i_taskEdit,
  Datasnap.DBClient, Data.DB, Datasnap.DSConnect, m_taskLoader;

type
  TFormFrame = class(TFrame)
    ScrollBox1: TScrollBox;
  private
    m_loader : TTaskLoaderMod;
    m_form : ITaskForm;

    procedure setForm( value : ITaskForm);

    procedure setRO( value : boolean );
    function  getRO : boolean;

    function saveDataToStream( st : TStream )         : boolean;
  public
    property TaskForm       : ITaskForm       read m_form           write setForm;
    property ReadOnly       : boolean         read getRO            write setRO;

    function loadByID( taid : integer ) : boolean;

    procedure releaseData;

    function getHeight : integer;

    procedure prepare;
    procedure release;
  end;

implementation

uses
  u_taskForm2XML, m_glob_client;

{$R *.dfm}

{ TFrame1 }

function TFormFrame.getHeight: integer;
begin
  Result := 0;
  if Assigned(m_form) then
    Result := m_form.Base.getHeight;
end;

function TFormFrame.getRO: boolean;
begin
  Result := true;
  if Assigned(m_form) then
    Result := m_form.ReadOnly;
end;

function TFormFrame.loadByID(taid: integer): boolean;
var
  loader : TTaskForm2XML;
begin
  Result := false;

  if m_loader.load(taid) then
  begin
    m_form := m_loader.BuildForm(ScrollBox1);

    loader := TTaskForm2XML.create;
    loader.fillData( m_form, m_loader.TaskData);
    loader.Free;

    Result := Assigned(m_form);
  end;
end;

procedure TFormFrame.prepare;
begin
  m_loader := TTaskLoaderMod.Create(self);
  m_form  := NIL;
end;

procedure TFormFrame.release;
begin
  m_loader.Free;
  m_form  := NIL;
end;

procedure TFormFrame.releaseData;
begin
end;

function TFormFrame.saveDataToStream(st: TStream): boolean;
var
  writer : TTaskForm2XML;
begin
  if Assigned(m_form) and Assigned(st) then
  begin
    writer := TTaskForm2XML.create;
    writer.save(st, m_form);
    writer.Free;
  end;
  Result := Assigned(st) and ( st.Size > 0 );
end;

procedure TFormFrame.setForm(value: ITaskForm);
begin
  m_form := value;
  if Assigned(m_form) then begin
    m_form.Base.Control := ScrollBox1;
    m_form.Base.build;
    m_form.Base.clearContent(true);
  end;
end;

procedure TFormFrame.setRO(value: boolean);
begin
  if Assigned(m_form) then
    m_form.ReadOnly := value;
end;

end.
