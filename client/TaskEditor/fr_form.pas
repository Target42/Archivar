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

    procedure getSize( var x, y : integer );

    procedure prepare;
    procedure release;
  end;

implementation

uses
  u_taskForm2XML, m_glob_client, Vcl.Grids;

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

procedure TFormFrame.getSize(var x, y: integer);

  procedure search( cmp : TComponent );
  var
    i, j  : integer;
    ctrl  : TControl;
    m     : integer;
    s     : string;
    sg    : TStringGrid;
  begin
    for i := 0 to pred(cmp.ComponentCount) do begin
      if cmp.Components[i] is TControl then begin
        ctrl := cmp.Components[i] as TControl;
        s := ctrl.name;
        m := 0;

        if ctrl is TStringGrid then begin
          sg := ctrl as TStringGrid;
          for j := 0 to pred(sg.ColCount) do
            m := m + SG.ColWidths[j] + 2;
        end
        else if not (ctrl.Align in [alClient, alTop, alBottom, alLeft, alRight]) then
          m := ctrl.Left + ctrl.Width;

        if m > X then
          X := m;

        if ctrl.Align <> alClient then begin
          m := ctrl.Top + ctrl.Height;
          if m > Y then
            Y := m;
        end;
      end;
      search(cmp.Components[i]);
    end;
  end;
begin
  X := 300;
  Y := 100;

  search(ScrollBox1);

  Y := y + 4;
  X := X + 16;
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
