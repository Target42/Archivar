unit f_storage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_file, u_ForceClose;

type
  TStorageForm = class(TForm, IForceClose)
    FileFrame1: TFileFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    m_drid : integer;
    function GetDirID: integer;
    procedure SetDirID(const Value: integer);
    function GetHeader: string;
    procedure SetHeader(const Value: string);
  public
    property Header: string read GetHeader write SetHeader;
    property DirID: integer read GetDirID write SetDirID;

    procedure ForceClose( force : boolean);
  end;

var
  StorageForm: TStorageForm;

implementation

uses
  m_WindowHandler, system.UITypes;

{$R *.dfm}

{ TStorageForm }

procedure TStorageForm.ForceClose(force: boolean);
begin
  self.close;
end;

procedure TStorageForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TStorageForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  CanClose :=  MessageDlg('Soll die Ablage geschlossen werden?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TStorageForm.FormCreate(Sender: TObject);
begin
  FileFrame1.prepare;
end;

procedure TStorageForm.FormDestroy(Sender: TObject);
begin
  WindowHandler.closeStorage(FileFrame1.RootID);
  FileFrame1.release;
end;

function TStorageForm.GetDirID: integer;
begin
  Result := m_drid;
end;

function TStorageForm.GetHeader: string;
begin
  Result := Caption;
end;

procedure TStorageForm.SetDirID(const Value: integer);
begin
  m_drid := value;
  FileFrame1.RootID := m_drid;
end;

procedure TStorageForm.SetHeader(const Value: string);
begin
  Caption := Value;
end;

end.
