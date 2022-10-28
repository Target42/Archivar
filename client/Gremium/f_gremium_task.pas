unit f_gremium_task;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base;

type
  TGremiumTaskForm = class(TForm)
    BaseFrame1: TBaseFrame;
  private
    m_id : integer;
    function GetID: integer;
    procedure SetID(const Value: integer);
  public
    property ID: integer read GetID write SetID;
  end;

var
  GremiumTaskForm: TGremiumTaskForm;

implementation

{$R *.dfm}

{ TGremiumTaskForm }

function TGremiumTaskForm.GetID: integer;
begin
  Result := m_id;
end;

procedure TGremiumTaskForm.SetID(const Value: integer);
begin
  m_id := value;
end;

end.
