unit uCadBombas;

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
  TfCadBombas = class(TForm)
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
    Label1: TLabel;
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
    dsBombas: TDataSource;
    FDBombas: TFDTable;
    FDBombasID_BOMBAS: TIntegerField;
    FDBombasID_TANQUE: TIntegerField;
    FDBombasDESCRICAO_BOMBA: TStringField;
    dbeBombaID: TDBEdit;
    dbeBombaDescricao: TDBEdit;
    dblBombaTanque: TDBLookupComboBox;
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
  fCadBombas: TfCadBombas;

implementation

Uses
  UINT_CadBombas, UDMSRV_Server;

{$R *.dfm}

procedure TfCadBombas.BitBtn13Click(Sender: TObject);
begin
  Int_CadBombas.DBActionWindow(3);
end;

procedure TfCadBombas.btnEditarClick(Sender: TObject);
begin
  Int_CadBombas.DBActionWindow(2);
  FDTransaction.StartTransaction;
  FDTanques.Edit;
  pcgMain.TabIndex := 1;
  dbeBombaDescricao.SetFocus;
end;

procedure TfCadBombas.btnCancelarClick(Sender: TObject);
begin
  Int_CadBombas.DBActionWindow(5);
  FDTanques.Cancel;
end;

procedure TfCadBombas.btnExcluirClick(Sender: TObject);
begin
  Int_CadBombas.DBActionWindow(4);
end;

procedure TfCadBombas.BitBtn18Click(Sender: TObject);
begin
  close;
end;

procedure TfCadBombas.btnNovoClick(Sender: TObject);
begin
  Int_CadBombas.DBActionWindow(1);
  FDTransaction.StartTransaction;
  FDBombas.Append;
  pcgMain.TabIndex := 1;
  dbeBombaDescricao.SetFocus;
end;

procedure TfCadBombas.btnPesquisarClick(Sender: TObject);
begin
  FDBombas.Filter := 'DESCRICAO_BOMBA LIKE '+QuotedStr('%'+edtFiltro.text+'%');
  FDBombas.Filtered := True;
end;

procedure TfCadBombas.edtFiltroExit(Sender: TObject);
begin
  if edtfiltro.Text = '' then
    FDBombas.Filtered := False;
end;

procedure TfCadBombas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Int_CadBombas.FormClose;
  Action:=caFree;
end;

procedure TfCadBombas.FormCreate(Sender: TObject);
begin
  INT_CadBombas := TINT_CadBombas.Create(Sender as TComponent);
end;

procedure TfCadBombas.FormDestroy(Sender: TObject);
begin
  INT_CadBombas.Destroy;
end;

procedure TfCadBombas.FormShow(Sender: TObject);
begin
  INT_CadBombas.FormShow;
  Int_CadBombas.DBActionWindow(5);
end;

end.
