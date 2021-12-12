unit u_TaskControlFactory;

interface

uses
  i_taskEdit, System.Generics.Collections, u_TaskCtrlEdit, u_TaskCtrlRichEdit;

type
  TTaskControlFactory = class sealed
  private
    class var Singleton : TTaskControlFactory;
    class var AllowFree : Boolean;

    m_map : TDictionary<string, TControlType>;
    constructor Create;
  public

    destructor Destroy; override;
    procedure FreeInstance; override;

    class function GetInstance : TTaskControlFactory;

    function createControl( frm : ITaskForm; p : ITaskCtrl; newType : TControlType; x, y : integer) : ITaskCtrl; overload;
    function createControl( frm : ITaskForm; p : ITaskCtrl; newClass : string ) : ITaskCtrl; overload;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, u_TaskCtrlImpl, u_TaskCtrlLabel,
  u_TaskCtrlGroupBox, u_TaskCtrlTable, u_TaskCtrlComboBox,
  u_TaskCtrlLabeledEdit, u_TaskCtrlTableField, u_TaskCtrlPanel, u_TaskCtrlMemo, u_TaskCtrlSpliter, u_taskCtrlRadio, u_TaskCtrlCheck,
  u_TaskCtrlRadioGroup, u_taskCtrlDateTimePicker;

constructor TTaskControlFactory.Create;
begin
  inherited;
  m_map := TDictionary<string, TControlType>.create;

  m_map.Add(LowerCase('TLabel'),          ctLabel);
  m_map.Add(LowerCase('TEdit'),           ctEdit);
  m_map.Add(LowerCase('TDAteTimePicker'), ctDateTimePicker);
  m_map.Add(LowerCase('TLabeledEdit'),    ctLabeledEdit);
  m_map.Add(LowerCase('TComboBox'),       ctComboBox );
  m_map.Add(LowerCase('TGroupBox'),       ctGroupBox );
  m_map.Add(LowerCase('TStringGrid'),     ctTable );
  m_map.Add(LowerCase('TTableField'),     ctTableField );
  m_map.Add(LowerCase('TMemo'),           ctMemo );
  m_map.Add(LowerCase('TRichEdit'),       ctRichEdit );
  m_map.Add(LowerCase('TSplitter'),       ctSpliter );
  m_map.Add(LowerCase('TPanel'),          ctPanel );
  m_map.Add(LowerCase('TRadioButton'),    ctRadio );
  m_map.Add(LowerCase('TCheckBox'),       ctCheckBox );
end;

function TTaskControlFactory.createControl(frm : ITaskForm; p: ITaskCtrl;
  newClass: string): ITaskCtrl;
var
  ct : TControlType;
begin
  newClass := lowerCase( newClass );
  Assert(m_map.ContainsKey(newClass), 'No Class mapping for ' + newClass);
  ct := m_map[newClass];

  Result := createControl( frm, p, ct, 0, 0);
end;

function TTaskControlFactory.createControl(frm : ITaskForm; p: ITaskCtrl; newType: TControlType;
  x, y: integer): ITaskCtrl;
begin
  Result := NIL;
  case newType of
    ctNone:           Result := TaskCtrlImpl.create(frm);
    ctEdit:           Result := TaskCtrlEdit.create(frm);
    ctLabeledEdit:    Result := TaskCtrlLabeledEdit.create(frm);
    ctComboBox:       Result := TaskCtrlComboBox.create(frm);
    ctLabel:          Result := TaskCtrlLabel.create(frm);
    ctGroupBox:       Result := TaskCtrlGroupBox.create(frm);
    ctPanel:          Result := TaskCtrlPanel.create(frm);
    ctMemo:           Result := TaskCtrlMemo.create( frm );
    ctRichEdit:       Result := TaskCtrlRichEdit.create(frm);
    ctRadio:          Result := TTaskCtrlRadio.create(frm);
    ctRadioGrp:       Result := TaskCtrlRadioGroup.Create(frm);
    ctCheckBox:       Result := TTaskCtrlCheck.create(frm);
    ctTable:          Result := TaskCtrlTable.create( frm );
    ctTableField:     Result := TaskCtrlTableField.create( frm );
    ctSpliter:        Result := TaskCtrlSplitter.Create(frm);
    ctDateTimePicker: Result := TaskCtrlDateTimePicker.create(frm);
  else
    Result := NIL;
  end;
  Assert(Result <> NIL, 'Control not found!');
end;

destructor TTaskControlFactory.Destroy;
begin
  inherited;
  m_map.Free;
end;

class function TTaskControlFactory.GetInstance: TTaskControlFactory;
var
  S: TTaskControlFactory;
begin
  if not Assigned(Singleton) then
  begin
    S := TTaskControlFactory.Create;
    if Assigned(InterlockedCompareExchangePointer(Pointer(Singleton), Pointer(S), nil)) then
      S.Free;
  end;
  Result := Singleton;
end;

procedure TTaskControlFactory.FreeInstance;
begin
  if AllowFree then
    inherited FreeInstance;
end;

initialization

finalization

  TTaskControlFactory.AllowFree := True;
  TTaskControlFactory.Singleton.Free;
end.
