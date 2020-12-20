unit f_uploadForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, fr_base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Vcl.ExtCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, System.Generics.Collections;

type
  TUploadForm = class(TForm)
    BaseFrame1: TBaseFrame;
    DBGrid1: TDBGrid;
    DataTab: TFDMemTable;
    DataTabID: TIntegerField;
    DataTabFNAME: TStringField;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DataTabFD_ID: TIntegerField;
    DataTabFD_TEXT: TStringField;
    DeleteTimesTab: TFDMemTable;
    DeleteTimesTabFD_ID: TIntegerField;
    DeleteTimesTabFD_NAME: TStringField;
    DeleteTimesTabFD_MONATE: TIntegerField;
    Button1: TButton;
    DataTabUploaded: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_list : TStrings;
    m_ta_id : integer;
    m_map   : TDictionary<integer, integer>;
    m_default : integer;
    procedure setList( value : TStrings );
  public
    property List : TStrings read m_list write setList;
    property TA_ID : integer read m_ta_id write m_ta_id;
  end;

var
  UploadForm: TUploadForm;

implementation

{$R *.dfm}

uses
  system.IOUtils, m_glob_client, u_stub, System.JSON, u_json;

procedure TUploadForm.Button1Click(Sender: TObject);

var
  client : TdsFileClient;
  id      : integer;
  req, res   : TJSONObject;
  fs     : TStream;
begin
  DBGrid1.Enabled := false;
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
        fs := TFileStream.Create( m_list[id], fmOpenRead + fmShareDenyWrite);
        except
          fs := NIL;
        end;
        if Assigned(fs) then
        begin
          req := TJSONObject.Create;
          JReplace( req, 'fname', DataTab.FieldByName('FNAME').AsString);
          JReplace( req, 'todelete', m_map[DataTab.FieldByName('FD_ID').AsInteger]);
          JReplace( req, 'type', '');
          JReplace( req, 'taid', m_ta_id );

          res := client.upload(req, fs);
          DataTab.Edit;
          DataTab.FieldByName('Uploaded').AsBoolean := JBool(res, 'result');
          DataTab.Post;

          if not JBool(res, 'result') then
            ShowMessage(JString(res, 'text'));
        end
        else
          ShowMessage(DataTab.FieldByName('NAME').AsString+' kann nicht geöffnet werden!');
      except
        begin
        end;
      end;
      DataTab.Next;
    end;

  finally
    client.Free;
  end;
  DBGrid1.Enabled := true;

end;

procedure TUploadForm.FormCreate(Sender: TObject);
var
  fname : string;
begin
  m_map   := TDictionary<integer, integer>.create;
  m_list := NIL;
  m_default := 0;

  fname := TPath.Combine(GM.home, 'deltimes.adb');
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
begin
  m_map.Free;
end;

procedure TUploadForm.setList(value: TStrings);
var
  i : integer;
begin
  m_list := value;
  DataTab.EmptyDataSet;
  for i := 0 to pred(m_list.Count) do
  begin
    DataTab.Append;
    DataTab.FieldByName('ID').AsInteger := i;
    DataTab.FieldByName('FNAME').AsString := ExtractFileName(list[i]);
    DataTab.FieldByName('FD_ID').AsInteger := m_default;
    DataTab.Post;
  end;

end;

end.
