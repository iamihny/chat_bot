unit FSOLUCOES;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, DB, MemDS,
  DBAccess, Ora, Grids, DBGrids, StdCtrls, rxToolEdit, RXDBCtrl, Mask, DBCtrls,
  DBSBtncx, cxButtons, ExtCtrls, ComCtrls, Buttons, ShellAPI;

type
  TfrmSolucoes = class(TForm)
    qryNProcesso: TOraQuery;
    qryNProcessoPROCESSO: TStringField;
    qryProcesso: TOraQuery;
    qryProcessoCOD_PROCESSO: TFloatField;
    qryProcessoPROCESSO: TStringField;
    qryProcessoORDEM: TFloatField;
    qryAssunto: TOraQuery;
    qryNAssunto: TOraQuery;
    qryAssuntoCOD_ASSUNTO: TFloatField;
    qryAssuntoASSUNTO: TStringField;
    qryAssuntoORDEM: TFloatField;
    qryNAssuntoASSUNTO: TStringField;
    qryCodigo: TOraQuery;
    qryCodigoORDEM: TFloatField;
    dsSolucoes: TOraDataSource;
    qryCodigoCOD_SOLUCAO: TFloatField;
    qrySolucoes: TOraQuery;
    qrySolucoesCOD_PROCESSO: TFloatField;
    qrySolucoesCOD_ASSUNTO: TFloatField;
    qrySolucoesCOD_SOLUCAO: TFloatField;
    qrySolucoesDUVIDA: TStringField;
    qrySolucoesSOLUCAO: TStringField;
    qrySolucoesORDEM: TFloatField;
    qrySolucoesIMAGEM: TBlobField;
    qrySolucoesNOME_IMAGEM: TStringField;
    qrySolucoesIMAGEM2: TBlobField;
    qrySolucoesNOME_IMAGEM2: TStringField;
    qrySolucoesIMAGEM3: TBlobField;
    qrySolucoesNOME_IMAGEM3: TStringField;
    qrySolucoesLINK_VIDEO: TStringField;
    qrySolucoesLINK_VIDEO2: TStringField;
    qrySolucoesLINK_VIDEO3: TStringField;
    odArq: TOpenDialog;
    sdPDF: TSaveDialog;
    qrySolucoesPALAVRA_CHAVE: TStringField;
    qrySolucoesPALAVRA_CHAVE2: TStringField;
    qrySolucoesPALAVRA_CHAVE3: TStringField;
    qrySolucoesIND_CHATBOT: TStringField;
    qrySolucoesIND_DOCUMENTACAO: TStringField;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    PEdicao: TPanel;
    sbRefresh: TcxButton;
    dbsbInsert: TDBcxSpeedButton;
    dbsbDelete: TDBcxSpeedButton;
    dbsbEdit: TDBcxSpeedButton;
    dbsbPost: TDBcxSpeedButton;
    dbsbCancel: TDBcxSpeedButton;
    pgSolucoes: TPageControl;
    tSolucoes: TTabSheet;
    Panel4: TPanel;
    Label3: TLabel;
    edProcesso: TEdit;
    ceProcesso: TComboEdit;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    mDuvida: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    edChave: TDBEdit;
    edChave2: TDBEdit;
    edChave3: TDBEdit;
    gProcesso: TDBGrid;
    tLinks: TTabSheet;
    GroupBox2: TGroupBox;
    btnImg: TSpeedButton;
    btnVerImg: TSpeedButton;
    imagem: TDBEdit;
    Panel6: TPanel;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    GroupBox4: TGroupBox;
    btnImg3: TSpeedButton;
    btnVerImg3: TSpeedButton;
    imagem3: TDBEdit;
    GroupBox3: TGroupBox;
    btnImg2: TSpeedButton;
    btnVerImg2: TSpeedButton;
    imagem2: TDBEdit;
    TabSheet1: TTabSheet;
    Panel7: TPanel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    GroupBox1: TGroupBox;
    V?deos: TGroupBox;
    edVideo2: TDBEdit;
    edVideo: TDBEdit;
    qrySolucoesSOLUCAO2: TStringField;
    qrySolucoesSOLUCAO3: TStringField;
    mSolucao2: TDBMemo;
    mSolucao: TDBMemo;
    mSolucao3: TDBMemo;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    qryDocumentos: TOraQuery;
    qrySolucoesCOD_DOCUMENTO: TFloatField;
    qrySolucoesCOD_DOCUMENTO2: TFloatField;
    qryNDocumento: TOraQuery;
    qryDocumentosCOD_DOCUMENTO: TFloatField;
    qryDocumentosNOME_DOCUMENTO: TStringField;
    qryNDocumentoNOME_DOCUMENTO: TStringField;
    edDocumento: TEdit;
    btnDoc: TSpeedButton;
    ceCodDocumento: TRxDBComboEdit;
    ceCodDocumento2: TRxDBComboEdit;
    edDocumento2: TEdit;
    btnDoc2: TSpeedButton;
    qryNDocumentoDOCUMENTO: TBlobField;
    edAssunto: TEdit;
    Label15: TLabel;
    ceAssunto: TComboEdit;
    procedure ceAssuntoButtonClick(Sender: TObject);
    procedure ceAssuntoChange(Sender: TObject);
    procedure dsSolucoesStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qrySolucoesNewRecord(DataSet: TDataSet);
    procedure btnImgClick(Sender: TObject);
    procedure btnVerImgClick(Sender: TObject);
    procedure btnImg2Click(Sender: TObject);
    procedure btnVerImg2Click(Sender: TObject);
    procedure ceProcessoButtonClick(Sender: TObject);
    procedure ceProcessoChange(Sender: TObject);
    procedure btnImg3Click(Sender: TObject);
    procedure btnVerImg3Click(Sender: TObject);
    procedure ceCodDocumentoButtonClick(Sender: TObject);
    procedure ceCodDocumento2ButtonClick(Sender: TObject);
    procedure ceCodDocumentoChange(Sender: TObject);
    procedure ceCodDocumento2Change(Sender: TObject);
    procedure btnDocClick(Sender: TObject);
    procedure btnDoc2Click(Sender: TObject);
    procedure qrySolucoesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
     FHandlePai  : THandle;
  end;

var
  frmSolucoes: TfrmSolucoes;

implementation

uses ysfm0500;

{$R *.dfm}



procedure TfrmSolucoes.ceAssuntoButtonClick(Sender: TObject);
begin
  qryAssunto.close;
  qryAssunto.ParamByName('COD_PROCESSO').Value := ceProcesso.text;
  qryAssunto.open;
  if pesquisa(qryAssunto,'Assunto','') and (qryAssunto.recordCount <> 0) then
    begin
    ceAssunto.text := qryAssuntoCOD_ASSUNTO.AsString;
    end;
end;

procedure TfrmSolucoes.ceAssuntoChange(Sender: TObject);
begin
     qrySolucoes.Close;
     if trim(ceAssunto.text) = '' then
        edAssunto.Text := ''
     else
       begin
       qryNAssunto.Close;
       qryNAssunto.ParamByName('COD_ASSUNTO').Value :=  ceAssunto.text;
       qryNAssunto.Open;
       edAssunto.Text := qryNAssuntoASSUNTO.AsString;

       if (qryNAssunto.RecordCount <> 0) then
         begin
          qrySolucoes.Close;
          qrySolucoes.ParamByName('COD_PROCESSO').Value := ceProcesso.text;
          qrySolucoes.ParamByName('COD_ASSUNTO').Value  := ceAssunto.text;
          qrySolucoes.Open;
         end;
       end;
end;

procedure TfrmSolucoes.ceCodDocumento2ButtonClick(Sender: TObject);
begin
  if (dsSolucoes.State <> dsBrowse) then
    begin
    qryDocumentos.close;
    qryDocumentos.open;
    if pesquisa(qryDocumentos,'Documentos','') and (qryDocumentos.recordCount <> 0) then
      begin
      ceCodDocumento2.text := qryDocumentosCOD_DOCUMENTO.AsString;
      end;
    end;
end;

procedure TfrmSolucoes.ceCodDocumento2Change(Sender: TObject);
begin
     if trim(ceCodDocumento2.text) = '' then
        edDocumento2.Text := ''
     else
       begin
       qryNDocumento.Close;
       qryNDocumento.ParamByName('COD_DOCUMENTO').Value :=  ceCodDocumento2.text;
       qryNDocumento.Open;
       edDocumento2.Text := qryNDocumentoNOME_DOCUMENTO.AsString;
       end;
end;

procedure TfrmSolucoes.ceCodDocumentoButtonClick(Sender: TObject);
begin
 if (dsSolucoes.State <> dsBrowse) then
    begin
    qryDocumentos.close;
    qryDocumentos.open;
    if pesquisa(qryDocumentos,'Documentos','') and (qryDocumentos.recordCount <> 0) then
      begin
      ceCodDocumento.text := qryDocumentosCOD_DOCUMENTO.AsString;
      end;
    end;
end;

procedure TfrmSolucoes.ceCodDocumentoChange(Sender: TObject);
begin
     if trim(ceCodDocumento.text) = '' then
        edDocumento.Text := ''
     else
       begin
       qryNDocumento.Close;
       qryNDocumento.ParamByName('COD_DOCUMENTO').Value :=  ceCodDocumento.text;
       qryNDocumento.Open;
       edDocumento.Text := qryNDocumentoNOME_DOCUMENTO.AsString;
       end;
end;

procedure TfrmSolucoes.ceProcessoButtonClick(Sender: TObject);
begin
  qryProcesso.close;
  qryProcesso.open;
  if pesquisa(qryProcesso,'Processo','') and (qryProcesso.recordCount <> 0) then
    begin
    ceProcesso.text := qryProcessoCOD_PROCESSO.AsString;
    end;
end;

procedure TfrmSolucoes.ceProcessoChange(Sender: TObject);
begin
     qrySolucoes.Close;
     ceAssunto.Text := '';

     if trim(ceProcesso.text) = '' then
       edProcesso.Text := ''
     else
       begin
       qryNProcesso.Close;
       qryNProcesso.ParamByName('COD_PROCESSO').Value :=  ceProcesso.text;
       qryNProcesso.Open;
       if (qryNProcesso.RecordCount <> 0) then
         begin
          edProcesso.Text := qryNProcessoPROCESSO.AsString;
          //qrySolucoes.Close;
          //qrySolucoes.ParamByName('COD_PROCESSO').Value := ceProcesso.text;
          //qrySolucoes.ParamByName('COD_ASSUNTO').Value  := ceAssunto.text;
          //qrySolucoes.Open;
         end;
       end;
end;

procedure TfrmSolucoes.dsSolucoesStateChange(Sender: TObject);
begin
  edProcesso.ReadOnly := dsSolucoes.State = dsBrowse;
  edAssunto.ReadOnly  := dsSolucoes.State = dsBrowse;

  mDuvida.ReadOnly  := dsSolucoes.State = dsBrowse;
  mSolucao.ReadOnly := dsSolucoes.State = dsBrowse;
  mSolucao2.ReadOnly := dsSolucoes.State = dsBrowse;
  mSolucao3.ReadOnly := dsSolucoes.State = dsBrowse;

  edVideo.ReadOnly  := dsSolucoes.State = dsBrowse;
  edVideo2.ReadOnly := dsSolucoes.State = dsBrowse;

  ceCodDocumento.ReadOnly := dsSolucoes.State = dsBrowse;
  ceCodDocumento2.ReadOnly := dsSolucoes.State = dsBrowse;

  imagem.ReadOnly  := dsSolucoes.State = dsBrowse;
  imagem2.ReadOnly := dsSolucoes.State = dsBrowse;
  imagem3.ReadOnly := dsSolucoes.State = dsBrowse;

  edChave.ReadOnly  := dsSolucoes.State = dsBrowse;
  edChave2.ReadOnly := dsSolucoes.State = dsBrowse;
  edChave3.ReadOnly := dsSolucoes.State = dsBrowse;
end;



procedure TfrmSolucoes.FormShow(Sender: TObject);
begin
  // qrySolucoes.open;
  pgSolucoes.ActivePageIndex := 0;
  ceProcesso.SetFocus;
  Windows.SetParent(self.Handle,FHandlePai);
end;


procedure TfrmSolucoes.qrySolucoesBeforePost(DataSet: TDataSet);
begin
  qrySolucoesCOD_PROCESSO.AsString := ceProcesso.Text;
  qrySolucoesCOD_ASSUNTO.AsString  := ceAssunto.Text;
end;

procedure TfrmSolucoes.qrySolucoesNewRecord(DataSet: TDataSet);
begin
  qryCodigo.Close;
  qryCodigo.Open;
  qrySolucoesCOD_PROCESSO.AsString := ceProcesso.Text;
  qrySolucoesCOD_ASSUNTO.AsString  := ceAssunto.Text;
  qrySolucoesCOD_SOLUCAO.value  := qryCodigo.FieldByName('COD_SOLUCAO').Value;
  qrySolucoesORDEM.value := qryCodigo.FieldByName('ORDEM').Value;
  qrySolucoesIND_CHATBOT.Value := 'S';
  qrySolucoesIND_DOCUMENTACAO.Value := 'S';

  qryCodigo.Close;
  pgSolucoes.ActivePageIndex := 0;
  mDuvida.SetFocus;
end;

procedure TfrmSolucoes.btnDoc2Click(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(edDocumento2.Text) <> '') and (trim(edDocumento2.Text) <> '') then
  begin
    sdPDF.FileName := edDocumento2.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qryNDocumento.Close;
      qryNDocumento.ParamByName('COD_DOCUMENTO').Value :=  ceCodDocumento2.text;
      qryNDocumento.Open;
      qryNDocumentoDOCUMENTO.SaveToFile(vArquivo);
      qryNDocumento.Close;

      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

procedure TfrmSolucoes.btnDocClick(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(edDocumento.Text) <> '') and (trim(edDocumento.Text) <> '') then
  begin
    sdPDF.FileName := edDocumento.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qryNDocumento.Close;
      qryNDocumento.ParamByName('COD_DOCUMENTO').Value :=  ceCodDocumento.text;
      qryNDocumento.Open;
      qryNDocumentoDOCUMENTO.SaveToFile(vArquivo);
      qryNDocumento.Close;

      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

procedure TfrmSolucoes.btnImg2Click(Sender: TObject);
begin
  if odArq.Execute then
    begin
    imagem2.Text := ExtractFileName(odArq.FileName);
    qrySolucoesIMAGEM2.LoadFromFile(odArq.FileName);
    end;
end;

procedure TfrmSolucoes.btnImg3Click(Sender: TObject);
begin
  if odArq.Execute then
    begin
    imagem3.Text := ExtractFileName(odArq.FileName);
    qrySolucoesIMAGEM3.LoadFromFile(odArq.FileName);
    end;
end;

procedure TfrmSolucoes.btnImgClick(Sender: TObject);
begin
  if odArq.Execute then
    begin
    imagem.Text := ExtractFileName(odArq.FileName);
    qrySolucoesIMAGEM.LoadFromFile(odArq.FileName);
    end;
end;

procedure TfrmSolucoes.btnVerImg2Click(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(imagem2.Text) <> '') and (trim(imagem2.Text) <> '') then
  begin
    sdPDF.FileName := imagem2.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qrySolucoesIMAGEM2.SaveToFile(vArquivo);
      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

procedure TfrmSolucoes.btnVerImg3Click(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(imagem3.Text) <> '') and (trim(imagem3.Text) <> '') then
  begin
    sdPDF.FileName := imagem3.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qrySolucoesIMAGEM3.SaveToFile(vArquivo);
      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

procedure TfrmSolucoes.btnVerImgClick(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(imagem.Text) <> '') and (trim(imagem.Text) <> '') then
  begin
    sdPDF.FileName := imagem.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qrySolucoesIMAGEM.SaveToFile(vArquivo);
      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

end.
