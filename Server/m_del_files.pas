unit m_del_files;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  System.Generics.Collections, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script;

type
  TDeleteFilesMod = class(TDataModule)
    FDTransaction1: TFDTransaction;
    DeleteTomeToDie: TFDScript;
    GetFolderQry: TFDQuery;
    DeleteFolder: TFDScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_folder : TList<integer>;
    FUserID: integer;
  public
    property UserID: integer read FUserID write FUserID;

    procedure DeleteFolderExecute( drid, grid : integer );

    procedure TimeToDie;

  end;

var
  DeleteFilesMod: TDeleteFilesMod;

implementation

uses
  m_db;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDeleteFilesMod }

procedure TDeleteFilesMod.DeleteFolderExecute( drid, grid : integer );
type
  TData = record
    id : integer;
    parent : integer;
  end;

var
  list : array of TData;

  procedure addChilds(id : integer );
  var
    i : integer;
  begin
    for i := low(list) to High(list) do begin
      if list[i].parent = id then begin
        m_folder.Add(list[i].id);
        addChilds(list[i].id);
      end;
    end;
  end;

var
  i    : integer;
begin
  m_folder.Clear;

  GetFolderQry.ParamByName('grid').AsInteger := grid;

  GetFolderQry.Open;
  GetFolderQry.Last;
  GetFolderQry.First;

  SetLength(list, GetFolderQry.RecordCount);

  i := 0;
  while not GetFolderQry.Eof do begin
    list[i].id      := GetFolderQry.FieldByName('DR_ID').AsInteger;
    list[i].parent  := GetFolderQry.FieldByName('DR_PARENT').AsInteger;
    inc(i);
    GetFolderQry.next;
  end;
  GetFolderQry.Close;

  m_folder.Add(drid);
  addChilds(drid);

  SetLength(list, 0);

  if not FDTransaction1.Active then
    FDTransaction1.StartTransaction;


  DeleteFolder.ValidateAll;
  try
    for drid in m_folder do begin
      DeleteFolder.Params.ParamByName('drid').AsInteger := drid;
      DeleteFolder.ExecuteAll;
    end;

    if FDTransaction1.Active then
      FDTransaction1.Commit;
  except
    if FDTransaction1.Active then
      FDTransaction1.Rollback;
  end;
  m_folder.Clear;

end;

procedure TDeleteFilesMod.DataModuleCreate(Sender: TObject);
begin
  m_folder  := TList<integer>.create;
  FUserID   := 0;

end;

procedure TDeleteFilesMod.DataModuleDestroy(Sender: TObject);
begin
  m_folder.Free;
end;

procedure TDeleteFilesMod.TimeToDie;
begin
  try
    DeleteTomeToDie.ExecuteAll;
      if FDTransaction1.Active then
        FDTransaction1.Commit;
  except
    on e : exception do begin
      if FDTransaction1.Active then
        FDTransaction1.Rollback;
    end;
  end;

end;

end.
