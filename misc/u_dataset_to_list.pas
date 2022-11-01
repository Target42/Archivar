unit u_dataset_to_list;

interface

uses
  Data.DB, System.Classes;

type
  TRecordSet = class
    private
      m_values : TStringList;
    public
      constructor create; overload;
      constructor create( dataSet : TDataSet ); overload;

      Destructor Destroy; override;

      procedure toRecordSet( dataset : TDataSet );

      function FieldByName( name : string ) : string;
  end;

function DatasetToList( dataset : TDataset ) : TRecordSet;

implementation

function DatasetToList( dataset : TDataset ) : TRecordSet;
begin
  Result := TRecordSet.create(dataset);
end;

{ TRecordSet }

constructor TRecordSet.create;
begin
  m_values := TStringList.Create;
end;

constructor TRecordSet.create(dataSet: TDataSet);
begin
  m_values := TStringList.Create;
  toRecordSet(dataset);
end;

destructor TRecordSet.Destroy;
begin
  m_values.Free;
  inherited;
end;

function TRecordSet.FieldByName(name: string): string;
begin
  Result := m_values.Values[name];
end;

procedure TRecordSet.toRecordSet(dataset: TDataSet);
var
  i : integer;
begin
  for i := 0 to pred(DataSet.FieldCount) do begin
    if not (dataset.Fields[ i ].DataType in [ftBlob, ftMemo]) then
    begin
      m_values.Values[ dataset.Fields[ i ].FieldName ] := dataset.Fields[ i ].AsString;
    end;
  end;
end;

end.
