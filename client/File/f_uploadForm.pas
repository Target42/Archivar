unit f_uploadForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBGrids, fr_base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.StorageBin, Vcl.ExtCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections,
  Vcl.Grids, FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TUploadForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DataTab: TFDMemTable;
    DataTabID: TIntegerField;
    DataTabFNAME: TStringField;
    DataSource1: TDataSource;
    DataTabFD_ID: TIntegerField;
    DataTabFD_TEXT: TStringField;
    DeleteTimesTab: TFDMemTable;
    DeleteTimesTabFD_ID: TIntegerField;
    DeleteTimesTabFD_NAME: TStringField;
    DeleteTimesTabFD_MONATE: TIntegerField;
    DataTabUploaded: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_list : TStringList;
    m_drid : integer;
    m_map   : TDictionary<integer, integer>;
    m_default : integer;
  public
    property DR_ID : integer read m_drid write m_drid;

    procedure AssignFiles( list : TStringList );
  end;

var
  UploadForm: TUploadForm;

implementation

{$R *.dfm}

uses
  system.IOUtils, m_glob_client, u_stub, System.JSON, u_json;


procedure TUploadForm.AssignFiles(list: TStringList);
var
 i : integer;
begin
  m_list := list;
  DataTab.EmptyDataSet;
  for i := 0 to pred(m_list.Count) do begin
    DataTab.Append;
    DataTab.FieldByName('ID').AsInteger := i;
    DataTab.FieldByName('FNAME').AsString := ExtractFileName(m_list[i]);
    DataTab.FieldByName('FD_ID').AsInteger := m_default;
    DataTab.Post;
  end;
end;

procedure TUploadForm.Button1Click(Sender: TObject);

var
  client : TdsFileClient;
  id      : integer;
  req, res   : TJSONObject;
  fs     : TStream;
begin
  Screen.Cursor := crSQLWait;
  DataTab.DisableControls;
  // upload ...
  client := NIL;
  try
    client := TdsFileClient.Create(GM.SQLConnection1.DBXConnection);
    DataTab.First;
    while not DataTab.Eof do
    begin
      try
        id := DataTab.FieldByName('ID').AsInteger;
        try
          //fs := TFileStream.Create( m_list[id], fmOpenRead + fmShareDenyWrite);
          fs := m_list.Objects[id] as TStream;
          fs.Position := 0;
        except
          fs := NIL;
        end;
        if Assigned(fs) then
        begin
          req := TJSONObject.Create;
          JReplace( req, 'fname',     DataTab.FieldByName('FNAME').AsString);
          JReplace( req, 'todelete',  m_map[DataTab.FieldByName('FD_ID').AsInteger]);
          JReplace( req, 'type',      '');
          JReplace( req, 'drid',      m_drid );
          JReplace( req, 'size',      fs.Size );

          res := client.upload(req, fs);
          DataTab.Edit;
          DataTab.FieldByName('Uploaded').AsBoolean := JBool(res, 'result');
          DataTab.Post;

          if not JBool(res, 'result') then
            ShowMessage(JString(res, 'text'));
        end;
        m_list.Objects[id] := NIL;
      except
        begin
        end;
      end;

      DataTab.Next;
    end;

  finally
    client.Free;
  end;
  DataTab.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TUploadForm.FormCreate(Sender: TObject);
var
  fname : string;
begin
  m_map     := TDictionary<integer, integer>.create;
  m_list    := NIL;
  m_default := 0;

  fname := TPath.Combine(GM.PublicPath, 'deltimes.adb');
  DeleteTimesTab.Open;
  if FileExists(fname) then
    DeleteTimesTab.LoadFromFile(fname, sfBinary);

  DeleteTimesTab.first;
  if not DeleteTimesTab.Eof then
    m_default := DeleteTimesTab.FieldByName('FD_ID').AsInteger;

  while not DeleteTimesTab.Eof do
  begin
    m_map.Add( DeleteTimesTab.FieldByName('FD_ID').AsInteger, DeleteTimesTab.FieldByName('FD_MONATE').AsInteger);
    DeleteTimesTab.Next;
  end;
  DeleteTimesTab.First;

  DataTab.Open;
end;

procedure TUploadForm.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for I := 0 to pred(m_list.Count) do
    TStream(m_list.Objects[i]).Free;
  m_list.Clear;

  m_map.Free;
end;

end.
