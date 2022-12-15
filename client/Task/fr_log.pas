unit fr_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.OleCtrls,
  SHDocVw, Web.HTTPApp, Web.HTTPProd, Vcl.StdCtrls, Vcl.ExtCtrls, fr_textblock,
  fr_editForm, Vcl.ComCtrls, JvComponentBase, JvRichEditToHtml;

type
  TLogFrame = class(TFrame)
    PageProducer1: TPageProducer;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    WebBrowser1: TWebBrowser;
    TextBlockFrame1: TTextBlockFrame;
    EditFrame1: TEditFrame;
    JvRichEditToHtml1: TJvRichEditToHtml;
    RichEdit1: TRichEdit;
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TextBlockFrame1LabeledEdit1KeyPress(Sender: TObject;
      var Key: Char);
  private
    m_dataset : TDataSet;
  public
    procedure prepare;
    procedure release;

    procedure updateData( DataSet : TDataSet );

    procedure AddLogEntry(ta_id : integer );
  end;

implementation

uses
  m_html, m_glob_client, System.StrUtils;

{$R *.dfm}

{ TLogFrame }

procedure TLogFrame.AddLogEntry(ta_id : integer );
var
  text : string;
begin
  if not EditFrame1.Modified then
    exit;

  text := trim(EditFrame1.Text);
  if text = '' then
    exit;

  m_dataset.Append;
  m_dataset.FieldByName('TA_ID').AsInteger := ta_id;
  m_dataset.FieldByName('LT_ID').AsInteger := GM.autoInc('GEN_LT_ID');
  m_dataset.FieldByName('LT_REM').AsString := text;
  m_dataset.Post;
end;

procedure TLogFrame.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  text : string;
begin
  if sender = Source then
    exit;

  if (source = TextBlockFrame1.LV)  and( Sender = EditFrame1.RE) then
  begin
    if TextBlockFrame1.getContent(text) then
      EditFrame1.Add(text);
  end;
end;

procedure TLogFrame.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Sender = TextBlockFrame1.LV;
end;

procedure TLogFrame.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  ss : TStringStream;
  list : TStringList;
begin
       if SameText('user', TagString) then  ReplaceText := m_dataset.FieldByName('LT_NAME').AsString
  else if SameText('date', TagString) then  ReplaceText := DateToStr(m_dataset.FieldByName('LT_STAMP').AsDateTime)
  else if SameText('time', TagString) then  ReplaceText := timeToStr(m_dataset.FieldByName('LT_STAMP').AsDateTime)
  //else if SameText('rem', TagString) then   ReplaceText := System.StrUtils.ReplaceText( m_dataset.FieldByName('LT_REM').AsString, #$d#$a, '<br>');
  else if SameText('rem', TagString) then   begin
    ss := TStringStream.Create(m_dataset.FieldByName('LT_REM').AsString);
    ss.Position := 0;
    RichEdit1.Lines.LoadFromStream(ss);
    ss.Free;
    list := TSTringList.Create;
    JvRichEditToHtml1.ConvertToHtmlStrings(RichEdit1, list);
    ReplaceText := list.Text;
    list.Free;
  end;

end;

procedure TLogFrame.prepare;
begin
  m_dataset := NIL;
  EditFrame1.prepare;
  EditFrame1.Text := '';
  EditFrame1.Modified  := false;

  TextBlockFrame1.init(false);
  TextBlockFrame1.TagFilter := 'log';
end;

procedure TLogFrame.release;
begin
  EditFrame1.Release;
  m_dataset := NIL;
  TextBlockFrame1.release;
end;

procedure TLogFrame.TextBlockFrame1LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  TextBlockFrame1.LabeledEdit1KeyPress(Sender, Key);

end;

procedure TLogFrame.updateData(DataSet: TDataSet);
var
  st : TStream;
  list : TStringList;
  ss : TStringStream;
begin
  m_dataset := DataSet;

  st    := TMemoryStream.Create;
  list  := TStringList.Create;
  with dataset do begin
    last;
    while not bof do begin
      list.Text := PageProducer1.Content;
      Prior;

      ss := TStringStream.Create(list.Text);
      st.CopyFrom(ss, -1);
      ss.Free;
    end;

    list.Clear;
  end;

  THtmlMod.SetHTML(st, WebBrowser1 );

  list.Free;
end;

end.
