unit FPROCESSO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, DB,
  DBAccess, Ora, MemDS, DBSBtncx, StdCtrls, cxButtons, Mask, DBCtrls, Grids,
  DBGrids, ExtCtrls;

type
  TfrmProcesso = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    edProcesso: TDBEdit;
    PEdicao: TPanel;
    sbRefresh: TcxButton;
    dbsbInsert: TDBcxSpeedButton;
    dbsbDelete: TDBcxSpeedButton;
    dbsbEdit: TDBcxSpeedButton;
    dbsbPost: TDBcxSpeedButton;
    dbsbCancel: TDBcxSpeedButton;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    qryProcesso: TOraQuery;
    qryProcessoORDEM: TFloatField;
    dsProcesso: TOraDataSource;
    qryCodigo: TOraQuery;
    qryCodigoORDEM: TFloatField;
    pGrid: TPanel;
    gProcesso: TDBGrid;
    qryProcessoCOD_PROCESSO: TFloatField;
    qryProcessoPROCESSO: TStringField;
    qryCodigoCOD_PROCESSO: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure qryProcessoNewRecord(DataSet: TDataSet);
    procedure qryProcessoBeforePost(DataSet: TDataSet);
    procedure dsProcessoStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     FHandlePai  : THandle;
  end;

var
  frmProcesso: TfrmProcesso;

implementation

{$R *.dfm}

procedure TfrmProcesso.dsProcessoStateChange(Sender: TObject);
begin
   edProcesso.ReadOnly := dsProcesso.State = dsBrowse;
end;

procedure TfrmProcesso.FormShow(Sender: TObject);
begin
  qryProcesso.Open;
  Windows.SetParent(self.Handle,FHandlePai);
end;

procedure TfrmProcesso.qryProcessoBeforePost(DataSet: TDataSet);
begin
   if trim(qryProcessoPROCESSO.AsString) = '' then
      begin
      showMessage('Processo deve ser Informado!');
      edProcesso.SetFocus;
      abort;
      end;
end;

procedure TfrmProcesso.qryProcessoNewRecord(DataSet: TDataSet);
begin
  qryCodigo.Close;
  qryCodigo.Open;
  qryProcessoCOD_PROCESSO.value := qryCodigo.FieldByName('COD_PROCESSO').Value;
  qryProcessoORDEM.value := qryCodigo.FieldByName('ORDEM').Value;
  qryCodigo.Close;
  edProcesso.SetFocus;
end;

end.
