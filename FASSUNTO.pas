unit FASSUNTO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, Grids,
  DBGrids, DBSBtncx, StdCtrls, cxButtons, Mask, DBCtrls, ExtCtrls, DB, MemDS,
  DBAccess, Ora, rxToolEdit, RXDBCtrl;

type
  TfrmAssunto = class(TForm)
    dsAssunto: TOraDataSource;
    qryAssunto: TOraQuery;
    qryCodigo: TOraQuery;
    Panel2: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    edAssunto: TDBEdit;
    PEdicao: TPanel;
    sbRefresh: TcxButton;
    dbsbInsert: TDBcxSpeedButton;
    dbsbDelete: TDBcxSpeedButton;
    dbsbEdit: TDBcxSpeedButton;
    dbsbPost: TDBcxSpeedButton;
    dbsbCancel: TDBcxSpeedButton;
    DBEdit2: TDBEdit;
    pGrid: TPanel;
    gProcesso: TDBGrid;
    qryCodigoORDEM: TFloatField;
    qryAssuntoCOD_ASSUNTO: TFloatField;
    qryAssuntoORDEM: TFloatField;
    Label3: TLabel;
    ceProcesso: TRxDBComboEdit;
    edProcesso: TEdit;
    qryProcesso: TOraQuery;
    qryProcessoORDEM: TFloatField;
    qryNProcesso: TOraQuery;
    qryProcessoCOD_PROCESSO: TFloatField;
    qryProcessoPROCESSO: TStringField;
    qryCodigoCOD_ASSUNTO: TFloatField;
    qryNProcessoPROCESSO: TStringField;
    qryAssuntoCOD_PROCESSO: TFloatField;
    qryAssuntoASSUNTO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure qryAssuntoBeforePost(DataSet: TDataSet);
    procedure ceProcessoButtonClick(Sender: TObject);
    procedure ceProcessoChange(Sender: TObject);
    procedure qryAssuntoNewRecord(DataSet: TDataSet);
    procedure dsAssuntoStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     FHandlePai  : THandle;
  end;

var
  frmAssunto: TfrmAssunto;

implementation

uses ysfm0500;
{$R *.dfm}

procedure TfrmAssunto.ceProcessoButtonClick(Sender: TObject);
begin
  qryProcesso.close;
  qryProcesso.open;
  if pesquisa(qryProcesso,'Processo','') and (qryProcesso.recordCount <> 0) then
    begin
    ceProcesso.text := qryProcessoCOD_PROCESSO.AsString;
    end;
end;

procedure TfrmAssunto.ceProcessoChange(Sender: TObject);
begin
     if trim(ceProcesso.text) = '' then
        edProcesso.Text := ''
     else
       begin
       qryNProcesso.Close;
       qryNProcesso.ParamByName('COD_PROCESSO').Value :=  ceProcesso.text;
       qryNProcesso.Open;
       edProcesso.Text := qryNProcessoPROCESSO.AsString;
       end;
end;

procedure TfrmAssunto.dsAssuntoStateChange(Sender: TObject);
begin
  edAssunto.ReadOnly := dsAssunto.State = dsBrowse;
end;

procedure TfrmAssunto.FormShow(Sender: TObject);
begin
  qryAssunto.Open;
  Windows.SetParent(self.Handle,FHandlePai);
end;

procedure TfrmAssunto.qryAssuntoBeforePost(DataSet: TDataSet);
begin
  if trim(qryAssuntoASSUNTO.AsString) = '' then
      begin
      showMessage('Assunto deve ser Informado!');
      edAssunto.SetFocus;
      abort;
      end;
end;

procedure TfrmAssunto.qryAssuntoNewRecord(DataSet: TDataSet);
begin
  qryCodigo.Close;
  qryCodigo.Open;
  qryAssuntoCOD_ASSUNTO.value := qryCodigo.FieldByName('COD_ASSUNTO').Value;
  qryAssuntoORDEM.value := qryCodigo.FieldByName('ORDEM').Value;
  qryCodigo.Close;
  ceProcesso.SetFocus;
end;

end.
