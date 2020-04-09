unit u_taskEntry;

interface

uses
  Data.DB, System.Generics.Collections;
type
  TTaskEntry = class(TObject)
  private
    FTaskID: integer;
    FTaskName: string;
    FFlags: integer;
    FTaskType: string;
    FTermin: string;
    FTaskStart: string;
    m_status : string;

  protected

  public
    constructor Create;
    destructor Destroy; override;

    property TaskID: integer read FTaskID write FTaskID;
    property TaskName: string read FTaskName write FTaskName;
    property Flags: integer read FFlags write FFlags;
    property TaskType: string read FTaskType write FTaskType;
    property Termin: string read FTermin write FTermin;
    property TaskStart: string read FTaskStart write FTaskStart;
    property Status : string read m_status;

    procedure setData( dataset : TDataSet );

  end;
  TEntryList = TList<TTaskEntry>;
  TNotifyTaskEntryEvent = procedure (Sender: TObject; var dataList : TEntryList) of object;

implementation

uses
  System.SysUtils, u_Konst;

{ TTakEntry }

constructor TTaskEntry.Create;
begin
  inherited;

end;

destructor TTaskEntry.Destroy;
begin

  inherited;
end;

procedure TTaskEntry.setData(dataset: TDataSet);
begin
  FTaskID   := dataset.FieldByName('TA_ID').AsInteger;
  FTaskName := dataset.FieldByName('TA_NAME').ASString;
  FFlags    := dataset.FieldByName('TA_FLAGS').AsInteger;
  FTaskType := dataset.FieldByName('TY_NAME').ASString;
  FTermin   := FormatDateTime('dd.MM.yyyy', dataset.FieldByName('TA_TERMIN').AsDateTime);
  FTaskStart:= FormatDateTime('dd.MM.YYYY', dataset.FieldByName('TA_STARTED').AsDateTime);

  m_status := flagsToStr(dataset.FieldByName('TA_FLAGS').AsInteger);
end;

end.
