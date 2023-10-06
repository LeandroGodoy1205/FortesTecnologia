unit UINT_RelatorioAbastecimento;

interface

Uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRelatorioAbastecimento;

type
  TInt_RelatorioAbastecimento = Class(TComponent)
  Private
    gForm: TfRelatorioAbastecimento;
  Public
    Procedure FormShow;
    Procedure FormClose;
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
  End;

var
  Int_RelatorioAbastecimento: TInt_RelatorioAbastecimento;

implementation

uses UDMSRV_Server;

//Criar e Destruir a Interface
Constructor TInt_RelatorioAbastecimento.Create(AOwner:TComponent);
Begin
    inherited create(AOwner);
    gForm:= AOwner as TFRelatorioAbastecimento;
End;

Destructor TInt_RelatorioAbastecimento.Destroy;
Begin
    inherited destroy;
End;
//-----------------------------

//FormShow
Procedure TInt_RelatorioAbastecimento.FormShow;
Begin
    With gForm Do
      Begin
          //Pagina Inicial do PageControl
          pcgMain.TabIndex:=0;
          mskInicial.Text := DateToStr(now);
          mskFinal.Text := DateToStr(now);
      End;
End;

//FormClose
Procedure TInt_RelatorioAbastecimento.FormClose;
Begin

End;

end.
