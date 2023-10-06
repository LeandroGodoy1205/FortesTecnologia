unit uRelatorioAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  RLParser;

type
  TfRelatorioAbastecimento = class(TForm)
    qryRelatorioAbastecimento: TFDQuery;
    dsRelatorioAbastecimento: TDataSource;
    qryRelatorioAbastecimentoID_VENDA: TIntegerField;
    qryRelatorioAbastecimentoID_BOMBA: TIntegerField;
    qryRelatorioAbastecimentoQTD_VENDA: TCurrencyField;
    qryRelatorioAbastecimentoVLR_VENDA: TFMTBCDField;
    qryRelatorioAbastecimentoDATA_VENDA: TDateField;
    qryRelatorioAbastecimentoDESCRICAO_BOMBA: TStringField;
    qryRelatorioAbastecimentoDESCRICAO_TANQUE: TStringField;
    qryRelatorioAbastecimentoDESCRICAO_COMBUSTIVEL: TStringField;
    Panel1: TPanel;
    Image1: TImage;
    Shape1: TShape;
    lblModulo: TLabel;
    lblOperacao: TLabel;
    pcgMain: TPageControl;
    tbsBancos: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    lblInfo: TLabel;
    Shape5: TShape;
    Panel6: TPanel;
    btnExcluir: TBitBtn;
    BitBtn18: TBitBtn;
    relAbastecimentos: TRLReport;
    RLBand1: TRLBand;
    RLLabel2: TRLLabel;
    Label7: TLabel;
    Label1: TLabel;
    mskInicial: TMaskEdit;
    mskFinal: TMaskEdit;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand3: TRLBand;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel7: TRLLabel;
    rlInicial: TRLLabel;
    RLLabel8: TRLLabel;
    rlFinal: TRLLabel;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel9: TRLLabel;
    RLDBText6: TRLDBText;
    RLBand5: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel11: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel12: TRLLabel;
    RLBand6: TRLBand;
    RLDBResult2: TRLDBResult;
    RLLabel13: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLExpressionParser1: TRLExpressionParser;
    qryRelatorioAbastecimentoVLR_COMIMPOSTO: TCurrencyField;
    procedure relAbastecimentosBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure BitBtn18Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRelatorioAbastecimento: TfRelatorioAbastecimento;

implementation

uses
  UINT_RelatorioAbastecimento, UDMSRV_Server;

{$R *.dfm}

procedure TfRelatorioAbastecimento.BitBtn18Click(Sender: TObject);
begin
  close;
end;

procedure TfRelatorioAbastecimento.btnExcluirClick(Sender: TObject);
begin
  relAbastecimentos.Preview;
end;

procedure TfRelatorioAbastecimento.FormCreate(Sender: TObject);
begin
  Int_RelatorioAbastecimento := TInt_RelatorioAbastecimento.Create(Sender as TComponent);
end;

procedure TfRelatorioAbastecimento.FormDestroy(Sender: TObject);
begin
  Int_RelatorioAbastecimento.Destroy;
end;

procedure TfRelatorioAbastecimento.FormShow(Sender: TObject);
begin
  Int_RelatorioAbastecimento.FormShow;
end;

procedure TfRelatorioAbastecimento.relAbastecimentosBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  qryRelatorioAbastecimento.Close;
  qryRelatorioAbastecimento.ParamByName('PDATA_INICIAL').AsDate := StrToDate(mskInicial.Text);
  qryRelatorioAbastecimento.ParamByName('PDATA_FINAL').AsDate := StrToDate(mskFinal.Text);
  qryRelatorioAbastecimento.Open;

  rlInicial.Caption :=  mskInicial.Text;
  rlFinal.Caption :=  mskFinal.Text;
end;

end.
