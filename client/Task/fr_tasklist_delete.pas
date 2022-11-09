unit fr_tasklist_delete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Datasnap.DBClient, Datasnap.DSConnect, System.Generics.Collections,
  Vcl.ComCtrls;

type
  TUnusedTaskListFrame = class(TFrame)
    DSProviderConnection1: TDSProviderConnection;
    UnusedQry: TClientDataSet;
    LV: TListView;
    procedure LVCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVDblClick(Sender: TObject);
    type
      DataRec = class
        private
          FTitle: string;
          FTermin: TDateTime;
          FRest: integer;
          FType: string;
          FErzeugt: TDateTime;
          FEingang: TDate;
          FStatus: String;
          Fid: integer;
          Fty: integer;
          FFlags: integer;
          FIndex: integer;
          FRems: string;
          FColor: TColor;
        public
          constructor create;
          Destructor Destroy; override;

          property Title  : string      read FTitle   write FTitle;
          property Termin : TDateTime   read FTermin  write FTermin;
          property Rest   : integer     read FRest    write FRest;
          property Typ    : string      read FType    write FType;
          property Erzeugt: TDateTime   read FErzeugt write FErzeugt;
          property Eingang: TDate       read FEingang write FEingang;
          property Status : String      read FStatus  write FStatus;
          property id     : integer     read Fid      write Fid;
          property ty     : integer     read Fty      write Fty;
          property Flags  : integer     read FFlags   write FFlags;
          property Index  : integer     read FIndex   write FIndex;
          property Rem    : string      read FRems    write FRems;
          property Color  : TColor      read FColor   write FColor;
      end;
  private
    m_grid : integer;
    m_list : TList<DataRec>;

    m_checkList : TList<integer>;

    function GetGR_ID: integer;
    procedure SetGR_ID(const Value: integer);
    procedure clearList;
    procedure fillList;
    procedure UpdateView;

    function getCheckt : TList<integer>;
  public
    procedure prepare;
    procedure release;

    property GR_ID: integer read GetGR_ID write SetGR_ID;
    property Checked : TList<Integer> read getCheckt;
  end;

implementation

uses
  m_glob_client, u_Konst;

{$R *.dfm}

{ TUnusedTaskListFrame }

procedure TUnusedTaskListFrame.clearList;
var
  da : DataRec;
begin
  for da in m_list do
    da.Free;
  m_list.Clear;

end;

procedure TUnusedTaskListFrame.fillList;
var
  data : DataRec;
begin
  clearList;
  m_checkList.Clear;

  UnusedQry.ParamByName('GR_ID').AsInteger := m_grid;
  UnusedQry.Open;
  while not UnusedQry.Eof do
  begin
    data := DataRec.create;
    m_list.Add(data);

    data.Index    := m_list.Count-1;
    data.id       := UnusedQry.FieldByName('TA_ID').AsInteger;
    data.Title    := UnusedQry.FieldByName('TA_NAME').AsString;
    data.Typ      := UnusedQry.FieldByName('TY_NAME').AsString;
    data.Erzeugt  := UnusedQry.FieldByName('TA_CREATED').AsDateTime;
    data.Termin   := UnusedQry.FieldByName('TA_TERMIN').AsDateTime;
    data.Eingang  := UnusedQry.FieldByName('TA_STARTED').AsDateTime;
    data.Rest     := round(UnusedQry.FieldByName('TA_TERMIN').AsDateTime - now);
    data.Status   := UnusedQry.FieldByName('TA_STATUS').AsString;
    data.Flags    := UnusedQry.FieldByName('TA_FLAGS').AsInteger;
    data.Color    := TColor(UnusedQry.FieldByName('TA_COLOR').AsInteger );
    UnusedQry.Next;
  end;
  UnusedQry.Close;

  UpdateView;
end;

function TUnusedTaskListFrame.getCheckt: TList<integer>;
var
  i : integer;
  da : DataRec;
begin
  m_checkList.Clear;

  for i := 0 to pred(LV.Items.Count) do begin
    if LV.Items.Item[i].Checked then begin
      da := LV.Items.Item[i].Data;
      m_checkList.Add(da.id);
    end;
  end;
  Result := m_checkList;
end;

function TUnusedTaskListFrame.GetGR_ID: integer;
begin
  Result := m_grid;

end;

procedure TUnusedTaskListFrame.LVCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
{
  if (item.Index mod 2 = 0 ) then
    LV.Font.Color := clRed
  else
    LV.Font.Color := clBlue;}
end;

procedure TUnusedTaskListFrame.LVCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  d : DataRec;
begin
  d := item.Data;
  if  (SubItem = 2) and (d.Rest <= 0) then
    Sender.Canvas.Font.Color := clRed
  else
    Sender.Canvas.Font.Color := clBlack;
end;

procedure TUnusedTaskListFrame.LVDblClick(Sender: TObject);
begin
  if not Assigned(Lv.Selected) then exit;

  Lv.Selected.Checked := not Lv.Selected.Checked;
end;

procedure TUnusedTaskListFrame.prepare;
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_list := TList<DataRec>.create;
  m_checkList := TList<integer>.create;
end;

procedure TUnusedTaskListFrame.release;
begin
  clearList;
  m_list.Free;

  m_checkList.Free;
end;

procedure TUnusedTaskListFrame.SetGR_ID(const Value: integer);
begin
  m_grid := value;

  FillList;
  UpdateView;
end;

procedure TUnusedTaskListFrame.UpdateView;
var
  i : integer;
  item : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for i := 0 to pred(m_list.Count) do
  begin
    item := LV.Items.Add;
    item.Data := m_list[i];
    with m_list[i] do
    begin
      item.Caption := Title;
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Termin));
      if Rest > 0 then
        item.SubItems.Add(intToStr(Rest))
      else
        item.SubItems.Add('Abgelaufen('+IntToStr(Rest)+')');
      item.SubItems.Add(Typ);
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Erzeugt));
      item.SubItems.Add(FormatDateTime('dd.MM.yyyy', Eingang));
      item.SubItems.Add(flagsToStr(flags));
    end;
  end;
  LV.Items.EndUpdate;
end;

{ TUnusedTaskListFrame.DataRec }

constructor TUnusedTaskListFrame.DataRec.create;
begin

end;

destructor TUnusedTaskListFrame.DataRec.Destroy;
begin

  inherited;
end;

end.
