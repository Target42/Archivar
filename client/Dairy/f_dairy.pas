unit f_dairy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBGrids,
  Vcl.ExtCtrls, u_ForceClose, Vcl.Grids, Vcl.Buttons, m_crypt, System.Actions,
  Vcl.ActnList;

type
  TDairyForm = class(TForm, IForceClose)
    StatusBar1: TStatusBar;
    DSProviderConnection1: TDSProviderConnection;
    DataQry: TClientDataSet;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DISrc: TDataSource;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    DataQryCryptText: TStringField;
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
    DataQryDI_ID: TIntegerField;
    DataQryPE_ID: TIntegerField;
    DataQryDI_STAMP: TSQLTimeStampField;
    DataQryDI_CRYPTED: TStringField;
    DataQryDI_TEXT: TBlobField;
    DataQryDI_TAGS: TStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataQryCryptTextGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DataQryAfterScroll(DataSet: TDataSet);
    procedure ac_addExecute(Sender: TObject);
    procedure ac_editExecute(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    m_date      : TDate;
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
  m_WindowHandler, m_glob_client, System.DateUtils, System.SysUtils,
  f_dairy_entry;

{$R *.dfm}

procedure TDairyForm.ac_addExecute(Sender: TObject);
begin
  Application.CreateForm(TDairyEntryForm, DairyEntryForm);
  try
    if DairyEntryForm.ShowModal = mrOk then
      DataQry.Refresh;
  finally
    DairyEntryForm.Free;
  end;
end;

procedure TDairyForm.ac_editExecute(Sender: TObject);
begin
  if DataQry.IsEmpty then exit;
  Application.CreateForm(TDairyEntryForm, DairyEntryForm);
  try
    DairyEntryForm.Passwort := LabeledEdit1.Text;
    try
      DairyEntryForm.ID := DataQryDI_ID.AsInteger;
      if DairyEntryForm.ShowModal = mrOk then
        DataQry.Refresh;
    except
      ShowMessage('Falsches Passwort!');
    end;
  finally
    DairyEntryForm.Free;
  end;

end;

procedure TDairyForm.DataQryAfterScroll(DataSet: TDataSet);
var
  crypt : TMemoryStream;
begin
  if m_inUpdate then exit;
  m_mem.Clear;
  RE.Lines.Clear;

  if SameText( DataQryDI_CRYPTED.AsString, 't') then begin
    CryptMod.Password := LabeledEdit1.Text;
    crypt := TMemoryStream.Create;

    try
      DataQryDI_TEXT.SaveToStream(crypt);
      CryptMod.Decrypt(crypt, m_mem);
    except
      on e : exception do begin
        ShowMessage(e.ToString);
      end;
    end;
    crypt.free;
  end else begin
    DataQryDI_TEXT.SaveToStream(m_mem);
  end;

  m_mem.Position := 0;
  Re.Lines.LoadFromStream(m_mem);
  // show text ...
end;

procedure TDairyForm.DataQryCryptTextGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := '';
  if DataQry.FieldByName('DI_CRYPTED').AsString = 'T' then
    Text := 'Ja';
end;

procedure TDairyForm.ForceClose(force: boolean);
begin
  if force then begin
  end;
  Self.Close;
end;

procedure TDairyForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDairyForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  WindowHandler.registerForm(self);
  m_mem   := TMemoryStream.Create;
  RE.Lines.Clear;
  setMonth( date );
end;

procedure TDairyForm.FormDestroy(Sender: TObject);
begin
  WindowHandler.unregisterForm(self);
  DairyForm := NIL;
  FreeAndNil(m_mem);
end;

procedure TDairyForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    DataQryAfterScroll( DataQry );
end;

procedure TDairyForm.setMonth(Month: TDate);
var
  d, m, y : word;
begin
  m_date := Month;
  DecodeDate(m_date, y, m, d);

  Label1.Caption := FormatDateTime('mmmm yyyy', m_date);
  DataQry.ParamByName('start').AsDate := EncodeDate(y, m, 1);
  DataQry.ParamByName('ende').AsDate  := EncodeDate(y, m, DaysInAMonth(y, m));
  m_inUpdate := true;
  DataQry.Open;

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
