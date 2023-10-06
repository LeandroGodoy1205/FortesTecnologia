unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TfVendas = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Shape1: TShape;
    lblModulo: TLabel;
    lblOperacao: TLabel;
    pcgMain: TPageControl;
    tbsBancos: TTabSheet;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    lblInfo: TLabel;
    Shape5: TShape;
    Label4: TLabel;
    edtFiltro: TEdit;
    tbsCombustiveis: TTabSheet;
    Label3: TLabel;
    Shape4: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    btnPesquisar: TBitBtn;
    Panel6: TPanel;
    DBNavigator4: TDBNavigator;
    btnGravar: TBitBtn;
    btnNovo: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    BitBtn18: TBitBtn;
    FDTransaction: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    dbeVendaID: TDBEdit;
    dblVendaBomba: TDBLookupComboBox;
    dbeVendaQuantidade: TDBEdit;
    dbeVendaValor: TDBEdit;
    Label5: TLabel;
    fdVendas: TFDTable;
    dsVendas: TDataSource;
    fdVendasID_VENDA: TIntegerField;
    fdVendasID_BOMBA: TIntegerField;
    fdVendasQTD_VENDA: TCurrencyField;
    fdVendasVLR_VENDA: TFMTBCDField;
    fdBombas: TFDTable;
    fdVendasdesc_bombas: TStringField;
    dsBombas: TDataSource;
    fdTanques: TFDTable;
    dsTanques: TDataSource;
    fdCombustiveis: TFDTable;
    DBText1: TDBText;
    dsCombustiveis: TDataSource;
    fdVendasDATA_VENDA: TDateField;
    DBEdit1: TDBEdit;
    Label8: TLabel;
    fdVendasVLR_COMIMPOSTO: TCurrencyField;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure dbeVendaQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure calcularvalortotal;
  end;

var
  fVendas: TfVendas;

implementation

Uses
  UINT_Vendas, UDMSRV_Server;

{$R *.dfm}

procedure TfVendas.BitBtn13Click(Sender: TObject);
begin
  Int_Vendas.DBActionWindow(3);
end;

procedure TfVendas.btnEditarClick(Sender: TObject);
begin
  Int_Vendas.DBActionWindow(2);
  FDTransaction.StartTransaction;
  FDVendas.Edit;
  pcgMain.TabIndex := 1;
  dblVendaBomba.SetFocus;
end;

procedure TfVendas.btnCancelarClick(Sender: TObject);
begin
  Int_Vendas.DBActionWindow(5);
  FDVendas.Cancel;
end;

procedure TfVendas.btnExcluirClick(Sender: TObject);
begin
  Int_Vendas.DBActionWindow(4);
end;

procedure TfVendas.BitBtn18Click(Sender: TObject);
begin
  close;
end;

procedure TfVendas.btnNovoClick(Sender: TObject);
begin
  Int_Vendas.DBActionWindow(1);
  FDTransaction.StartTransaction;
  fdVendas.Append;
  fdVendas.FieldByName('DATA_VENDA').AsDateTime := DATE;
  pcgMain.TabIndex := 1;
  dblVendaBomba.SetFocus;
end;

procedure TfVendas.btnPesquisarClick(Sender: TObject);
begin
  FDVendas.Filter := 'DESCRICAO_TANQUE LIKE '+ QuotedStr('%'+edtFiltro.text+'%');
  FDVendas.Filtered := True;
end;

procedure TfVendas.calcularvalortotal;
begin
  fdvendas.FieldByName('VLR_VENDA').Value := (fdvendas.FieldByName('QTD_VENDA').Value  * fdCombustiveis.FieldByName('VALOR_COMBUSTIVEL').Value);
  fdvendas.FieldByName('VLR_COMIMPOSTO').Value := (fdvendas.FieldByName('VLR_VENDA').Value +
                                                  (fdvendas.FieldByName('VLR_VENDA').Value *
                                                  (fdCombustiveis.FieldByName('IMPOSTO_COMBUSTIVEL').Value/100)));

end;

procedure TfVendas.dbeVendaQuantidadeExit(Sender: TObject);
begin
  calcularvalortotal;
end;

procedure TfVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Int_Vendas.FormClose;
  Action:=caFree;
end;

procedure TfVendas.FormCreate(Sender: TObject);
begin
  INT_Vendas := TINT_Vendas.Create(Sender as TComponent);
end;

procedure TfVendas.FormDestroy(Sender: TObject);
begin
  INT_Vendas.Destroy;
end;

procedure TfVendas.FormShow(Sender: TObject);
begin
  INT_Vendas.FormShow;
  Int_Vendas.DBActionWindow(5);
end;

end.
