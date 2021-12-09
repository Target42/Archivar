unit u_typeHelper;

interface

uses
  Vcl.StdCtrls, System.Classes, Vcl.Controls;

//TEditCharCase
function TEditCharCase2Text( value : TEditCharCase) : string;
function Text2TEditCharCase( value : string ) : TEditCharCase;
procedure fillTEditcharList( list : TStrings );


// TAlign
function TAlign2Text( value : TAlign ): string;
function Text2TAlign( value : string ): TAlign;
procedure fillAlignList( list : TStrings );

implementation

uses
  System.SysUtils;

function TEditCharCase2Text( value : TEditCharCase) : string;
begin
  case value of
    TEditCharCase.ecNormal:     Result := 'ecNormal';
    TEditCharCase.ecUpperCase:  Result := 'ecUpperCase';
    TEditCharCase.ecLowerCase:  Result := 'ecLowerCase';
    else
      Result := 'ecNormal';
  end;
end;
function Text2TEditCharCase( value : string ) : TEditCharCase;
begin
  Result := ecNormal;
  if      SameText(value, 'ecNormal')    then Result := TEditCharCase.ecNormal
  else if SameText(value, 'ecUpperCase') then Result := TEditCharCase.ecUpperCase
  else if SameText(value, 'ecLowerCase') then Result := TEditCharCase.ecLowerCase
  else Result := TEditCharCase.ecNormal;
end;
procedure fillTEditcharList( list : TStrings );
begin
  list.add('ecNormal');
  list.add('ecUpperCase');
  list.add('ecLowerCase');
end;


function TAlign2Text( value : TAlign ): string;
begin
  case value of
    alNone:     Result := 'alNone';
    alTop:      Result := 'alTop';
    alBottom:   Result := 'alBottom';
    alLeft:     Result := 'alLeft';
    alRight:    Result := 'alRight';
    alClient:   Result := 'alClient';
    alCustom:   Result := 'alCustom';
  end;
end;

function Text2TAlign( value : string ): TAlign;
begin
  Result := alNone;

  if      SameText( value, 'alNone')    then Result := alNone
  else if SameText( value, 'alTop')     then Result := alTop
  else if SameText( value, 'alBottom')  then Result := alBottom
  else if SameText( value, 'alLeft')    then Result := alLeft
  else if SameText( value, 'alRight')   then Result := alRight
  else if SameText( value, 'alClient')  then Result := alClient
  else if SameText( value, 'alCustom')  then Result := alCustom
end;
procedure fillAlignList( list : TStrings );
begin
  list.add('alNone');
  list.add('alTop');
  list.add('alBottom');
  list.add('alLeft');
  list.add('alRight');
  list.add('alClient');
  list.add('alCustom');
end;

end.
