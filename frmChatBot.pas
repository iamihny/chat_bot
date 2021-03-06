unit frmChatBot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, ExtCtrls, dblookup, Mask,
  DBCtrls, StdCtrls, rxToolEdit, RXDBCtrl, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, DBSBtncx, cxButtons;

type
  TForm1 = class(Tform)
    dbDatasys: TOraSession;
    qrySolucoes: TOraQuery;
    qrySolucoesPERGUNTA: TStringField;
    qrySolucoesRESPOSTA: TStringField;
    qrySolucoesPALAVRA_CHAVE: TStringField;
    qrySolucoesASSUNTO: TStringField;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    dsSolucoes: TOraDataSource;
    lbDuvida: TLabel;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    DBMemo2: TDBMemo;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    qryModulo: TOraQuery;
    Label4: TLabel;
    qryModuloCOD_MODULO: TFloatField;
    qryModuloMODULO: TStringField;
    qryModuloCOD_MENU: TStringField;
    ceModulo: TRxDBComboEdit;
    qrySolucoesCOD_MODULO: TFloatField;
    edModulo: TEdit;
    qryNomeModulo: TOraQuery;
    qryNomeModuloMODULO: TStringField;
    qryAssunto: TOraQuery;
    Button1: TButton;
    edAssunto: TDBEdit;
    qryAssuntoDESCRICAO: TStringField;
    qryNomeModuloCOD_MENU: TStringField;
    PEdicao: TPanel;
    sbRefresh: TcxButton;
    dbsbInsert: TDBcxSpeedButton;
    dbsbDelete: TDBcxSpeedButton;
    dbsbEdit: TDBcxSpeedButton;
    dbsbPost: TDBcxSpeedButton;
    dbsbCancel: TDBcxSpeedButton;
    qryCodigo: TOraQuery;
    qryCodigoCOD_PERGUNTA: TFloatField;
    qrySolucoesCOD_PERGUNTA: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure ceModuloButtonClick(Sender: TObject);
    procedure ceModuloChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure qrySolucoesNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation

uses ysfm0500;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  qryAssunto.ParamByName('COD_MODULO').value := ceModulo.text;
  qryAssunto.open;
  if pesquisa(qryAssunto,'Assunto','') and (qryAssunto.recordCount <> 0) then
    edAssunto.text := qryAssuntoDESCRICAO.AsString;
  qryAssunto.close;
end;

procedure TForm1.ceModuloButtonClick(Sender: TObject);
begin
  qryModulo.close;
  qryModulo.open;
  if pesquisa(qryModulo,'Modulo','') and (qryModulo.recordCount <> 0) then
    begin
    ceModulo.text := qryModuloCOD_MODULO.AsString;
    end;
end;

procedure TForm1.ceModuloChange(Sender: TObject);
begin
     if trim(ceModulo.text) = '' then
        edModulo.Text := ''
     else
       begin
       qryNomeModulo.Close;
       qryNomeModulo.ParamByName('COD_MODULO').Value :=  ceModulo.text;
       qryNomeModulo.Open;
       edModulo.Text := qryNomeModuloMODULO.AsString;
       end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrySolucoes.Close;
  qryModulo.close;
  dbDatasys.Connected := False;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  qrySolucoes.Open;
end;

procedure TForm1.qrySolucoesNewRecord(DataSet: TDataSet);
begin
  qryCodigo.Close;
  qryCodigo.Open;
  qrySolucoesCOD_PERGUNTA.value := qryCodigo.FieldByName('COD_PERGUNTA').Value;
  qryCodigo.Close;
end;

end.
