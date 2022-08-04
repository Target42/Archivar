unit f_gremiumList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, fr_base, u_gremium,
  fr_gremium;

type
  TGremiumListForm = class(TForm)
    BaseFrame1: TBaseFrame;
    GremiumFrame1: TGremiumFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GremiumFrame1TVDblClick(Sender: TObject);
  private
    procedure setGremiumID( value : integer );
    function getGremiumID : Integer;

    function getGremium : TGremium;
  public
    property GremiumID : integer read getGremiumId write setGremiumID;
    property Gremium : TGremium read getGremium;
  end;

var
  GremiumListForm: TGremiumListForm;

implementation



{$R *.dfm}


procedure TGremiumListForm.FormCreate(Sender: TObject);
begin
  GremiumFrame1.init;
end;

procedure TGremiumListForm.FormDestroy(Sender: TObject);
begin
  GremiumFrame1.release;
end;

function TGremiumListForm.getGremium: TGremium;
begin
  Result :=GremiumFrame1.Gremium;
end;

function TGremiumListForm.getGremiumID: Integer;
begin
  Result := GremiumFrame1.GremiumID;
end;

procedure TGremiumListForm.GremiumFrame1TVDblClick(Sender: TObject);
begin
  BaseFrame1.OKBtn.Click;
end;

procedure TGremiumListForm.setGremiumID(value: integer);
begin
  GremiumFrame1.GremiumID := value;
end;

end.
