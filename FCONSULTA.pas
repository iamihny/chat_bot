unit FCONSULTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  DB, cxDBData, MemDS, DBAccess, Ora, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  rxToolEdit, StdCtrls, ExtCtrls, Grids, DBGrids;

type
  TfrmConsulta = class(TForm)
    Panel4: TPanel;
    Label3: TLabel;
    Label15: TLabel;
    edProcesso: TEdit;
    ceProcesso: TComboEdit;
    edAssunto: TEdit;
    ceAssunto: TComboEdit;
    gProcesso: TDBGrid;
    qryNAssunto: TOraQuery;
    qryNAssuntoASSUNTO: TStringField;
    qryAssunto: TOraQuery;
    qryAssuntoCOD_ASSUNTO: TFloatField;
    qryAssuntoASSUNTO: TStringField;
    qryAssuntoORDEM: TFloatField;
    qryProcesso: TOraQuery;
    qryProcessoCOD_PROCESSO: TFloatField;
    qryProcessoPROCESSO: TStringField;
    qryProcessoORDEM: TFloatField;
    qryNProcesso: TOraQuery;
    qryNProcessoPROCESSO: TStringField;
    qrySolucoes: TOraQuery;
    qrySolucoesCOD_PROCESSO: TFloatField;
    qrySolucoesCOD_ASSUNTO: TFloatField;
    qrySolucoesCOD_SOLUCAO: TFloatField;
    qrySolucoesDUVIDA: TStringField;
    qrySolucoesSOLUCAO: TStringField;
    qrySolucoesSOLUCAO2: TStringField;
    qrySolucoesSOLUCAO3: TStringField;
    qrySolucoesORDEM: TFloatField;
    qrySolucoesIMAGEM: TBlobField;
    qrySolucoesIMAGEM2: TBlobField;
    qrySolucoesIMAGEM3: TBlobField;
    qrySolucoesNOME_IMAGEM: TStringField;
    qrySolucoesNOME_IMAGEM2: TStringField;
    qrySolucoesNOME_IMAGEM3: TStringField;
    qrySolucoesLINK_VIDEO: TStringField;
    qrySolucoesLINK_VIDEO2: TStringField;
    qrySolucoesLINK_VIDEO3: TStringField;
    qrySolucoesPALAVRA_CHAVE: TStringField;
    qrySolucoesPALAVRA_CHAVE2: TStringField;
    qrySolucoesPALAVRA_CHAVE3: TStringField;
    qrySolucoesIND_CHATBOT: TStringField;
    qrySolucoesIND_DOCUMENTACAO: TStringField;
    qrySolucoesCOD_DOCUMENTO: TFloatField;
    qrySolucoesCOD_DOCUMENTO2: TFloatField;
    dsSolucoes: TOraDataSource;
    Panel1: TPanel;
    Label5: TLabel;
    totSolucoes: TEdit;
    qryTotais: TOraQuery;
    procedure FormShow(Sender: TObject);
    procedure ceProcessoButtonClick(Sender: TObject);
    procedure ceProcessoChange(Sender: TObject);
    procedure ceAssuntoButtonClick(Sender: TObject);
    procedure ceAssuntoChange(Sender: TObject);
    procedure qrySolucoesAfterOpen(DataSet: TDataSet);
    procedure qrySolucoesAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
     FHandlePai  : THandle;
  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses ysfm0500;

{$R *.dfm}

procedure TfrmConsulta.ceAssuntoButtonClick(Sender: TObject);
begin
  qryAssunto.close;
  qryAssunto.ParamByName('COD_PROCESSO').Value := ceProcesso.text;
  qryAssunto.open;
  if pesquisa(qryAssunto,'Assunto','') and (qryAssunto.recordCount <> 0) then
    begin
    ceAssunto.text := qryAssuntoCOD_ASSUNTO.AsString;
    end;
end;

procedure TfrmConsulta.ceAssuntoChange(Sender: TObject);
begin
     qrySolucoes.Close;
     if trim(ceAssunto.text) = '' then
        begin
        edAssunto.Text := '';
        qrySolucoes.Close;
        if trim(ceProcesso.Text) <> '' then
          qrySolucoes.MacroByName('PROCESSO').Value := 'WHERE COD_PROCESSO = '+ceProcesso.text
        else
          qrySolucoes.MacroByName('PROCESSO').Value := ' ';

        qrySolucoes.MacroByName('ASSUNTO').Value  := ' ';
        qrySolucoes.Open;
        end
     else
       begin
       qryNAssunto.Close;
       qryNAssunto.ParamByName('COD_ASSUNTO').Value :=  ceAssunto.text;
       qryNAssunto.Open;
       edAssunto.Text := qryNAssuntoASSUNTO.AsString;

       if (qryNAssunto.RecordCount <> 0) then
         begin
          qrySolucoes.Close;
          qrySolucoes.MacroByName('PROCESSO').Value := 'WHERE COD_PROCESSO = '+ceProcesso.text;
          qrySolucoes.MacroByName('ASSUNTO').Value  := '  AND COD_ASSUNTO  = '+ceAssunto.text;
          qrySolucoes.Open;
         end;
       end;
end;

procedure TfrmConsulta.ceProcessoButtonClick(Sender: TObject);
begin
  qryProcesso.close;
  qryProcesso.open;
  if pesquisa(qryProcesso,'Processo','') and (qryProcesso.recordCount <> 0) then
    begin
    ceProcesso.text := qryProcessoCOD_PROCESSO.AsString;
    end;
end;

procedure TfrmConsulta.ceProcessoChange(Sender: TObject);
begin
     qrySolucoes.Close;
     ceAssunto.Text := '';

     if trim(ceProcesso.text) = '' then
       begin
          edProcesso.Text := '';
          qrySolucoes.Close;
          qrySolucoes.MacroByName('PROCESSO').Value := ' ';
          qrySolucoes.MacroByName('ASSUNTO').Value  := ' ';
          qrySolucoes.Open;
       end
     else
       begin
       qryNProcesso.Close;
       qryNProcesso.ParamByName('COD_PROCESSO').Value :=  ceProcesso.text;
       qryNProcesso.Open;
       if (qryNProcesso.RecordCount <> 0) then
         begin
          edProcesso.Text := qryNProcessoPROCESSO.AsString;
          qrySolucoes.Close;
          qrySolucoes.MacroByName('PROCESSO').Value := 'WHERE COD_PROCESSO = '+ceProcesso.text;
          qrySolucoes.MacroByName('ASSUNTO').Value  := ' ';
          qrySolucoes.Open;
         end;
       end;
end;

procedure TfrmConsulta.FormShow(Sender: TObject);
begin
  Windows.SetParent(self.Handle,FHandlePai);

  qrySolucoes.Close;
  qrySolucoes.MacroByName('PROCESSO').Value := ' ';
  qrySolucoes.MacroByName('ASSUNTO').Value  := ' ';
  qrySolucoes.Open;
end;

procedure TfrmConsulta.qrySolucoesAfterClose(DataSet: TDataSet);
begin
  totSolucoes.Text := '';
end;

procedure TfrmConsulta.qrySolucoesAfterOpen(DataSet: TDataSet);
begin
  totSolucoes.Text := IntToStr(qrySolucoes.RecordCount);
end;

end.
