unit uCadCombustiveis;

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
  TfCadCombustiveis = class(TForm)
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
    dsCombustivel: TDataSource;
    dbeCombustivelId: TDBEdit;
    dbeCombustivelDescricao: TDBEdit;
    dbeCombustivelValor: TDBEdit;
    dbeCombustivelImposto: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnPesquisar: TBitBtn;
    FDCombustivel: TFDTable;
    FDCombustivelID_COMBUSTIVEL: TIntegerField;
    FDCombustivelDESCRICAO_COMBUSTIVEL: TStringField;
    FDCombustivelVALOR_COMBUSTIVEL: TCurrencyField;
    FDCombustivelIMPOSTO_COMBUSTIVEL: TCurrencyField;
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
    procedure edtFiltroExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCadCombustiveis: TfCadCombustiveis;

implementation

Uses
  UINT_CadCombustiveis, UDMSRV_Server;

{$R *.dfm}

procedure TfCadCombustiveis.BitBtn13Click(Sender: TObject);
begin
  Int_CadCombustiveis.DBActionWindow(3);
end;

procedure TfCadCombustiveis.btnEditarClick(Sender: TObject);
begin
  Int_CadCombustiveis.DBActionWindow(2);
  FDTransaction.StartTransaction;
  FDCombustivel.Edit;
  pcgMain.TabIndex := 1;
  dbeCombustivelId.SetFocus;
end;

procedure TfCadCombustiveis.btnCancelarClick(Sender: TObject);
begin
  Int_CadCombustiveis.DBActionWindow(5);
  FDCombustivel.Cancel;
end;

procedure TfCadCombustiveis.btnExcluirClick(Sender: TObject);
begin
  Int_CadCombustiveis.DBActionWindow(4);
end;

procedure TfCadCombustiveis.BitBtn18Click(Sender: TObject);
begin
  close;
end;

procedure TfCadCombustiveis.btnNovoClick(Sender: TObject);
begin
  Int_CadCombustiveis.DBActionWindow(1);
  FDTransaction.StartTransaction;
  FDCombustivel.Append;
  pcgMain.TabIndex := 1;
  dbeCombustivelDescricao.SetFocus;
end;

procedure TfCadCombustiveis.btnPesquisarClick(Sender: TObject);
begin
  FDCombustivel.Filter := 'DESCRICAO_COMBUSTIVEL LIKE '+ QuotedStr('%'+edtFiltro.text+'%');
  FDCombustivel.Filtered := True;
end;

procedure TfCadCombustiveis.edtFiltroExit(Sender: TObject);
begin
  if edtfiltro.Text  = '' then
      FDCombustivel.Filtered := False;
end;

procedure TfCadCombustiveis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Int_CadCombustiveis.FormClose;
  Action:=caFree;
end;

procedure TfCadCombustiveis.FormCreate(Sender: TObject);
begin
  INT_CadCombustiveis := TINT_CadCombustiveis.Create(Sender as TComponent);
end;

procedure TfCadCombustiveis.FormDestroy(Sender: TObject);
begin
  INT_CadCombustiveis.Destroy;
end;

procedure TfCadCombustiveis.FormShow(Sender: TObject);
begin
  INT_CadCombustiveis.FormShow;
  Int_CadCombustiveis.DBActionWindow(5);
end;

end.
