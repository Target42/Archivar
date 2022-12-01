unit u_SpellChecker;

interface

uses
  Vcl.ComCtrls, NHunspell, System.Classes, Winapi.Windows, Vcl.Forms;

type
  TSpellChecker = class
  private
    m_edit      : TRichEdit;
    m_startPos  : integer;
    m_endPos    : integer;
    m_word      : UnicodeString;
    m_dicts     : UnicodeString;

    m_dict      : TNHSpellDictionary;
    m_hyph      : TNHHyphenDictionary;
    m_correct   : TForm;

    procedure setWord( value : UnicodeString );

    procedure SelectDefDict;

  public
    constructor create;
    Destructor  Destroy; override;

    function start : boolean;
    function startSelection : boolean;
    function startPosition : boolean;
    function nextWord : boolean;

    function config : boolean;
    procedure show;
    function check( word : UnicodeString ) : boolean;
    procedure suggest( word : UnicodeString; list : TStrings);
    procedure replaceText( text : UnicodeString  );
    function addWord( word : UnicodeString  ) : boolean;

    property Edit : TRichEdit read m_edit write m_edit;
    property Word : UnicodeString read m_word write setWord ;

    property SpellDictionary : TNHSpellDictionary read m_dict write m_dict;
    property HyphenDictionary:TNHHyphenDictionary read m_hyph write m_hyph;

    procedure selectSpell( name : string );
    procedure selectHypen( name : string );
  end;

implementation

uses
  f_select_dictinonary, f_correctForm, System.SysUtils, RichEdit;

{ TSpellChecker }

var
  defDict : string = 'Deutsch (Deutschland)';
  ign : array[0..12] of UnicodeString =
  (
  	'.', ',', ';', ':', '#', '!', '?',
    '%', '/', '\', '-', '+', ''
  );

function TSpellChecker.addWord(word: UnicodeString): boolean;
begin
	Result:= false;

  if Assigned(m_dict) then
    Result := m_dict.Add(word);
end;

function TSpellChecker.check(word: UnicodeString): boolean;
begin
	Result := false;

  if Assigned(m_dict) then
    	Result := m_dict.Spell(word);
end;

function TSpellChecker.config : boolean;
begin
  Result := false;
  if ShowSelectDictionary then begin
    Hunspell.UpdateAndLoadDictionaries;
    m_dict  := Hunspell.SpellDictionary;
    m_hyph  := Hunspell.HyphenDictionary;
    Result := true;
  end;
end;

constructor TSpellChecker.create;
begin
  m_dict := NIL;
  m_hyph := NIL;

	m_correct := TCorrectForm.create(NIL);
  TCorrectForm(m_correct).Checker := self;

	m_dicts := ExpandFileName(ExtractFilePath(Application.ExeName)+'Dictionaries\');
 	Hunspell.ReadFolder(m_dicts);

  SelectDefDict;

  Hunspell.UpdateAndLoadDictionaries();

	m_edit      := NIL;
	m_startPos  := -1;
	m_endPos    := -1;

end;

destructor TSpellChecker.Destroy;
var
  fname : string;
begin
  if Assigned(m_dict) then begin
    fname := UpperCase(m_dict.DictionaryFileName);
  end;

	m_correct.Free;

  inherited;
end;

function TSpellChecker.nextWord: boolean;
var
	StartPosition : integer;
	StopPosition  : integer;
	word : UnicodeString ;
  i    : integer;
begin
	repeat
		StartPosition := m_startPos;
		if ((SendMessage(m_edit.Handle, EM_FINDWORDBREAK, WB_CLASSIFY,
					StartPosition - 1) and (WBF_BREAKLINE or WBF_ISWHITE)) = 0) then
		begin
			StartPosition := SendMessage(m_edit.Handle, EM_FINDWORDBREAK,
				WB_MOVEWORDLEFT, StartPosition);
		end;

		StopPosition := SendMessage(m_edit.Handle, EM_FINDWORDBREAK,
			WB_MOVEWORDRIGHT, StartPosition);

		m_edit.SelStart := StartPosition;
		m_edit.SelLength := StopPosition - StartPosition;

		word := m_edit.SelText;
    if word.IsEmpty then
      break;

    word := word.Trim();
    for i := low(ign) to High(ign) do begin
      if word = ign[i] then begin
        word := '';
        break;
      end;

    end;

		m_startPos := StopPosition + 1;
		if (m_endPos <> -1) then
		begin
			if (m_endPos > m_startPos) then
			begin
				break;
      end;
    end;
	until not word.IsEmpty();

	m_word := word;

  Result := not m_word.IsEmpty;
end;

procedure TSpellChecker.replaceText(text: UnicodeString);
begin
  m_edit.SelText := trim(text)+' ';
end;

procedure TSpellChecker.SelectDefDict;
var
  i : integer;
begin
  for i := 0 to pred(Hunspell.SpellDictionaryCount) do begin
    if SameText( defDict, Hunspell.SpellDictionaries[i].LanguageName) then begin
      Hunspell.SelectSpellDictionary(i);
      m_dict := Hunspell.SpellDictionaries[i];
      break;
    end;
  end;
  for i := 0 to pred(Hunspell.HyphenDictionaryCount) do begin
    if SameText( defDict, Hunspell.HyphenDictionaries[i].LanguageName) then begin
      Hunspell.SelectHyphenDictionary(i);
      m_hyph := Hunspell.HyphenDictionaries[i];
      break;
    end;
  end;
end;

procedure TSpellChecker.selectHypen(name: string);
var
  i : integer;
begin
  for i := 0 to pred(Hunspell.HyphenDictionaryCount) do begin
    if SameText( defDict, Hunspell.HyphenDictionaries[i].LanguageName) then begin
      Hunspell.SelectHyphenDictionary(i);
      m_hyph := Hunspell.HyphenDictionaries[i];
      break;
    end;
  end;
end;

procedure TSpellChecker.selectSpell(name: string);
var
  i : integer;
begin
  for i := 0 to pred(Hunspell.SpellDictionaryCount) do begin
    if SameText( name, Hunspell.SpellDictionaries[i].LanguageName) then begin
      Hunspell.SelectSpellDictionary(i);
      m_dict := Hunspell.SpellDictionaries[i];
      break;
    end;
  end;
end;

procedure TSpellChecker.setWord(value: UnicodeString);
begin
	m_word := value;
	m_edit.SelText := m_word;
end;

procedure TSpellChecker.show;
begin
  m_correct.Show;
end;

function TSpellChecker.start: boolean;
begin
	m_startPos  := 0;
	m_endPos    := -1;

	Result := nextWord;

end;

function TSpellChecker.startPosition: boolean;
begin
	m_startPos  := m_edit.SelStart;
	m_endPos    := -1;

	Result := nextWord;
end;

function TSpellChecker.startSelection: boolean;
begin
	m_startPos  := m_edit.SelStart;
	m_endPos    := m_edit.SelStart + m_edit.SelLength;

	Result := nextWord;
end;

procedure TSpellChecker.suggest(word: UnicodeString; list: TStrings);
begin
  if Assigned(m_dict) then
    m_dict.Suggest(word, list);
end;

end.
