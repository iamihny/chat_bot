{------------------------------------------------------------------------------
 Módulo : YSFM0500
 Função : Formulário Padrão Datasys de Pesquisa para Manutenção de Tabelas
 Data   : Porto Alegre, 31 de julho de 1998
 Autor  : Edson Victoria Celente
 ------------------------------------------------------------------------------}
unit Ysfm0500;

interface

uses Variants,  Maskutils, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, Db, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, Mask, RXDBCtrl,
  StrUtils ,dbCtrls, ComCtrls, ComCtrls95, ImgList, RxMemDS, bsutils, ora, MemDS,
  DBAccess, OraSmart, dbTables, DBSBtn, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, DBSBtncx;

type
  TfmYsfm0500 = class(TForm)
    DataSource: TDataSource;
    ImageList1: TImageList;
    Panel1: TPanel;
    dbgPesquisa: TRxDBGrid;
    Panel2: TPanel;
    pcPesquisa: TPage95Control;
    pcProcurar: TTab95Sheet;
    Label3: TLabel;
    Label2: TLabel;
    BotPesquisa: TSpeedButton;
    cbCampos: TComboBox;
    edLocaliza: TEdit;
    tsPosicionar: TTab95Sheet;
    Label1: TLabel;
    Label4: TLabel;
    botPosiciona: TSpeedButton;
    cbindices: TComboBox;
    edPosiciona: TEdit;
    Panel3: TPanel;
    BtnConfirmar: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    dbsbFirst: TDBcxSpeedButton;
    dbsbPrior: TDBcxSpeedButton;
    dbsbNext: TDBcxSpeedButton;
    dbsbLast: TDBcxSpeedButton;
    DBSpeedButton1: TDBSpeedButton;
    procedure dbgPesquisaGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure dbgPesquisaTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure cbindicesChange(Sender: TObject);
    procedure edLocalizaChange(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure BotPesquisaClick(Sender: TObject);
    procedure edLocalizaKeyPress(Sender: TObject; var Key: Char);
    procedure edPosicionaChange(Sender: TObject);
    procedure edPosicionaKeyPress(Sender: TObject; var Key: Char);
    procedure cbCamposChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure botPosicionaClick(Sender: TObject);
    procedure edLocalizaEnter(Sender: TObject);
    procedure edLocalizaExit(Sender: TObject);
    procedure FiltrarArgumento(DataSet: TDataSet; var Accept: Boolean);
    procedure edPosicionaEnter(Sender: TObject);
    procedure edPosicionaExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    CampoPes: TField;
    CampoPos: TField;
    Ordem_Alterada : Boolean;
    vTabela : Tdataset;
    vTitulo : String;
    vCampoIndice : String;

    salvaindices : String;
    Filtrada : Boolean;
    SalvaFiltro : TFilterRecordEvent;
    SalvaOrdem : Tstringlist;

    CFValores : Variant;
    cfCampos  : String;

    salvaend : Tbookmark;

     { Private declarations }
  public
//     function ShowModalPesquisa(Tabela: Tdataset; Titulo : String; CampoIndice: String): integer;
     { Public declarations }
    property Tabela       : TDataset  read vTabela      write vTabela;
    property Titulo       : String    read vTitulo      write vTitulo;
    property CampoIndice  : String    read vcampoIndice write vCampoIndice;
  end;

function Pesquisa(Tabela : Tdataset; Titulo : String; CampoIndice: String) : Boolean;

var
  fmYsfm0500: TfmYsfm0500;
  ind : integer;

implementation
  {$R *.DFM}

function Pesquisa(Tabela : Tdataset; Titulo : String; CampoIndice: String) : Boolean;
begin
   fmysfm0500 := Tfmysfm0500.Create(Application);
   fmysfm0500.Tabela := Tabela;
   fmysfm0500.Titulo := Titulo;
   fmysfm0500.CampoIndice := campoIndice;
   if fmysfm0500.ShowModal = mrok then
      result := True
   else
      result := False;
   fmysfm0500.Free;
end;

procedure TfmYsfm0500.dbgPesquisaGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  if cbIndices.Items.Count < 1 then
     exit;

  if Field.Displaylabel = CbIndices.Text then
     Background := clSilver;

  if Highlight then
     begin
        AFont.Color := clHighlightText;
        Background := clHighlight;
     end;
end;

procedure TfmYsfm0500.dbgPesquisaTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
var
i : integer;
begin
  if cbIndices.items.Count > 0 then
     for i := 0 to cbIndices.Items.Count - 1 do
       if Field.DisplayLabel = cbIndices.Items.Strings[i] then
          begin
            cbIndices.itemindex := i;
            cbIndiceschange(nil);
            exit;
          end;
end;

procedure TfmYsfm0500.dbgPesquisaDblClick(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TfmYsfm0500.cbindicesChange(Sender: TObject);
var
 i : integer;
 x : integer;
 s : string;
 R : INTEGER;
 z : integer;
 cf : Tfield;
begin
  if cbindices.itemindex < 0 then
     exit;

  z  := cbIndices.ItemIndex;
  cf := cbIndices.items.objects[cbIndices.itemindex] as Tfield;

  if (Datasource.DataSet is TTable) then
     begin
      (Datasource.dataset as ttable).indexFieldNames := (cbIndices.Items.Objects[z] as Tfield).FieldName;
       Ordem_Alterada := True;
     end
  else
  begin
      if datasource.dataset is Toraquery then
         with datasource.DataSet as Toraquery do
           begin
             active := False;
             x := -1;
             for i:=0 to sql.count -1 do
                begin
                  s := Uppercase(Sql.Strings[i]);
                  if Pos('ORDER BY',s) > 0 then
                     x := i;
                end;
             r := sql.count -1;
             if x > -1 then
                for i:= r downto x do
                    sql.Delete(i);
             sql.Add('ORDER BY ' + (cbIndices.Items.Objects[z] as Tfield).FieldName);
             Ordem_Alterada := True;
             active := True;
           end
      else
      if datasource.dataset is Tsmartquery then
         with datasource.DataSet as Tsmartquery do
           begin
             active := False;
             x := -1;
             for i:=0 to sql.count -1 do
                begin
                  s := Uppercase(Sql.Strings[i]);
                  if Pos('ORDER BY',s) > 0 then
                     x := i;
                end;
             r := sql.count -1;
             if x > -1 then
                for i:= r downto x do
                    sql.Delete(i);
             sql.Add('ORDER BY ' + (cbIndices.Items.Objects[z] as Tfield).FieldName);
             Ordem_Alterada := True;
             active := True;
           end
  end;

  try
    CampoPos := cbIndices.Items.Objects[cbindices.itemindex] as TField;
    edPosiciona.Text := '';
  except
    CampoPos := nil;
    edPosiciona.Text := '';
  end;
end;

procedure TfmYsfm0500.edPosicionaChange(Sender: TObject);
begin
  BotPosiciona.Enabled := edPosiciona.Text <> '';
end;

procedure TfmYsfm0500.edPosicionaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
     begin
       botPosicionaClick(nil);
       exit;
     end;

  if Assigned(CampoPos) then
     if (CampoPos.IsValidChar(Key)) then
        exit;
  if key = #8 then
     exit;
  MessageBeep(0);
  Key := #0;
end;

procedure TfmYsfm0500.cbCamposChange(Sender: TObject);
var
 i : integer;
begin
  if cbCampos.itemindex < 0 then
     exit;

  i := cbCampos.ItemIndex;

  try
    CampoPes := cbCampos.Items.Objects[i] as TField;
    edLocaliza.MaxLength := CampoPes.Size;
    edlocaliza.Text := '';
  except
    CampoPes := nil;
    edlocaliza.Text := '';
  end;
end;

procedure TfmYsfm0500.edLocalizaChange(Sender: TObject);
begin
  BotPesquisa.Enabled := edlocaliza.Text <> '';
  if length(edLocaliza.text) = 0 then
     Datasource.DataSet.OnFilterRecord := nil;
end;

procedure TfmYsfm0500.edLocalizaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
     begin
       botPesquisaClick(nil);
       exit;
     end;

  if Assigned(CampoPes) then
     if (CampoPes.IsValidChar(Key)) then
        exit;

  if key = #8 then
     exit;

  MessageBeep(0);
  Key := #0;
end;

procedure TfmYsfm0500.BotPesquisaClick(Sender: TObject);
begin

  try
    if (datasource.DataSet is TTable) then
       begin
         Datasource.DataSet.OnFilterRecord := FiltrarArgumento;
         Datasource.DataSet.Filtered := True;
         Datasource.DataSet.Refresh
       end
    else
       begin
//         DataSource.DataSet.Active := False;
         Datasource.DataSet.OnFilterRecord := FiltrarArgumento;
         Datasource.DataSet.Filtered := True;
//         DataSource.DataSet.Active := True;
       end;
  except
  end;

end;

procedure TfmYsfm0500.FormShow(Sender: TObject);
var
 i : integer;
 x : integer;
 s : string;
begin
   salvaend := Tabela.GetBookmark;
   SalvaOrdem := Tstringlist.Create;
   Ordem_Alterada := False;
   DataSource.DataSet := Tabela;
   if (Tabela is TTable) then
      with (Tabela as TTable) do
        SalvaIndices := indexFieldNames
   else
   begin
       if datasource.DataSet is Toraquery then
         with (datasource.DataSet as Toraquery) do
           begin
             SalvaOrdem := Tstringlist.Create;
             x := -1;
             for i:=0 to sql.count -1 do
                begin
                  s := Uppercase(Sql.Strings[i]);
                  if Pos('ORDER BY',s) > 0 then
                     x := i;
                end;
             if x > -1 then
                for i:= x to sql.count -1 do
                    SalvaOrdem.Add(sql.Strings[i]);
           end
       else
       if datasource.DataSet is Tsmartquery then
         with (datasource.DataSet as Tsmartquery) do
           begin
             SalvaOrdem := Tstringlist.Create;
             x := -1;
             for i:=0 to sql.count -1 do
                begin
                  s := Uppercase(Sql.Strings[i]);
                  if Pos('ORDER BY',s) > 0 then
                     x := i;
                end;
             if x > -1 then
                for i:= x to sql.count -1 do
                    SalvaOrdem.Add(sql.Strings[i]);
           end
  end;

   Filtrada := Tabela.Filtered;
   SalvaFiltro := Tabela.OnFilterRecord;

   if Tabela.FieldCount > 0 then
      for i:=0 to Tabela.FieldCount -1 do
        begin
          if tabela.Fields[i].FieldKind = fkData then
             if tabela.Fields[i].Visible = True then
                begin
                  x := cbCampos.items.Addobject(Tabela.Fields[i].DisplayLabel,Tabela.Fields[i]);
                  x := cbIndices.items.Addobject(Tabela.Fields[i].DisplayLabel,Tabela.Fields[i]);
                  if Tabela.Fields[i].fieldname = CampoIndice then
                     begin
                       cbIndices.ItemIndex := x;
                       cbCampos.itemIndex := x;
                     end;
                end;
        end;

   caption := application.Title + ' - ' + Titulo;

   if cbIndices.Items.Count > 0 then
      cbIndicesChange(nil);
   cbCamposChange(nil);
   //Novo, incluído em 04/02/2013 para setar o focu no campo de pesquisa.
   if (pcPesquisa.ActivePage = pcProcurar) and (cbCampos.ItemIndex >= 0) then
     edLocaliza.SetFocus;
end;

procedure TfmYsfm0500.botPosicionaClick(Sender: TObject);
Var
 i : integer;
begin
  if cbIndices.ItemIndex < 0 then
     exit;
  i := cbIndices.ItemIndex;

  if not Datasource.Dataset.Locate((cbIndices.items.objects[i] as Tfield).Fieldname, edPosiciona.Text,
    [loCaseInsensitive, loPartialKey]) then
      MessageDlg('Não existe argumento especificado.', mtInformation, [mbOK], 0);

end;

procedure TfmYsfm0500.edLocalizaEnter(Sender: TObject);
begin
  btnConfirmar.Default := False;
end;

procedure TfmYsfm0500.edLocalizaExit(Sender: TObject);
begin
  btnConfirmar.Default := True;
end;

procedure TfmYsfm0500.FiltrarArgumento(DataSet: TDataSet;
  var Accept: Boolean);
var
 i : integer;
 s : string;
 e : string;
begin
  Accept := False;
  if Length(edlocaliza.Text) > 0 then
     begin
       s := dataset.fieldbyname(campopes.FieldName).asstring;

       s := Uppercase(S);
       s := replace(s,'ç','Ç',true);
       s := replace(s,'á','Á',true);
       s := replace(s,'é','É',true);
       s := replace(s,'í','Í',true);
       s := replace(s,'ó','Ó',true);
       s := replace(s,'ú','Ú',true);
       s := replace(s,'à','À',true);
       s := replace(s,'ã','Ã',true);
       s := replace(s,'õ','Õ',true);
       s := replace(s,'â','Â',true);
       s := replace(s,'ê','Ê',true);
       s := replace(s,'ô','Ô',true);
       s := replace(s,'ü','Ü',true);

       e := Uppercase(edlocaliza.Text);

       e := replace(e,'ç','Ç',true);
       e := replace(e,'á','Á',true);
       e := replace(e,'é','É',true);
       e := replace(e,'í','Í',true);
       e := replace(e,'ó','Ó',true);
       e := replace(e,'ú','Ú',true);
       e := replace(e,'à','À',true);
       e := replace(e,'ã','Ã',true);
       e := replace(e,'õ','Õ',true);
       e := replace(e,'â','Â',true);
       e := replace(e,'ê','Ê',true);
       e := replace(e,'ô','Ô',true);
       e := replace(e,'ü','Ü',true);

       if length(s) < length(e) then
          exit;
       for i := 1 to (Length(s) - Length(e) +1) do
           if Copy(s,i,Length(e)) = e then
              begin
                Accept := True;
                break;
              end;
     end;
end;

procedure TfmYsfm0500.edPosicionaEnter(Sender: TObject);
begin
  btnConfirmar.Default := False;
end;

procedure TfmYsfm0500.edPosicionaExit(Sender: TObject);
begin
  btnConfirmar.Default := True;
end;

procedure TfmYsfm0500.FormDestroy(Sender: TObject);
var
 i : integer;
 x : integer;
 s : string;
 v : Integer;
 r : integer;
begin
  if modalresult = mrOK  then
     begin
        v := 0;
        cfCampos := '';
        CFValores := VarArrayCreate([0,v], varVariant);
        if Tabela.FieldCount > 10 then
           x := 10
        else
           x := Tabela.fieldcount;
        for i:=0 to x -1 do
            if tabela.Fields[i].FieldKind = fkData then
               if (tabela.fields[i].datatype <> ftBlob) and
                  (tabela.fields[i].datatype <> ftMemo) and
                  (tabela.fields[i].value <> NULL) then
                  if v = 0  then
                     begin
                       cfValores[v] := Tabela.fields[i].VALUE;
                       cfCampos     := Tabela.Fields[i].FieldName;
                       inc(v);
                     end
                  else
                     begin
                       VarArrayRedim(cfValores,v);
                       cfValores[v] := tabela.fields[i].VALUE;
                       cfCampos := cfCampos + ';' + Tabela.Fields[i].FieldName;
                       inc(v);
                     end;
     end;

   Tabela.Filtered := Filtrada;
   Tabela.OnFilterRecord := SalvaFiltro;

   if Ordem_Alterada then
     if (Tabela is TTable) then
          with (Tabela as TTable) do
             begin
               indexFieldNames := SalvaIndices;
               refresh;
             end
     else
     begin
           Tabela.Active := False;
           if datasource.dataset is ToraQuery then
              with datasource.DataSet as Toraquery do
                 begin
                   x := -1;
                   for i:=0 to sql.count -1 do
                     begin
                       s := Uppercase(Sql.Strings[i]);
                       if Pos('ORDER BY',s) > 0 then
                          x := i;
                     end;
                   r := sql.count -1;
                   if x > -1 then
                      for i:= r downto x do
                          sql.Delete(i);
                   if SalvaOrdem.Count > 0 then
                      for i:=0 to SalvaOrdem.Count - 1 do
                          sql.Add(SalvaOrdem.Strings[i]);
                 end
           else
           if datasource.dataset is TsmartQuery then
              with datasource.DataSet as Tsmartquery do
                 begin
                   x := -1;
                   for i:=0 to sql.count -1 do
                     begin
                       s := Uppercase(Sql.Strings[i]);
                       if Pos('ORDER BY',s) > 0 then
                          x := i;
                     end;
                   r := sql.count -1;
                   if x > -1 then
                      for i:= r downto x do
                          sql.Delete(i);
                   if SalvaOrdem.Count > 0 then
                      for i:=0 to SalvaOrdem.Count - 1 do
                          sql.Add(SalvaOrdem.Strings[i]);
                 end;
       Tabela.active := True;
     end;

   SalvaOrdem.Free;

   if Modalresult <> mrOK then
      begin
        Tabela.GotoBookmark(salvaend);
        Tabela.FreeBookmark(salvaend);
      end
   else
      begin
        Tabela.FreeBookmark(salvaend);
        if not Tabela.Locate(cfCampos,cfValores,[])
           then showmessage('Não foi possível localizar o registro selecionado');
      end;
   Tabela := nil;
end;

end.
