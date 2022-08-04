unit f_textblock_import;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls,
  JvDragDrop, Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  Vcl.Buttons, JvComponentBase;

type
  TTextblockImportForm = class(TForm)
    GroupBox1: TGroupBox;
    BaseFrame1: TBaseFrame;
    GroupBox2: TGroupBox;
    LV: TListView;
    JvDropTarget1: TJvDropTarget;
    DSProviderConnection1: TDSProviderConnection;
    TBtab: TClientDataSet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    FileOpenDialog1: TFileOpenDialog;
    procedure JvDropTarget1DragOver(Sender: TJvDropTarget;
      var Effect: TJvDropEffect);
    procedure JvDropTarget1DragDrop(Sender: TJvDropTarget;
      var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure JvDropTarget1DragAccept(Sender: TJvDropTarget;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    m_files : TStringList;
    procedure updateView;
  public
    { Public-Deklarationen }
  end;

var
  TextblockImportForm: TTextblockImportForm;

implementation

uses
  m_glob_client, xsd_TextBlock;

{$R *.dfm}

procedure TTextblockImportForm.BitBtn1Click(Sender: TObject);
var
  i : integer;
begin
  if FileOpenDialog1.Execute then begin
    for i := 0 to pred(FileOpenDialog1.Files.Count) do begin
      if m_files.IndexOf(FileOpenDialog1.Files[i]) = -1 then
        m_files.Add(FileOpenDialog1.Files[i]);
    end;
    updateView;
  end;
end;

procedure TTextblockImportForm.BitBtn2Click(Sender: TObject);
var
  i   : integer;
  inx : integer;
begin
  for i := pred(LV.Items.Count) downto 0 do begin
    if LV.Items.Item[i].Selected then begin
      inx := integer(LV.Items.Item[i].Data);
      m_files.Delete(inx);
    end;
  end;
  updateView;
end;

procedure TTextblockImportForm.BitBtn3Click(Sender: TObject);
var
  item    : TListItem;
  xBlock  : IXMLBlock;

  function loadXML(fname : string ) : boolean;
  begin
    Result := false;
    try
      xBlock := LoadBlock(fname);

      Result := true;
    except
      item.SubItems.Strings[0] := 'XML-Fehler';
    end;
  end;

  function findTB : boolean;
  begin
    Result := TBtab.Locate('TB_NAME', VarArrayOf([xBlock.Name]), [loCaseInsensitive]);
  end;
var
  i   : integer;
  inx : integer;
  st  : TStream;
begin
  TBtab.Open;
  for i := 0 to pred(LV.Items.Count) do begin
    item := LV.Items.Item[i];
    inx  := integer(item.Data);

    if loadXML(m_files[inx]) then begin
      if not findTB then begin

        TBtab.Append;
        TBtab.FieldByName('TB_ID').AsInteger := GM.autoInc('gen_tb_id');
        TBtab.FieldByName('TB_CLID').AsString:= xblock.Id;
        TBtab.FieldByName('TB_NAME').AsString:= xblock.Name;
        TBtab.FieldByName('TB_TAGS').AsString:= xblock.Tags;

        st := TBtab.CreateBlobStream(TBtab.FieldByName('TB_TEXT'), bmWrite);
        xBlock.OwnerDocument.SaveToStream(st);
        st.Free;

        try
          TBtab.Post;
          item.SubItems.Strings[0] := 'Ok'
        except
          begin
            item.SubItems.Strings[0] := 'DB Fehler';
            TBtab.Cancel;
          end;
        end;
      end;

    end;
  end;
  if TBtab.UpdatesPending then
    TBtab.ApplyUpdates(0);
end;

procedure TTextblockImportForm.FormCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_files := TStringList.Create;
end;

procedure TTextblockImportForm.FormDestroy(Sender: TObject);
begin
  m_files.Free;
end;

procedure TTextblockImportForm.JvDropTarget1DragAccept(Sender: TJvDropTarget;
  var Accept: Boolean);
begin
  Accept := true;
end;

procedure TTextblockImportForm.JvDropTarget1DragDrop(Sender: TJvDropTarget;
  var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
var
  list  : TStringList;
  i     : integer;
begin
  list := TStringList.Create;
  JvDropTarget1.GetFilenames(list);

  for i := 0 to pred(list.Count) do begin
    if m_files.IndexOf(list[i]) = -1 then
      m_files.Add(list[i]);
  end;

  list.Free;
  m_files.Sort;
  updateView;
end;

procedure TTextblockImportForm.JvDropTarget1DragOver(Sender: TJvDropTarget;
  var Effect: TJvDropEffect);
begin
  Effect := deLink;
end;

procedure TTextblockImportForm.updateView;
var
  i : integer;
  item  : TListItem;
begin
  LV.Items.BeginUpdate;
  LV.Items.Clear;
  for i := 0 to pred(m_files.Count) do begin
    item := LV.Items.Add;
    item.Caption := ExtractFileName(m_files[i]);
    item.SubItems.Add('');
    item.Data := Pointer(i);
  end;
  LV.Items.EndUpdate;
end;

end.
