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
    m_form : ITaskForm;

    procedure setForm( value : ITaskForm);

    procedure setRO( value : boolean );
    function  getRO : boolean;

  public
    property TaskForm       : ITaskForm       read m_form           write setForm;
    property ReadOnly       : boolean         read getRO            write setRO;

    function loadByID( taid : integer ) : boolean;

    procedure releaseData;

    function getHeight : integer;

    procedure resizeForm;

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
  FormLoader : TTaskForm2XML;
  taskLoader : TTaskLoaderMod;
begin
  Result := false;

  taskLoader := TTaskLoaderMod.Create(self);
  if taskLoader.load(taid) then
  begin
    m_form := taskLoader.BuildForm(ScrollBox1);

    FormLoader := TTaskForm2XML.create;
    FormLoader.fillData( m_form, taskLoader.TaskData);
    FormLoader.Free;

    Result := Assigned(m_form);
  end;
  FreeAndNil(taskLoader);
end;

procedure TFormFrame.prepare;
begin
  m_form  := NIL;
end;

procedure TFormFrame.release;
begin
  m_form  := NIL;
end;

procedure TFormFrame.releaseData;
begin
end;

procedure TFormFrame.resizeForm;
var
  i : integer;
  max : integer;
  m   : integeR;
  ctrl : TControl;
  dif   : integer;
begin
  max := 0;
  for i := 0 to pred(ScrollBox1.ComponentCount) do
  begin
    ctrl := ScrollBox1.Components[i] as TControl;
    m := ctrl.Top + ctrl.Height;
    if m > max then
      max := m;
  end;
  dif := max - ScrollBox1.ClientHeight;
  if dif > 0 then
    self.ClientHeight := self.ClientHeight + dif;
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
