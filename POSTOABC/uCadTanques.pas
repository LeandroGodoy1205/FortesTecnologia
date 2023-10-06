unit uCadTanques;

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
  TfCadTanques = class(TForm)
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
    dsTanques: TDataSource;
    dbeTanqueID: TDBEdit;
    dbeTanqueDescricao: TDBEdit;
    dbeTanqueCapacidade: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnPesquisar: TBitBtn;
    FDTanques: TFDTable;
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
    FDTanquesID_TANQUE: TIntegerField;
    FDTanquesID_COMBUSTIVEL: TFDAutoIncField;
    FDTanquesDESCRICAO_TANQUE: TStringField;
    FDTanquesCAPACIDADE_TANQUE: TFMTBCDField;
    dblCombustivel: TDBLookupComboBox;
    FDCombustiveis: TFDTable;
    dsCombustiveis: TDataSource;
    FDCombustiveisID_COMBUSTIVEL: TIntegerField;
    FDCombustiveisDESCRICAO_COMBUSTIVEL: TStringField;
    FDCombustiveisVALOR_COMBUSTIVEL: TCurrencyField;
    FDCombustiveisIMPOSTO_COMBUSTIVEL: TCurrencyField;
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
  fCadTanques: TfCadTanques;

implementation

Uses
  UINT_CadTanques, UDMSRV_Server;

{$R *.dfm}

procedure TfCadTanques.BitBtn13Click(Sender: TObject);
begin
  Int_CadTanques.DBActionWindow(3);
end;

procedure TfCadTanques.btnEditarClick(Sender: TObject);
begin
  Int_CadTanques.DBActionWindow(2);
  FDTransaction.StartTransaction;
  FDTanques.Edit;
  pcgMain.TabIndex := 1;
  dbeTanqueDescricao.SetFocus;
end;

procedure TfCadTanques.btnCancelarClick(Sender: TObject);
begin
  Int_CadTanques.DBActionWindow(5);
  FDTanques.Cancel;
end;

procedure TfCadTanques.btnExcluirClick(Sender: TObject);
begin
  Int_CadTanques.DBActionWindow(4);
end;

procedure TfCadTanques.BitBtn18Click(Sender: TObject);
begin
  close;
end;

procedure TfCadTanques.btnNovoClick(Sender: TObject);
begin
  Int_CadTanques.DBActionWindow(1);
  FDTransaction.StartTransaction;
  FDTanques.Append;
  pcgMain.TabIndex := 1;
  dbeTanqueDescricao.SetFocus;
end;

procedure TfCadTanques.btnPesquisarClick(Sender: TObject);
begin
  FDTanques.Filter := ('DESCRICAO_TANQUE LIKE ''%'+edtFiltro.text+'%'' ');
  FDTanques.Filtered := True;
end;

procedure TfCadTanques.edtFiltroExit(Sender: TObject);
begin
  if edtFiltro.Text = '' then
    FDTanques.Filtered := false;
end;

procedure TfCadTanques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Int_CadTanques.FormClose;
  Action:=caFree;
end;

procedure TfCadTanques.FormCreate(Sender: TObject);
begin
  INT_CadTanques := TINT_CadTanques.Create(Sender as TComponent);
end;

procedure TfCadTanques.FormDestroy(Sender: TObject);
begin
  INT_CadTanques.Destroy;
end;

procedure TfCadTanques.FormShow(Sender: TObject);
begin
  INT_CadTanques.FormShow;
  Int_CadTanques.DBActionWindow(5);
end;

end.
