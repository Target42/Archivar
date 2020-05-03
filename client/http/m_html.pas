unit m_html;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, xsd_TaskData,
  JvComponentBase, JvRichEditToHtml;

type
  THtmlMod = class(TDataModule)
    PageProducer1: TPageProducer;
    Frame: TPageProducer;
    JvRichEditToHtml1: TJvRichEditToHtml;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure FrameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
      TagParams: TStrings; var ReplaceText: string);
  private
    m_task : IXMLList;
    function getHTMLDocs : TStrings;
    function getField( name : string ) : string;
  public
    property HTMLDoc : TStrings read getHTMLDocs;
    property TaskData: IXMLList read m_task write m_task;

    function Content : string;
    procedure SaveToFile( fname : string );
  end;

var
  HtmlMod: THtmlMod;

implementation

uses
  System.StrUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ THtmlMod }

function THtmlMod.Content: string;
begin
  Result := PageProducer1.Content;
end;

procedure THtmlMod.DataModuleCreate(Sender: TObject);
begin
  m_task := NIL;
end;

procedure THtmlMod.DataModuleDestroy(Sender: TObject);
begin
  m_task := NIL;
end;

procedure THtmlMod.FrameHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(TagString);

  if cmd = 'data' then
    ReplaceText := PageProducer1.Content;

end;

function THtmlMod.getField(name: string): string;
var
  i : integer;
begin
  for i := 0 to pred( m_task.Values.Count) do
  begin
    if SameText( name, m_task.Values.Field[i].Field) then
    begin
      Result := ReplaceText( m_task.Values.Field[i].Value, #$A, '<br>' );
    end;
  end;
  if Trim(Result) = '' then
    Result := '&nbsp;';
end;

function THtmlMod.getHTMLDocs: TStrings;
begin
  Result := PageProducer1.HTMLDoc;
end;

procedure THtmlMod.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  cmd : string;
begin
  cmd := LowerCase(tagString);

  if cmd = 'field' then
  begin
    if TagParams.Count>0 then
    ReplaceText := getField(  TagParams.Strings[0]);
  end;
end;

procedure THtmlMod.SaveToFile(fname: string);
var
  list : TStringList;
begin

  list := TStringList.Create;
  try
    list.Text := Frame.Content;
    list.SaveToFile(fname);
  finally
    list.Free;
  end;
end;

end.
