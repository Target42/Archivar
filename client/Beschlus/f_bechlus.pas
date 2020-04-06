unit f_bechlus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_editForm, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TBeschlusform = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    ListView1: TListView;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Label1: TLabel;
    ListView2: TListView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Splitter2: TSplitter;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Panel5: TPanel;
    Label2: TLabel;
    ListBox1: TListBox;
    Splitter3: TSplitter;
    EditFrame1: TEditFrame;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Beschlusform: TBeschlusform;

implementation

{$R *.dfm}

end.
