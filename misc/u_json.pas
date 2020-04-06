unit u_json;

interface

uses
  System.JSON, System.Classes;


procedure JReplace( obj : TJSONObject ; name : string ; value : string ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : integer ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : Int64 ); overload;
procedure JReplaceDouble( obj : TJSONObject ; name : string ; value : double ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : boolean ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONArray ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONObject ); overload;
procedure Jreplace( obj : TJSONObject ; name : string ; value : TDate );      overload;

procedure JRemove( obj : TJSONObject ; name : string );

function JString( obj : TJSONObject; name : string ; default : string = '' ) : string;
function JInt   ( obj : TJSONObject; name : string ; default : integer = 0 ) : integer;
function JDouble( obj : TJSONObject; name : string ; default : double = 0.0 ) : Double;
function JBool  ( obj : TJSONObject; name : string ; default : boolean = false ) : boolean;
function JObject( obj : TJSONObject; name : string ) : TJSONObject;
function JArray ( obj : TJSONObject; name : string ) : TJSONArray;
function JDate  ( obj : TJSONObject; name : string ) : TDate;


function getRow( arr : TJSONArray ; inx : integer ) : TJSONObject;

procedure setText( obj : TJSONObject; name : string ; text : string ); overload;
procedure setText( obj : TJSONObject; name : string ; list : TStringList ); overload;
function  getText( obj : TJSONObject; name : string ) : String; overload;
procedure getText( obj : TJSONObject; name : string ; list : TStringList ); overload;

function loadJSON( st : TStream ) : TJSONObject; overload;
function loadJSON( fileName : string ) : TJSONObject; overload;
function JFromText( text : string) : TJSONObject;

function saveJSON( obj : TJSONObject; st : TStream ) : boolean; overload;
function saveJSON( obj : TJSONObject; fileName : string ) : boolean; overload;

function JQuote( s : string ) : String;
function JUnQuote( s : string ) : String;

function JDeleteKey( obj : TJSONObject ; name : String ) : boolean;
function JExistsKey( obj : TJSONObject ; name : String ) : boolean;

procedure JResult( obj : TJSONObject ; ok : Boolean ; text : string );
procedure JResponse( data : TJSONObject ; state : boolean ; text : string );

implementation

uses
  System.SysUtils, System.StrUtils;

{*******************************************************************************
*                   JRemove
*******************************************************************************}
procedure JRemove( obj : TJSONObject ; name : string );
var
  p :TJSONPair;

begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
end;

{*******************************************************************************
*                   JReplace    string
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : string );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if not value.Contains(#13) then
    obj.AddPair( TJSONPair.Create( name, TJSONString.Create(JQuote(value))))
  else
    setText( obj, name, value );
end;

{*******************************************************************************
*                   JReplace    boolean
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : boolean );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;

  obj.AddPair( TJSONPair.Create( name, TJSONBool.Create(value)));

end;


{*******************************************************************************
*                   JReplace    TJSONArray
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONArray );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if Assigned( value) then
    obj.AddPair( TJSONPair.Create( name, value) );
end;

{*******************************************************************************
*                   JReplace    integer
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : integer );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  obj.AddPair( TJSONPair.Create( name, TJSONNumber.Create(value)));
end;

procedure JReplace( obj : TJSONObject ; name : string ; value : Int64 ); overload;
begin
  JReplace( obj, name, integer(value));
end;

{*******************************************************************************
*                   JReplace    double
*******************************************************************************}
procedure JReplaceDouble( obj : TJSONObject ; name : string ; value : double ); overload;
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  obj.AddPair( TJSONPair.Create( name, TJSONNumber.Create(value)));
end;

{*******************************************************************************
*                   JReplace    TJSONObject
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONObject ); overload;
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if Assigned(value) then
    obj.AddPair( TJSONPair.Create( name, value));
end;

{*******************************************************************************
*                   JReplace    TDate
*******************************************************************************}
procedure Jreplace( obj : TJSONObject ; name : string ; value : TDate );
var
  text : string;
  s    : TFormatSettings;
begin
  s := TFormatSettings.Create('de-DE');
  text := FormatDateTime('dd.MM.YYYY hh:mm:ss', value);
  Jreplace( obj, name, text);
end;

{*******************************************************************************
*                   JArray
*******************************************************************************}
function JArray ( obj : TJSONObject; name : string ) : TJSONArray;
begin
  Result := NIL;

  if not Assigned(obj) then
    exit;
  try
    Result := obj.Values[ name ] as TJSONArray;
  finally

  end;

end;

{*******************************************************************************
*                   JArray
*******************************************************************************}
function JDate( obj : TJSONObject ; name : string ) : TDate;
var
  text : string;
  s     :TFormatSettings;
begin
  Result := 0.0;

  s := TFormatSettings.Create('de-DE');
  text := JString( obj, name);

  if not text.IsEmpty then
  begin
    try
      Result := StrToDateTime( text, s);
    except

    end;
  end;

end;

{*******************************************************************************
*                   JObject
*******************************************************************************}
function JObject( obj : TJSONObject; name : string ) : TJSONObject;
begin
  Result := NIL;

  if not Assigned(obj) then
    exit;
  try
    Result := obj.Values[ name ] as TJSONObject;
  finally

  end;
end;

{*******************************************************************************
*                   JInt
*******************************************************************************}
function JInt( obj : TJSONObject; name : string ; default : integer = 0 ) : integer;
var
  v : TJSONNumber;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONNumber;

  if Assigned(v) then
    Result := v.AsInt;
end;

{*******************************************************************************
*                   JDouble
*******************************************************************************}
function JDouble( obj : TJSONObject; name : string ; default : double = 0.0 ) : Double;
var
  v : TJSONNumber;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONNumber;

  if Assigned(v) then
    Result := v.AsDouble;
end;
{*******************************************************************************
*                   JBool
*******************************************************************************}
function JBool ( obj : TJSONObject; name : string ; default : boolean  ) : boolean;
var
  v : TJSONBool;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONBool;

  if Assigned(v) then
    Result := v.AsBoolean;

end;

{*******************************************************************************
*                   JString
*******************************************************************************}
function JString( obj : TJSONObject ; name : string ; default : string ) : string;
var
  v : TJSONString;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  if obj.Values[ name ] is TJSONString then
  begin
    v := obj.Values[ name ] as TJSONString;

    if Assigned(v) then
      Result := JUnQuote(v.Value);
  end
  else if obj.Values[name] is TJSONArray then
  begin
    Result := getText( obj, name );
  end;

end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function loadJSON( st : TStream ) : TJSONObject;
var
  list : TStringList;
begin
  Result := NIL;

  if not Assigned(st) then
    exit;

  list := TStringList.Create;
  try
    list.LoadFromStream(st);

    Result := TJSONObject.ParseJSONValue(list.Text) as TJSONObject;
  finally
    list.Free;
  end;


end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function loadJSON( fileName : string ) : TJSONObject;
var
  st : TFileStream;
begin
  Result := NIL;
  st := NIL;

  if FileExists( fileName) then
  begin
    try
      st := TFileStream.Create(fileName, fmOpenRead + fmShareDenyNone );
      Result := loadJSON(st);
    finally
      st.Free;
    end;
  end;

end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function getRow( arr : TJSONArray ; inx : integer ) : TJSONObject;
begin
  Result := NIL;

  if not Assigned(arr) then
    exit;

    Result := arr.Items[ inx ] as TJSONObject;
end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function saveJSON( obj : TJSONObject; st : TStream ) : boolean;
var
  list : TStringList;
begin
  Result := false;
  if (not Assigned(obj)) or ( not Assigned(st)) then
    exit;

  list := TStringList.Create;
  try
    list.Text := obj.ToString;
    list.SaveToStream(st);
    st.Position := 0;
    Result := true;
  finally
    list.Free;
  end;
end;

{*******************************************************************************
*                   saveJSON
*******************************************************************************}
function saveJSON( obj : TJSONObject; fileName : string ) : boolean;
var
  st : TFileStream;
begin
  Result := false;

  if not Assigned(obj) then
    exit;
  st:= NIL;
  try
    st := TFileStream.Create(fileName, fmCreate + fmShareDenyNone);
    Result := saveJSON( obj, st);
  finally
    st.Free;
  end;
end;

{*******************************************************************************
*                   setText
*******************************************************************************}
procedure setText( obj : TJSONObject; name : string ; list : TStringList );
var
  arr : TJSONArray;
  i    : integer;
begin
  arr := TJSONArray.Create;
  for i := 0 to pred(list.Count) do
    begin
      arr.Add( JQuote(list.Strings[i]));
    end;
  JReplace( obj, name, arr);
end;

{*******************************************************************************
*                   setText
*******************************************************************************}
procedure setText( obj : TJSONObject; name : string ; text : string );
var
  arr : TJSONArray;
  list : TStringList;
  i    : integer;
begin
  arr := TJSONArray.Create;
  list := TStringList.Create;
  list.Text := text;

  for i := 0 to pred(list.Count) do
    begin
      arr.Add( JQuote(list.Strings[i]));
    end;

  list.Free;
  JReplace( obj, name, arr);

end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
procedure getText( obj : TJSONObject; name : string ; list : TStringList );
var
  arr : TJSONArray;
  i   : integer;
begin
  arr := JArray( obj, name);
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
    begin
      list.Add( JUnQuote(arr.Items[i].Value));
    end;
end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function getText( obj : TJSONObject; name : string ) : String;
var
  arr : TJSONArray;
  list: TStringList;
  i   : integer;
begin
  arr := JArray( obj, name);
  if not Assigned(arr) then
    exit;

  list := TStringList.Create;
  for i := 0 to pred(arr.Count) do
    begin
      list.Add( JUnQuote(arr.Items[i].Value));
    end;

  Result := list.Text;
  list.Free;
end;

{*******************************************************************************
*                   JQuote
*******************************************************************************}
function JQuote( s : string ) : String;
begin
  Result := stringreplace( s, #$08, '\b', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$09, '\t', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0A, '\n', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0C, '\f', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0D, '\r', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\',  '\\', [rfReplaceAll, rfIgnoreCase]);
end;


function JQuote_old( s : string ) : String;
var
  i : integer;
  c : char;
begin
  for i := 1 to pred(Length(s)) do
    begin
      c := s[i];
      case c of
        #$08 : Result := Result + '\b';
        #$09 : Result := Result + '\t';
        #$0A : Result := Result + '\n';
        #$0c : Result := Result + '\f';
        #$0D : Result := Result + '\r';
        '\'  : Result := Result + '\\';
      else
        Result:= Result + c;
      end;
    end;
end;

{*******************************************************************************
*                   JUnQuote
*******************************************************************************}
function JUnQuote( s : string ) : String;
begin
  Result := stringreplace( s, '\b', #$08, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\t', #$09, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\n', #$0A, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\f', #$0C, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\r', #$0D, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\\', '\', [rfReplaceAll, rfIgnoreCase]);
end;

{*******************************************************************************
*                   JDeleteKey
*******************************************************************************}
function JDeleteKey( obj : TJSONObject ; name : String ) : boolean;
var
  p : TJSONPair;
begin
  Result := false;
  if not Assigned(obj) then
    exit;
   p:= obj.RemovePair(name);

   if Assigned(p) then
   begin
    p.Free;
    Result := true;
   end;
end;
{*******************************************************************************
*                   JExistsKey
*******************************************************************************}
function JExistsKey( obj : TJSONObject ; name : String ) : boolean;
var
  val : TJSONValue;
begin
  Result := false;
  if not Assigned(obj) then
    exit;
  val := obj.GetValue(name);

  Result := Assigned(val);
end;
{*******************************************************************************
*                   JResult
*******************************************************************************}
procedure JResult( obj : TJSONObject ; ok : Boolean ; text : string );
begin
  JReplace( obj, 'result', ok);
  JReplace( obj, 'text', text);
end;

{*******************************************************************************
*                   JFromText
*******************************************************************************}
function JFromText( text : string) : TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(text) as TJSONObject;
end;

{*******************************************************************************
*                   JResponse
*******************************************************************************}
procedure JResponse( data : TJSONObject ; state : boolean ; text : string );
begin
  if not Assigned(data) then
    exit;

  Jreplace( data, 'result', state);
  Jreplace( data, 'text', text);
end;

end.


