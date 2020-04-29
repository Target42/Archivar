unit u_TaskControlFactory;

interface

uses
  i_taskEdit, System.Generics.Collections;

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
  Winapi.Windows, System.SysUtils, u_TaskCtrlImpl, u_TaskCtrlLabel, u_TaskCtrlEdit,
  u_TaskCtrlGroupBox, u_TaskCtrlTable, u_TaskCtrlComboBox,
  u_TaskCtrlLabeledEdit, u_TaskCtrlTableField;

constructor TTaskControlFactory.Create;
begin
  inherited;
  m_map := TDictionary<string, TControlType>.create;

  m_map.Add(LowerCase('TLabel'),       ctLabel);
  m_map.Add(LowerCase('TEdit'),        ctEdit);
  m_map.Add(LowerCase('TLabeledEdit'), ctLabeledEdit);
  m_map.Add(LowerCase('TComboBox'),    ctComboBox );
  m_map.Add(LowerCase('TGroupBox'),    ctGroupBox );
  m_map.Add(LowerCase('TStringGrid'),  ctTable );
  m_map.Add(LowerCase('TTableField'),  ctTableField );
end;

function TTaskControlFactory.createControl(frm : ITaskForm; p: ITaskCtrl;
  newClass: string): ITaskCtrl;
var
  ct : TControlType;
begin
  ct := ctNone;

  newClass := lowerCase( newClass );
  if m_map.ContainsKey(newClass) then
    ct := m_map[newClass];

  Result := createControl( frm, p, ct, 0, 0);
end;

function TTaskControlFactory.createControl(frm : ITaskForm; p: ITaskCtrl; newType: TControlType;
  x, y: integer): ITaskCtrl;
begin
  Result := NIL;
  case newType of
    ctNone:         Result := TaskCtrlImpl.create(frm);
    ctEdit:         Result := TaskCtrlEdit.create(frm);
    ctLabeledEdit:  Result := TaskCtrlLabeledEdit.create(frm);
    ctComboBox:     Result := TaskCtrlComboBox.create(frm);
    ctLabel:        Result := TaskCtrlLabel.create(frm);
    ctGroupBox:     Result := TaskCtrlGroupBox.create(frm);
    ctPanel: ;
    ctMemo: ;
    ctRichEdit: ;
    ctRadio: ;
    ctRadioGrp: ;
    ctCheckBox: ;
    ctTable:       Result := TaskCtrlTable.create( frm );
    ctTableField:  Result := TaskCtrlTableField.create( frm );
  else
    Result := TaskCtrlImpl.create(frm);
  end;
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
