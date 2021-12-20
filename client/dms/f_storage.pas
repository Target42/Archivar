unit f_storage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_file;

type
  TStorageForm = class(TForm)
    FileFrame1: TFileFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_drid : integer;
    function GetDirID: integer;
    procedure SetDirID(const Value: integer);
    function GetHeader: string;
    procedure SetHeader(const Value: string);
  public
    property Header: string read GetHeader write SetHeader;
    property DirID: integer read GetDirID write SetDirID;
  end;

var
  StorageForm: TStorageForm;

implementation

{$R *.dfm}

{ TStorageForm }

procedure TStorageForm.FormCreate(Sender: TObject);
begin
  FileFrame1.prepare;
end;

procedure TStorageForm.FormDestroy(Sender: TObject);
begin
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
