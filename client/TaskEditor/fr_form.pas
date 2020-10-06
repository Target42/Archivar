unit fr_form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, i_taskEdit,
  Datasnap.DBClient;

type
  TFormFrame = class(TFrame)
    ScrollBox1: TScrollBox;
  private
    m_form : ITaskForm;
    m_tc   : ITaskContainer;

    function GetTaskContainer: ITaskContainer;
    procedure SetTaskContainer(const Value: ITaskContainer);
    procedure setForm( value : ITaskForm);

    procedure setRO( value : boolean );
    function  getRO : boolean;

  public
    property TaskContainer: ITaskContainer read GetTaskContainer write SetTaskContainer;
    property TaskForm : ITaskForm read m_form write setForm;

    property ReadOnly : boolean read getRO write setRO;

    function loadTask( dataset : TClientDataset ): boolean;

    function loadData( st : TStream ) : boolean; overload;
    function loadData( dataset : TClientDataset ) : boolean; overload;
    function saveDataToStream( st : TStream ): boolean;

    procedure releaseData;
    procedure prepare;
    procedure release;
  end;

implementation

uses
  u_taskForm2XML, Data.DB;

{$R *.dfm}

{ TFrame1 }

function TFormFrame.getRO: boolean;
begin
  Result := true;
  if Assigned(m_form) then
    Result := m_form.ReadOnly;
end;

function TFormFrame.GetTaskContainer: ITaskContainer;
begin
  Result := m_tc;
end;

function TFormFrame.loadData(st: TStream): boolean;
var
  loader : TTaskForm2XML;
begin
  Result := false;
  if Assigned(st) and (st.Size > 0) then
  begin
    loader := TTaskForm2XML.create;
    loader.load( st, m_form);
    loader.Free;
    Result := true;
  end;
end;

function TFormFrame.loadData(dataset: TClientDataset): boolean;
var
  st : TStream;
begin
  st := dataset.CreateBlobStream(dataset.FieldByName('TA_DATA'), bmRead);
  self.loadData(st);
  st.Free;
  Result := true;
end;

function TFormFrame.loadTask(dataset: TClientDataset): boolean;
var
  st  : TStream;
begin
  if not dataset.IsEmpty then
  begin
   st   := dataset.CreateBlobStream(dataset.FieldByName('TE_DATA'), bmRead);
   m_tc := loadTaskContainer(st, dataset.FieldByName('TE_NAME').AsString);

   self.SetTaskContainer(m_tc);
  end;
  Result := Assigned(m_tc) and Assigned(m_form);
end;

procedure TFormFrame.prepare;
begin
  m_form  := NIL;
  m_tc    := NIL;
end;

procedure TFormFrame.release;
begin
  m_form  := NIL;
  m_tc    := NIL;
end;

procedure TFormFrame.releaseData;
begin
  if Assigned(m_tc) then
  begin
    m_tc.release;
    m_tc := NIL;
  end;
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

procedure TFormFrame.SetTaskContainer(const Value: ITaskContainer);
begin
  m_tc := value;
  if Assigned(m_tc) then begin
    setForm(m_tc.Task.getMainForm);
  end;
end;

end.
