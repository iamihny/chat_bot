unit FDOCUMENTO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, DB, MemDS,
  DBAccess, Ora, Grids, DBGrids, StdCtrls, DBCtrls, Buttons, DBSBtncx,
  cxButtons, Mask, ExtCtrls, ShellAPI;

type
  TfrmDocumentos = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    edNome: TDBEdit;
    PEdicao: TPanel;
    sbRefresh: TcxButton;
    dbsbInsert: TDBcxSpeedButton;
    dbsbDelete: TDBcxSpeedButton;
    dbsbEdit: TDBcxSpeedButton;
    dbsbPost: TDBcxSpeedButton;
    dbsbCancel: TDBcxSpeedButton;
    DBEdit2: TDBEdit;
    btnPdf: TSpeedButton;
    btnVerPdf: TSpeedButton;
    Label3: TLabel;
    mDuvida: TDBMemo;
    Label4: TLabel;
    pGrid: TPanel;
    gProcesso: TDBGrid;
    dsDocumento: TOraDataSource;
    qryDocumento: TOraQuery;
    qryDocumentoCOD_DOCUMENTO: TFloatField;
    qryDocumentoNOME_DOCUMENTO: TStringField;
    qryDocumentoDESCRICAO: TStringField;
    qryDocumentoDOCUMENTO: TBlobField;
    qryDocumentoPALAVRA_CHAVE: TStringField;
    qryDocumentoPALAVRA_CHAVE2: TStringField;
    qryDocumentoPALAVRA_CHAVE3: TStringField;
    Label6: TLabel;
    edChave: TDBEdit;
    edChave2: TDBEdit;
    edChave3: TDBEdit;
    qryCodigo: TOraQuery;
    qryCodigoCOD_DOCUMENTO: TFloatField;
    odArq: TOpenDialog;
    sdPDF: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure dsDocumentoStateChange(Sender: TObject);
    procedure qryDocumentoNewRecord(DataSet: TDataSet);
    procedure btnPdfClick(Sender: TObject);
    procedure btnVerPdfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FHandlePai  : THandle;
  end;

var
  frmDocumentos: TfrmDocumentos;

implementation

{$R *.dfm}

procedure TfrmDocumentos.btnPdfClick(Sender: TObject);
begin
  if odArq.Execute then
    begin
    edNome.Text := ExtractFileName(odArq.FileName);
    qryDocumentoDOCUMENTO.LoadFromFile(odArq.FileName);
    end;
end;

procedure TfrmDocumentos.btnVerPdfClick(Sender: TObject);
var vArquivo : String;
begin
  inherited;
  if (trim(edNome.Text) <> '') and (trim(edNome.Text) <> '') then
  begin
    sdPDF.FileName := edNome.Text;
    if sdPDF.Execute then
      begin
      vArquivo := sdPDF.FileName;
      qryDocumentoDOCUMENTO.SaveToFile(vArquivo);
      ShellExecute(0, nil, PChar(vArquivo), nil, nil, SW_SHOWNOACTIVATE);
      end;
  end;
end;

procedure TfrmDocumentos.dsDocumentoStateChange(Sender: TObject);
begin
  edNome.ReadOnly   := dsDocumento.State = dsBrowse;
  mDuvida.ReadOnly  := dsDocumento.State = dsBrowse;
  edChave.ReadOnly  := dsDocumento.State = dsBrowse;
  edChave2.ReadOnly := dsDocumento.State = dsBrowse;
  edChave3.ReadOnly := dsDocumento.State = dsBrowse;
end;

procedure TfrmDocumentos.FormShow(Sender: TObject);
begin
  qryDocumento.Open;
  Windows.SetParent(self.Handle,FHandlePai);
end;

procedure TfrmDocumentos.qryDocumentoNewRecord(DataSet: TDataSet);
begin
  qryCodigo.Close;
  qryCodigo.Open;
  qryDocumentoCOD_DOCUMENTO.value := qryCodigo.FieldByName('COD_DOCUMENTO').Value;
  qryCodigo.Close;
  edNome.SetFocus;
end;

end.
