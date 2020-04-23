unit f_itemsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fr_base;

type
  TItemsEditorForm = class(TForm)
    BaseFrame1: TBaseFrame;
    Memo1: TMemo;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ItemsEditorForm: TItemsEditorForm;

implementation

{$R *.dfm}

end.
