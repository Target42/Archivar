unit fr_storages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  System.JSON, Vcl.Menus, System.Actions, Vcl.ActnList, m_WindowHandler;

type
  TStoragesFrame = class(TFrame)
    LV: TListView;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ac_open: TAction;
    ffnen1: TMenuItem;
    procedure ac_openExecute(Sender: TObject);
    procedure LVDblClick(Sender: TObject);
  private
    m_data : TJSONObject;
    procedure addNew( const arg : TJSONObject );
  public
    procedure prepare;
    procedure release;

    procedure updateStorages;

    function handle_storage_upd( const arg : TJSONObject ) : boolean;
  end;

implementation

uses
  m_glob_client, u_json, u_eventHandler, u_Konst;

{$R *.dfm}

{ TStoragesFrame }

procedure TStoragesFrame.ac_openExecute(Sender: TObject);
var
  row : TJSONObject;
begin
  if not Assigned(LV.Selected) then
    exit;
  row := TJSONObject(LV.Selected.Data);
  try
    WindowHandler.openStorage( JInt( row, 'id'), JString(row, 'name'));
  except

  end;

end;

procedure TStoragesFrame.addNew(const arg: TJSONObject);
var
  arr : TJSONArray;
  row : TJSONObject;
  item: TListItem;
begin
  arr :=JArray(m_data, 'items');
  if not Assigned(arr) then begin
    updateStorages;
    exit;
  end;
  row := TJSONObject.Create;
  JReplace( row, 'name',  JString( arg, 'name'));
  JReplace( row, 'id',    JInt( arg, 'id'));
  JReplace( row, 'drid',  JInt(arg, 'drid'));
  arr.AddElement(row);

  item          := LV.Items.Add;
  item.Data     := row;
  item.Caption  := JString( arg, 'name');

end;

function TStoragesFrame.handle_storage_upd(const arg: TJSONObject): boolean;
var
  id  : integer;
  row : TJSONObject;
  i   : integer;
  cmd : string;
  fldname : string;
begin
  cmd := JString(arg,   'cmd');
  Result := true;

       if SameText(cmd, 'refresh')  then updateStorages
  else if SameText(cmd, 'new')      then addNew( arg )
  else if SameText(cmd, 'update')   then begin
    id := JInt( arg, 'id');

    for i := 0 to pred(LV.Items.Count) do begin
      row := TJSONObject(LV.Items.Item[i].Data);
      if JInt(row, 'id') = id then begin
        fldName := JString( arg, 'name');

        JReplace( row, 'name', fldName);
        LV.Items.Item[i].Caption := fldName;
        break;
      end;
    end;
  end else
    Result := false;
end;

procedure TStoragesFrame.LVDblClick(Sender: TObject);
begin
  ac_open.Execute;
end;

procedure TStoragesFrame.prepare;
begin
  m_data := NIL;

  EventHandler.Register( self, handle_storage_upd,   BRD_STORE_UPDATE );
end;

procedure TStoragesFrame.release;
begin
  EventHandler.Unregister( self );

  if Assigned(m_data) then
    m_data.free;
end;

procedure TStoragesFrame.updateStorages;
var
  arr   : TJSONArray;
  row   : TJSONObject;
  i     : integer;
  item  : TListItem;
begin
  if Assigned(m_data) then
    m_data.Free;
  m_data := GM.getStorageList;

  LV.Items.BeginUpdate;
  LV.Items.Clear;

  arr := JArray(m_data, 'items');
  if Assigned(arr) then begin
    for i := 0 to pred(arr.Count) do begin
      row           := getRow(arr, i);
      item          := LV.Items.Add;
      item.Data     := row;
      item.Caption  := JString( row, 'name');
    end;
  end;
  LV.Items.EndUpdate;
end;

end.
