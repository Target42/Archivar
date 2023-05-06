unit ds_mail;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  m_db, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Datasnap.Provider,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON;

type
  TDSMail = class(TDSServerModule)
    FDTransaction1: TFDTransaction;
    Mac: TFDTable;
    Maf: TFDTable;
    MailAccount: TDataSetProvider;
    Mailfolder: TDataSetProvider;
    MamTab: TFDTable;
    Mails: TDataSetProvider;
    Gremien: TFDQuery;
    GremiumQry: TDataSetProvider;
    KategorieSet: TFDQuery;
  private
    procedure clearEmptyLines( var list : TStringList );
    function setKategorie(kategorie : string; elements : TStringList ) : boolean;

  public
    function setMailStatus( data : TJSONObject ) : TJSONObject;
  end;

implementation

uses
  u_json, m_glob_server, ServerContainerUnit1, u_Konst;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDSMail }


{ TDSMail }

procedure TDSMail.clearEmptyLines(var list: TStringList);
var
  i : integer;
begin
  for i := pred(list.Count) downto 0 do begin
    if trim(list[i]) = '' then
      list.Delete(i);
  end;
end;

function TDSMail.setKategorie(kategorie: string;
  elements: TStringList): boolean;
var
  i : integer;
  id: integer;
  count : integer;
  msg   : TJSONObject;
begin
  count := 0;

  KategorieSet.Prepare;
  KategorieSet.ParamByName('name').AsString := kategorie;
  for i := 0 to pred(elements.Count) do begin
    if TryStrToInt(elements[i], id) then begin
      KategorieSet.ParamByName('id').AsInteger := id;
      KategorieSet.ExecSQL;
      count := count + KategorieSet.RowsAffected;
    end;
  end;
  KategorieSet.Unprepare;

  if FDTransaction1.Active then
    FDTransaction1.Commit;


  Result := count = elements.Count;

  msg := TJSONObject.Create;
  JReplace(msg, 'action', BRD_MAIL);
  JReplace(msg, 'typ', 'kategorie');
  JReplace(msg, 'value', kategorie);
  setText( msg, 'elements', elements);

  ArchivService.BroadcastMessage(BRD_CHANNEL, msg);
end;

function TDSMail.setMailStatus(data: TJSONObject): TJSONObject;
var
  elements : TStringList;
  action   : string;
  s        : string;
  flag     : boolean;
begin
  Result    := TJSONObject.Create;
  elements  := TStringList.Create;
  flag      := false;

  action    := JString( data, 'action');
  getText( data, 'elements', elements);
  clearEmptyLines(elements);

  if SameText( action, 'kategorie') then begin
    s := JString(data, 'kategorie');
    flag := setKategorie( s, elements);
  end;

  if flag then
    JResult(Result, true, '')
  else
    JResult( Result, false, 'Der Vorgang hat nicht für alle Elemente functioniert');

  elements.Free;
end;

end.

