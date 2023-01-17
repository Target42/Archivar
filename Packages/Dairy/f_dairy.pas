unit f_dairy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBGrids,
  Vcl.ExtCtrls, u_ForceClose, Vcl.Grids, Vcl.Buttons, System.Actions,
  Vcl.ActnList, u_ICrypt;

type
  TDairyForm = class(TForm, IForceClose)
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
    DiQry: TClientDataSet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DISrc: TDataSource;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    DiQryDI_ID: TAutoIncField;
    DiQryPE_ID: TIntegerField;
    DiQryDI_STAMP: TSQLTimeStampField;
    DiQryDI_CRYPTED: TStringField;
    DiQryDI_TEXT: TBlobField;
    DiQryDI_TAGS: TStringField;
    DiQryCryptText: TStringField;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    RE: TRichEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    ac_add: TAction;
    ac_edit: TAction;
    ac_delete: TAction;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DiQryCryptTextGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DiQryAfterScroll(DataSet: TDataSet);
    procedure ac_addExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    m_date      : TDate;
    m_crypt     : ICrypt;
    m_inUpdate  : boolean;
    m_mem       : TMemoryStream;
    procedure setMonth( Month : TDate );
  public
    procedure ForceClose( force : boolean);
  end;

var
  DairyForm: TDairyForm;

implementation

uses
  System.DateUtils, System.SysUtils,
  f_dairy_entry, u_TPluginDairy;

{$R *.dfm}

procedure TDairyForm.ac_addExecute(Sender: TObject);
begin
  DairyEntryForm := TDairyEntryForm.Create(self);
  try
    if DairyEntryForm.ShowModal = mrOk then
      DiQry.Refresh;
  finally
    DairyEntryForm.Free;
  end;
end;

procedure TDairyForm.ac_editExecute(Sender: TObject);
begin
  if DiQry.IsEmpty then exit;

  DairyEntryForm := TDairyEntryForm.Create(self);

  PluginDairy.PosWindow(self, DairyEntryForm);
  //DairyEntryForm.Parent := self;
  try
    DairyEntryForm.Passwort := LabeledEdit1.Text;
    try
      DairyEntryForm.ID := DiQryDI_ID.AsInteger;
      if DairyEntryForm.ShowModal = mrOk then
        DiQry.Refresh;
    except
      ShowMessage('Falsches Passwort!');
    end;
  finally
    DairyEntryForm.Free;
  end;

end;

procedure TDairyForm.DiQryAfterScroll(DataSet: TDataSet);
var
  crypt : TMemoryStream;
begin
  if m_inUpdate then exit;
  m_mem.Clear;
  RE.Lines.Clear;

  if SameText(DiQryDI_CRYPTED.AsString, 't') then begin
    //m_crypt.Password := LabeledEdit1.Text;
    m_crypt.pPassword := PChar(LabeledEdit1.Text);
    crypt := TMemoryStream.Create;

    try
      DiQryDI_TEXT.SaveToStream(crypt);
      m_crypt.Decrypt(crypt, m_mem);
    except
      on e : exception do begin
        ShowMessage(e.ToString);
      end;
    end;
    crypt.free;
  end else begin
    DiQryDI_TEXT.SaveToStream(m_mem);
  end;

  m_mem.Position := 0;
  Re.Lines.LoadFromStream(m_mem);
  // show text ...
end;

procedure TDairyForm.DiQryCryptTextGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := '';
  if DiQry.FieldByName('DI_CRYPTED').AsString = 'T' then
    Text := 'Ja';
end;

procedure TDairyForm.ForceClose(force: boolean);
begin
  if force then begin
    m_crypt.pPassword := NIL;
  end;
  Self.Close;
end;

procedure TDairyForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  DairyForm := NIL;
end;

procedure TDairyForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := PluginDairy.Data.SqlConnection;
  PluginDairy.Data.WndHandler.registerForm(self);

  m_crypt := PluginDairy.Data.Crypt;
  m_mem   := TMemoryStream.Create;
  RE.Lines.Clear;
  setMonth( date );
end;

procedure TDairyForm.FormDestroy(Sender: TObject);
begin
  m_crypt.pPassword := NIL;

  PluginDairy.Data.WndHandler.unregisterForm(self);
  DairyForm := NIL;
  FreeAndNil(m_mem);
  m_crypt := NIL;
end;

procedure TDairyForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    DiQryAfterScroll( DiQry );
end;

procedure TDairyForm.setMonth(Month: TDate);
var
  d, m, y : word;
begin
  m_date := Month;
  DecodeDate(m_date, y, m, d);

  Label1.Caption := FormatDateTime('mmmm yyyy', m_date);
  DiQry.ParamByName('start').AsDate := EncodeDate(y, m, 1);
  DiQry.ParamByName('ende').AsDate  := EncodeDate(y, m, DaysInAMonth(y, m));
  m_inUpdate := true;
  DiQry.Open;

  m_inUpdate := false;
end;

procedure TDairyForm.SpeedButton1Click(Sender: TObject);
begin
  setMonth(IncMonth(m_date,  -1));
end;

procedure TDairyForm.SpeedButton2Click(Sender: TObject);
begin
  setMonth(IncMonth(m_date,  +1));
end;

initialization
  DairyForm := NIL;

end.
