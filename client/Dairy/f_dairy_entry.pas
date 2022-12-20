unit f_dairy_entry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.ComCtrls,
  m_crypt;

type
  TDairyEntryForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    RE: TRichEdit;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    LabeledEdit2: TLabeledEdit;
    DSProviderConnection1: TDSProviderConnection;
    DITab: TClientDataSet;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_pwd   : string;
    m_id    : integer;
    function GetID: integer;
    procedure SetID(const Value: integer);
    function GetPasswort: string;
    procedure SetPasswort(const Value: string);
  public
    property ID: integer read GetID write SetID;
    property Passwort: string read GetPasswort write SetPasswort;
  end;

var
  DairyEntryForm: TDairyEntryForm;

implementation

uses
  m_glob_client;

{$R *.dfm}

procedure TDairyEntryForm.BaseFrame1OKBtnClick(Sender: TObject);
var
  st : TStream;
  mem : TStream;
begin
  if not DITab.Active then
    DITab.Open;

  if m_id = -1 then begin
    m_id :=  GM.autoInc('gen_di_id');
    DITab.Append;
    DITab.FieldByName('PE_ID').asInteger := GM.UserID;
    DITab.FieldByName('DI_STAMP').AsDateTime  := now;
  end else
    DITab.Edit;

  DITab.FieldByName('DI_TAGS').AsString     := LabeledEdit2.Text;

  st := DITab.CreateBlobStream(DITab.FieldByName('DI_TEXT'), bmWrite);
  if LabeledEdit1.Text <> '' then begin
    DITab.FieldByName('DI_CRYPTED').AsString := 'T';

    mem := TMemoryStream.Create;
    RE.Lines.SaveToStream(mem);
    mem.Position := 0;

    CryptMod.Password := LabeledEdit1.Text;
    CryptMod.Encrypt(mem, st);

    mem.Free;
  end
  else begin
    DITab.FieldByName('DI_CRYPTED').AsString := 'F';
    RE.Lines.SaveToStream(st);
  end;
  st.Free;

  DITab.Post;

  m_id := DITab.FieldByName('DI_ID').asInteger;

  if DITab.UpdatesPending then
    DITab.ApplyUpdates(0)
end;

procedure TDairyEntryForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_id := -1;
  RE.Lines.Clear;
end;

procedure TDairyEntryForm.FormDestroy(Sender: TObject);
begin
  if DITab.UpdatesPending then
    DITab.CancelUpdates;
end;

function TDairyEntryForm.GetID: integer;
begin
  Result := m_id;
end;

function TDairyEntryForm.GetPasswort: string;
begin
  Result := m_pwd;
end;

procedure TDairyEntryForm.SetID(const Value: integer);
var
  st  : TStream;
  mem : TStream;
begin
  m_id := value;
  if m_id <> -1 then begin
    DITab.Open;
    if DITab.Locate('DI_ID;PE_ID', VarArrayOf([m_id, GM.UserID]), []) then begin
      LabeledEdit2.Text := DITab.FieldByName('DI_TAGS').AsString;

      st := DITab.CreateBlobStream(DITab.FieldByName('DI_TEXT'), bmRead);
      mem := TMemoryStream.Create;

      st.Position := 0;
      (mem as TMemoryStream).Clear;

      CryptMod.Password := m_pwd;
      if CryptMod.Decrypt(st, mem) then begin
        mem.Position := 0;
        RE.Lines.LoadFromStream(mem);
      end else begin
        mem.Free;
        st.Free;
        raise Exception.Create('Falsches Passwort!');
      end;
      mem.Free;
      st.Free;
    end;
  end;
end;

procedure TDairyEntryForm.SetPasswort(const Value: string);
begin
  m_pwd := Value;
  LabeledEdit1.Text := m_pwd;
end;

procedure TDairyEntryForm.SpeedButton1Click(Sender: TObject);
begin
  if LabeledEdit1.PasswordChar = #0 then
    LabeledEdit1.PasswordChar := '*'
  else
    LabeledEdit1.PasswordChar := #0;
end;

end.
