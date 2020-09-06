unit u_TaskCtrlRichEdit;

interface

uses
  u_TaskCtrlImpl, i_taskEdit, Vcl.Controls, System.Classes;

type
  TaskCtrlRichEdit = class(TaskCtrlImpl)
    protected
      procedure setControlTypeProps; override;
      function  newControl(parent : TWinControl; x, y : Integer) :  TControl; override;
      procedure doSetMouse( md : TControlMouseDown; mv : TControlMouseMove; mu : TControlMouseUp ); override;
      function CtrlValue : string; override;
      procedure setReadOnly( value : boolean ); override;
      function  getReadOnly : boolean; override;

    private

    public
      constructor Create(owner : ITaskForm);
      destructor Destroy; override;

      procedure clearContent( recursive : boolean ); override;
  end;

implementation

uses
  Vcl.StdCtrls, Winapi.Windows, System.SysUtils, u_TaskCtrlPropImpl,
  Vcl.ComCtrls;


{ TaskCtrlRichEdit }

procedure TaskCtrlRichEdit.clearContent(recursive: boolean);
begin
  inherited;
  if not Assigned(m_ctrl) then
    exit;

  (m_ctrl as TRichEdit).Lines.Clear;
end;

constructor TaskCtrlRichEdit.Create(owner: ITaskForm);
begin
  inherited;
  m_canContainData  := true;
  m_typ             := ctRichEdit;
end;

function TaskCtrlRichEdit.CtrlValue: string;
begin
  Result := '';

  if Assigned( m_ctrl) then
    Result := trim( ( m_ctrl as TRichEdit).Text)
  else
    Result := self.propertyValue('Text');
end;

destructor TaskCtrlRichEdit.Destroy;
begin

  inherited;
end;

procedure TaskCtrlRichEdit.doSetMouse(md: TControlMouseDown;
  mv: TControlMouseMove; mu: TControlMouseUp);
begin
  inherited;
  ( m_ctrl as TRichEdit).OnMouseDown  := md;
  ( m_ctrl as TRichEdit).OnMouseUp    := mu;
  ( m_ctrl as TRichEdit).OnMouseMove  := mv;
end;

function TaskCtrlRichEdit.getReadOnly: boolean;
begin
  Result := false;
  if Assigned(m_ctrl) then
    Result := (m_ctrl as TRichEdit).ReadOnly;

end;

function TaskCtrlRichEdit.newControl(parent: TWinControl; x,
  y: Integer): TControl;
var
  ed : TRichEdit;
begin
  ed := TRichEdit.Create(Parent as TComponent);
  ed.Parent := Parent as TWinControl;
  ed.Name := 'RichEdit'+intToStr(GetTickCount);
  ed.Top  := y;
  ed.Left := X;
  ed.WordWrap := true;
  ed.ScrollBars := ssVertical;
  ed.OnKeyPress := KeyPress;

  Result := ed;
end;

procedure TaskCtrlRichEdit.setControlTypeProps;
begin
  inherited;
  m_props.Add(TaskCtrlPropImpl.create(self, 'Text',       'TStrings'));
  m_props.Add(TaskCtrlPropImpl.create(self, 'Datafield',  'TaskDataField'));
end;

procedure TaskCtrlRichEdit.setReadOnly(value: boolean);
begin
  if Assigned(m_ctrl) then
    (m_ctrl as TRichEdit).ReadOnly := value;

end;

end.
