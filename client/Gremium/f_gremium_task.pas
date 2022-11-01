unit f_gremium_task;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client,
  Datasnap.DSConnect, u_dataset_to_list, Datasnap.DBClient, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.Generics.Collections, Vcl.ComCtrls, Vcl.Buttons;

type
  TGremiumTaskForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DSProviderConnection1: TDSProviderConnection;
    TYTab: TClientDataSet;
    GRTYTab: TClientDataSet;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    TYTabTY_ID: TIntegerField;
    TYTabTY_NAME: TStringField;
    TYTabTY_TAGE: TIntegerField;
    GRTYTabGR_ID: TIntegerField;
    GRTYTabTY_ID: TIntegerField;
    LVUsed: TListView;
    LVAll: TListView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure LVAllDblClick(Sender: TObject);
    procedure LVUsedDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    type
      TTaskType = class
        private
        FID: integer;
        FName: string;
        FTage: integer;
        public
          constructor create;
          Destructor Destroy; override;

          property ID: integer read FID write FID;
          property Name: string read FName write FName;
          property Tage: integer read FTage write FTage;
      end;
  private
    m_recordSet : TRecordSet;

    m_used : TList<TTaskType>;
    m_free : TList<TTaskType>;

    function  getItem( id : integer; var list : TList<TTaskType>) : TTaskType;
    procedure freeList( list: TList<TTaskType> );

    procedure fillAll;
    procedure fillSelected;

    procedure UpdateLV( LV : TListView; list : TList<TTaskType>);

    function GetRecordSet: TRecordSet;
    procedure SetRecordSet(const Value: TRecordSet);
  public
    property RecordSet: TRecordSet read GetRecordSet write SetRecordSet;
  end;

var
  GremiumTaskForm: TGremiumTaskForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

{ TGremiumTaskForm }

procedure TGremiumTaskForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  tt : TTaskType;
begin
  try
    GRTYTab.Filter   := 'GR_ID='+m_recordSet.FieldByName('GR_ID');
    GRTYTab.Filtered := true;
    GRTYTab.Open;
    while not GRTYTab.Eof do
      GRTYTab.Delete;

    for tt in m_used do begin
      GRTYTab.Append;
      GRTYTabGR_ID.AsString := m_recordSet.FieldByName('GR_ID');
      GRTYTabTY_ID.AsInteger:= tt.ID;
      GRTYTab.Post;
    end;
    if GRTYTab.UpdatesPending then
      GRTYTab.ApplyUpdates(0);

  except
    on e : exception do begin
      if GRTYTab.UpdatesPending then
        GRTYTab.CancelUpdates;
    end;
  end;
end;

procedure TGremiumTaskForm.fillAll;
var
  tt : TTaskType;
begin
  TYTab.Open;
  while not TYTab.Eof do begin
    tt := TTaskType.create;
    tt.ID   := TYTabTY_ID.AsInteger;
    tt.Name := TYTabTY_NAME.AsString;
    tt.Tage := TYTabTY_TAGE.AsInteger;
    m_free.Add(tt);

    TYTab.Next;
  end;
  TYTab.Close;
end;

procedure TGremiumTaskForm.fillSelected;
var
  tt : TTaskType;
begin
  GRTYTab.Filter   := 'GR_ID='+m_recordSet.FieldByName('GR_ID');
  GRTYTab.Filtered := true;
  GRTYTab.Open;

  while not GRTYTab.Eof do begin
    tt := getItem(GRTYTabTY_ID.AsInteger, m_free);
    if Assigned(tt) then
      m_used.Add(tt);
    GRTYTab.Next;
  end;
  GRTYTab.Close;
end;

procedure TGremiumTaskForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_recordSet := NIL;

  m_used := TList<TTaskType>.create;
  m_free := TList<TTaskType>.create;

  fillAll;
end;

procedure TGremiumTaskForm.FormDestroy(Sender: TObject);
begin
  if Assigned(m_recordSet) then
    FreeAndNil(m_recordSet);
  freeList(m_used);
  m_used.Free;

  freeList(m_free);
  m_free.Free;
end;

procedure TGremiumTaskForm.freeList(list: TList<TTaskType>);
var
  tt : TTaskType;
begin
  for tt in list do
    tt.Free;
  list.Clear;
end;

function TGremiumTaskForm.getItem(id: integer;
  var list: TList<TTaskType>): TTaskType;
var
  i : integer;
begin
  Result := NIL;
  for i := 0 to pred(list.Count) do begin
    if list[i].FID = id then begin
      Result := list[i];
      list.Delete(i);
      break;
    end;
  end;
end;

function TGremiumTaskForm.GetRecordSet: TRecordSet;
begin
  Result := m_recordSet;
end;

procedure TGremiumTaskForm.LVAllDblClick(Sender: TObject);
begin
  SpeedButton2.Click;
end;

procedure TGremiumTaskForm.LVUsedDblClick(Sender: TObject);
begin
  SpeedButton3.Click;
end;

procedure TGremiumTaskForm.SetRecordSet(const Value: TRecordSet);
begin
  m_recordSet := value;
  if Assigned(m_recordSet) then begin
    Caption := 'Augabentypen:' + m_recordSet.FieldByName('GR_NAME');

    fillSelected;

    UpdateLV(LVAll, m_free);
    UpdateLV(LVUsed, m_used);
  end;
end;

procedure TGremiumTaskForm.SpeedButton1Click(Sender: TObject);
var
  tt : TTaskType;
begin
  for tt in m_free do
    m_used.Add(tt);
  m_free.Clear;

  UpdateLV(LVAll, m_free);
  UpdateLV(LVUsed, m_used);
end;

procedure TGremiumTaskForm.SpeedButton2Click(Sender: TObject);
var
  tt : TTaskType;
begin
  if not Assigned(LVAll.Selected) then exit;

  tt := TTaskType( LVAll.Selected.Data );
  m_free.Remove(tt);
  m_used.Add(tt);
  UpdateLV(LVAll, m_free);
  UpdateLV(LVUsed, m_used);
end;

procedure TGremiumTaskForm.SpeedButton3Click(Sender: TObject);
var
  tt : TTaskType;
begin
  if not Assigned(LVUsed.Selected) then exit;

  tt := TTaskType( LVUsed.Selected.Data );

  m_used.Remove(tt);
  m_free.Add(tt);

  UpdateLV(LVAll, m_free);
  UpdateLV(LVUsed, m_used);
end;

procedure TGremiumTaskForm.SpeedButton4Click(Sender: TObject);
var
  tt : TTaskType;
begin
  for tt in m_used do
    m_free.Add(tt);
  m_used.Clear;

end;

procedure TGremiumTaskForm.UpdateLV(LV: TListView; list: TList<TTaskType>);
var
  tt : TTaskType;
  item : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;

  for tt in list do begin
    item := Lv.Items.Add;
    item.Data := tt;
    item.Caption := tt.Name;
    item.SubItems.Add(IntToStr(tt.Tage));
  end;
  LV.Items.EndUpdate;
end;

{ TGremiumTaskForm.TTaskType }

constructor TGremiumTaskForm.TTaskType.create;
begin

end;

destructor TGremiumTaskForm.TTaskType.Destroy;
begin

  inherited;
end;

end.
