unit f_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ClearFields(root : TComponent);
    procedure calcHeight(root : TComponent);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  vcl.grids, Grijjy.CloudLogging;

procedure TForm1.Button1Click(Sender: TObject);
var
  cm : TComponent;
  st : TStream;
begin
  st := TFileStream.Create('Mehrarbeit.dfm', fmOpenRead + fmShareDenyNone );
  cm := st.ReadComponent(Panel2);
  st.Free;

  if Assigned(cm) and ( cm is TPanel) then
  begin
    ( cm as TPanel).Color := Panel1.Color;
    ClearFields(cm);
    calcHeight(cm);
  end;
end;

procedure TForm1.calcHeight(root: TComponent);
var
  i : integer;
  max, val : integer;
  ctrl : TControl;
begin
  max := 0;
  for i := 0 to pred(root.ComponentCount) do
  begin
    if (root.Components[i] is TControl) then
    begin
      ctrl := (root.Components[i] as TControl);
      val := ctrl.BoundsRect.Top + ctrl.BoundsRect.Height;
      if val > max then
        max := val;
    end;
  end;
  ClientHeight := Panel1.Height + max + Panel3.Height+ StatusBar1.Height;
end;

procedure TForm1.ClearFields(root : TComponent);
  procedure doClear(ctrl : TComponent);
  var
    i : integer;
  begin
    for i := 0 to pred(ctrl.ComponentCount) do
    begin
      if (ctrl.Components[i] is TLabeledEdit) then
        (ctrl.Components[i] as TLabeledEdit).Text :=  ''
      else if (ctrl.Components[i] is TMemo) then
        (ctrl.Components[i] as TMemo).Lines.Text  := '';

      doClear(ctrl.Components[i]);
    end;
  end;

begin
  doClear(root);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  GrijjyLog.Connect(GrijjyLog.Broker, GrijjyLog.DEFAULT_SERVICE );
  GrijjyLog.EnterMethod(self, 'create');

  RegisterClass(TPanel);
  RegisterClass(TSPlitter);
  RegisterClass(TGroupBox);
  RegisterClass(TLabeledEdit);
  RegisterClass(TLabel);
  RegisterClass(TComboBox);
  RegisterClass(TMemo);
  RegisterClass(TStringGrid);
  GrijjyLog.ExitMethod(self, 'Create');
end;

end.
