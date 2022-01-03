
unit u_Konst;

interface

uses
  System.Classes;

// Task flags
const
  taskNew         = $01;
  taskRead        = $02;
  taskInWork      = $04;
  taskWorkEnd     = $08;
  taskWaitForInfo = $10;
  taskWaitForOK   = $20;
  taskProtocol    = $40;

  taskAll         = taskNew or
                    taskRead or
                    taskInWork or
                    taskWorkEnd or
                    taskWaitForInfo or
                    taskWaitForOK or
                    taskProtocol;

  taskReady       = taskWaitForOK or
                    taskWaitForInfo or
                    taskProtocol;

// broadcast strings ..

const
  BRD_CHANNEL         : string = 'storage';
  BRD_TASK_MOVE       : string = 'task_move';       // taskmove
  BRD_TASK_DELETE     : string = 'task_delete';     // taskdelete
  BRD_MEETING_NEW     : string = 'meeting_new';     // newmeeting
  BRD_MEETING_UPDATE  : string = 'meeting_update';  // updatemeeting
  BRD_MEETING         : string = 'meeting';         // meeting
  BRD_ONLINE_USER     : string = 'online_user';     // onlineuser
  BRD_ONLINE_STATE    : string = 'online_state';    // userchangestate
  BRD_LEAD_REQ        : string = 'lead_req';        // requestlead
  BRD_LEAD_CHG        : string = 'lead_chg';        // changelead
  BRD_DOC_UPDATE      : string = 'doc_update';      // docupdate'
  BRD_VOTE            : string = 'vote';
  BRD_VOTE_START      : string = 'vote_start';
  BRD_VOTE_END        : string = 'vote_end';
  BRD_VOTE_LEAVE      : string = 'vote_leave';
  BRD_FILE_CACHE_UPT  : string = 'fc_update';
  BRD_FILE_CACHE_DEL  : string = 'fc_delete';
  BRD_FILE_CACHE_LOCK : string = 'fc_lock';
  BRD_FOLDER_NEW      : string = 'fld_new';
  BRD_FOLDER_REN      : string = 'fld_rename';
  BRD_FOLDER_DEL      : string = 'fld_del';
  BRD_FOLDER_UPDATE   : string = 'fld_update';
  BRD_STORE_UPDATE    : string = 'store_update';
  BRD_FILE_LOCK       : string = 'fi_lock';


const
  VOTE_YES      =  1;
  VOTE_NO       = -1;
  VOTE_CONTAIN  =  0;
  VOTE_NOT_DONE = -2;

function  flagsToStr( flags : integer ) : string;
procedure FillFlagslist( list : TStrings; filter : integer = 0 );

implementation

type
  FlagsRec = record
    Name : string;
    flag : integer;
  end;

var
  FlagData : array[0..6] of FlagsRec =
  (
    (name:'Neu';                        flag:taskNew),
    (name:'Gelesen';                    flag:taskRead),
    (name:'In Bearbeitung';             flag:taskInWork),
    (name:'Bearbeitung abgeschlossen';  flag:taskWorkEnd),
    (name:'Klärungsbedarf';             flag:taskWaitForInfo),
    (name:'Beschlusvorlage';            flag:taskWaitForOK),
    (name:'Protokoll';                  flag:taskProtocol)

  );

function flagsToStr( flags : integer ) : string;
var
  i : integer;
begin
  Result := 'Unbekannt';
  for i := Low(FlagData) to High(FlagData) do
  begin
    if (FlagData[i].flag and flags)  <> 0 then
    begin
      Result := FlagData[i].Name;
      break;
    end;
  end;
end;

procedure FillFlagslist(  list : TStrings ; filter : integer );
var
  i : integer;
begin
  if filter = 0 then
    filter := taskAll;

  for i := low(FlagData) to High(FlagData) do
  begin
    if (FlagData[i].flag and filter) <> 0 then
    begin
      list.AddObject(FlagData[i].Name, Pointer(FlagData[i].flag));
    end;
  end;
end;

end.
