unit f_select_dictinonary;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TSelectDictionaryForm = class(TForm)
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpellList: TListView;
    HyphenList: TListView;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure UpdateDicts;
  public
    { Public-Deklarationen }
  end;

var
  SelectDictionaryForm: TSelectDictionaryForm;

function ShowSelectDictionary : boolean;

implementation

uses
  NHunspell;

{$R *.dfm}

function ShowSelectDictionary : boolean;
begin
  Result := false;
  try
    Application.CreateForm(TSelectDictionaryForm, SelectDictionaryForm);
    Result := SelectDictionaryForm.ShowModal = mrOk;
  except

  end;
  SelectDictionaryForm.Free;
end;

{ TSelectDictionaryForm }

procedure TSelectDictionaryForm.BitBtn2Click(Sender: TObject);
begin
  if Assigned(SpellList.Selected) then begin
    Hunspell.SelectSpellDictionary(integer(SpellList.Selected.Data));
  end;
  if Assigned(HyphenList.Selected) then begin
    Hunspell.SelectHyphenDictionary(integer(HyphenList.Selected.Data));
  end;

end;

procedure TSelectDictionaryForm.FormCreate(Sender: TObject);
begin
  UpdateDicts;
end;

procedure TSelectDictionaryForm.UpdateDicts;
var
  intIndex : integer;
  item     : TListItem;
begin
  with SpellList do
  try
    Items.BeginUpdate;
    clear;
    for intIndex := 0 to Hunspell.SpellDictionaryCount-1 do begin
      item := Items.Add;
      item.Caption := Hunspell.SpellDictionaries[intIndex].LanguageName;
      item.SubItems.Add(Hunspell.SpellDictionaries[intIndex].Version);
      item.SubItems.Add(Hunspell.SpellDictionaries[intIndex].DisplayName );
      item.Data := Pointer(intindex);
      if Hunspell.SpellDictionaries[intIndex] = Hunspell.SpellDictionary then
        Selected := item;
    end;
  finally
    Items.EndUpdate;
  end;
  with HyphenList do
  try
    Items.BeginUpdate;
    clear;
    for intIndex := 0 to Hunspell.HyphenDictionaryCount-1 do begin
      item := Items.Add;
      item.Caption := Hunspell.HyphenDictionaries[intIndex].LanguageName;
      item.SubItems.Add(Hunspell.HyphenDictionaries[intIndex].Version);
      item.SubItems.Add(Hunspell.HyphenDictionaries[intIndex].DisplayName );
      item.Data := Pointer(intindex);
      if Hunspell.HyphenDictionaries[intIndex] = Hunspell.HyphenDictionary then
        Selected := item;
    end;
  finally
    Items.EndUpdate;
  end;
end;

end.
