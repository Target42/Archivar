unit f_bechlus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, fr_editForm, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Menus, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TBeschlusform = class(TForm)
    BaseFrame1: TBaseFrame;
    Splitter2: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox4: TGroupBox;
    ListView1: TListView;
    Panel4: TPanel;
    Splitter4: TSplitter;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Splitter5: TSplitter;
    ListView2: TListView;
    ListView3: TListView;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    EditFrame2: TEditFrame;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel2: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel3: TPanel;
    Button1: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button2: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    ListView4: TListView;
    TabSheet3: TTabSheet;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ac_p1_delete: TAction;
    Lschen1: TMenuItem;
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Beschlusform: TBeschlusform;

implementation

{$R *.dfm}

procedure TBeschlusform.ListView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

end.
