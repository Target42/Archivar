﻿unit u_TMail;

interface

uses
  System.Classes, IdMessage, Vcl.Imaging.pngimage, Vcl.Graphics;

type
  TMail = class
    private
      FTitel: string;
      FAbsender: string;
      FSendDate: string;
      FSendTime: string;
      FAdresse: string;
      FKategorie: string;
      FMessage : TIdMessage;
      FTimeStamp: TDateTime;
      FAttachments: boolean;
      m_png : TPngImage;
      m_bmp : TBitmap;
      FHeadline : string;
      FID: integer;
      FStatus: string;
      FMEsgID: string;

      procedure processMailData;
      procedure SetKategorie( value : string );
      procedure fillHeadline;
    public
      constructor create;
      destructor Destroy;  override;

      property ID: integer read FID write FID;
      property MesgID: string read FMEsgID write FMEsgID;
      property Titel: string read FTitel write FTitel;
      property Absender: string read FAbsender write FAbsender;
      property Adresse: string read FAdresse write FAdresse;
      property SendDate: string read FSendDate write FSendDate;
      property SendTime: string read FSendTime write FSendTime;
      property TimeStamp: TDateTime read FTimeStamp write FTimeStamp;
      property Attachments: boolean read FAttachments write FAttachments;
      property Attachment: TPngImage read m_png;
      property Message : TIdMessage read FMessage;
      property HeadLine: string read FHeadline;

      property Kategorie: string read FKategorie write SetKategorie;
      property Katbmp : TBitmap read m_bmp;
      property Status: string read FStatus write FStatus;

      function loadFromFile( fname : string ) : boolean;
      function loadFromStream( st : TStream ) : boolean;
      function exportMail( path : string; Attachements : boolean = false ) : boolean;
  end;

function LoadMail( fname : string ) : TMail;

procedure setColors( list : TStrings);

implementation

uses
  System.SysUtils, System.Types, System.StrUtils, IdAttachmentFile, IdText,
  System.IOUtils;

{ TMail }

var
  kats : TStringList;

function LoadMail( fname : string ) : TMail;
begin
  Result := TMail.create;
  if not Result.loadFromFile(fname) then
    FreeAndNil(Result);
end;

procedure setColors( list : TStrings);
begin
  kats.Assign(list);
end;

constructor TMail.create;
begin
  FID           := 0;
  FMessage      := TIdMessage.Create;
  FAttachments  := false;
  m_png         := TPngImage.Create;
  m_bmp         := TBitmap.Create;
  m_bmp.SetSize(16, 16);
end;

destructor TMail.Destroy;
begin
  m_png.Free;
  m_bmp.Free;
  FMessage.Free;
  inherited;
end;

function TMail.exportMail(path: string; Attachements: boolean): boolean;
var
  fname : string;
  i     : integer;
begin
  fname := self.Titel;
  for i := 1 to length(fname) do
  begin
    if not TPath.IsValidFileNameChar(fname[i]) then
      fname[i] := '_';
  end;
  path := TPath.Combine(path, fname +'.mail');
  ForceDirectories(fname);
  FMessage.SaveToFile(TPAth.Combine(path, 'mail.eml'));

  if not Attachements or not FAttachments then
    exit;

  FMessage.MessageParts.Items[0].PartType

end;

procedure TMail.fillHeadline;
var
  i : integer;
  text : string;
  html : string;
  function StripHTMLTags(const strHTML: string): string;
  var
    P: PChar;
    InTag: Boolean;
    i : Integer;
    s : string;
  begin
    i := Pos('</head>', strHTML );
    if i > -1 then
      s := copy( strHTML, i + 7, Length(strHTML) )
    else s := strHTML;

    P := PChar(s);
    Result := '';

    InTag := False;
    repeat
      case P^ of
        '<': InTag := True;
        '>': InTag := False;
        #13, #10: ; {do nothing}
        else
          if not InTag then
          begin
            if not (CharInSet(P^, [#9, #32]) and CharInSet((P+1)^, [#10, #13, #32, #9, '<'])) then
//            else
              Result := Result + P^;
          end;
      end;
      Inc(P);
    until (P^ = #0);

    {convert system characters}
    Result := StringReplace(Result, '&quot;', '"',  [rfReplaceAll]);
    Result := StringReplace(Result, '&apos;', '''', [rfReplaceAll]);
    Result := StringReplace(Result, '&gt;',   '>',  [rfReplaceAll]);
    Result := StringReplace(Result, '&lt;',   '<',  [rfReplaceAll]);
    Result := StringReplace(Result, '&amp;',  '&',  [rfReplaceAll]);
    Result := StringReplace(Result, '&Auml;', 'Ä',  [rfReplaceAll]);
    Result := StringReplace(Result, '&auml;', 'ä',  [rfReplaceAll]);
    Result := StringReplace(Result, '&Ouml;', 'Ö',  [rfReplaceAll]);
    Result := StringReplace(Result, '&ouml;', 'ö',  [rfReplaceAll]);
    Result := StringReplace(Result, '&Uuml;', 'Ü',  [rfReplaceAll]);
    Result := StringReplace(Result, '&uuml;', 'ü',  [rfReplaceAll]);
    Result := StringReplace(Result, '&szlig;','ß',  [rfReplaceAll]);
    Result := StringReplace(Result, '&nbsp;', ' ',  [rfReplaceAll]);
  end;

  procedure addText(txt: TIdText);
  begin
    if txt.ContentType = 'text/html' then
    begin
      html := html + txt.Body.Text;
    end;
    if txt.ContentType = 'text/plain' then
    begin
      text := text + txt.Body.Text;
    end;
  end;
begin
  text := '';
  html := '';
  if FMessage.MessageParts.Count > 0 then begin
    for i := 0 to pred(FMessage.MessageParts.Count) do
    begin
      if FMessage.MessageParts.Items[i] is TIdText then
      begin
        addText(FMessage.MessageParts.Items[i] as TIdText);
      end;
    end;
    FHeadline := trim(StripHTMLTags(html));
    if FHeadline = '' then begin
      FHeadline := trim(ReplaceText( text, #$d#$a, ' ' ));
    end;
  end else begin
    FHeadline := trim(ReplaceText( FMessage.Body.Text, #$d#$a, ' ' ));;
  end;
  if Length(FHeadline) > 120 then
    SetLength(FHeadline, 120);
end;

function TMail.loadFromFile(fname: string): boolean;
begin
  Result := FileExists(fname);
  if Result then begin
    try
      FMessage.NoDecode := true;
      FMessage.LoadFromFile(fname);
      FMessage.ProcessHeaders;

      processMailData;
    except
      Result := false;
    end;
  end;
end;

function TMail.loadFromStream(st: TStream): boolean;
begin
  Result := false;

  try
    FMessage.LoadFromStream(st);
//    FMessage.ProcessHeaders;
    processMailData;
    Result := true;
  except

  end;
end;

procedure TMail.processMailData;
begin
  FTitel        := FMessage.Subject;
  FAbsender     := FMessage.From.Name;
  FSendDate     := FormatDateTime( 'dddd dd.mm.yyyy', FMessage.Date );
  FSendTime     := FormatDateTime('hh:nn', FMessage.Date);
  FAdresse      := FMessage.From.Address;
  FTimeStamp    := FMessage.Date;
  FAttachments  := FMessage.MessageParts.AttachmentCount <> 0;
  FMEsgID       := FMessage.Headers.Values['Message-ID'];

  if Trim(FTitel) = '' then
    FTitel := '(Kein Betreff)';

  FillHeadLine;
//  m_bmp.Canvas.Brush.Color := clWindow;
//  m_bmp.Canvas.FillRect( Rect( 0, 0, m_bmp.Width, m_bmp.Height));
end;

procedure TMail.SetKategorie(value: string);
var
  list : TStringList;
  function getColor( name : string ) : TColor;
  var
    inx : integer;
  begin
    Result := clBlack;
    inx := kats.IndexOfName(name);
    if inx <> -1 then begin
      Result := TColor(StrToInt(kats.ValueFromIndex[inx]));
    end;
  end;
  procedure paintRect( re : TRect; name : string );
  begin
    m_bmp.Canvas.Brush.Color := getColor(name);
    m_bmp.Canvas.FillRect(re);
  end;
var
  i : integer;
begin
  FKategorie := trim(value);
  m_bmp.SetSize(0, 0);
  if FKategorie.IsEmpty then exit;

  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ';';
  list.DelimitedText := FKategorie;
  m_bmp.SetSize( list.Count * 16, 16);

  for i := 0 to pred(list.Count) do begin
    paintRect(Rect( i * 16, 0, i * 16 + 16, 16), list[i]);
  end;
  list.Free;
end;

initialization
  kats := TStringList.Create;
  kats.AddPair('PSA',   '$FF0000');
  kats.AddPair('EGA',   '$00FF00');
  kats.AddPair('BER',   '$0000FF');
  kats.AddPair('OFFEN', '$FF0F0F');

finalization
  kats.Free;
end.

