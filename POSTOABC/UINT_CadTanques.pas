unit UINT_CadTanques;

interface

Uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadTanques;

type
  TInt_CadTanques = Class(TComponent)
  Private
    gForm: TfCadTanques;
  Public
    Procedure FormShow;
    Procedure FormClose;
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    Procedure DBActionWindow(Acao:Integer);
  End;

var
  Int_CadTanques: TInt_CadTanques;

implementation

uses UDMSRV_Server;

//Criar e Destruir a Interface
Constructor TInt_CadTanques.Create(AOwner:TComponent);
Begin
    inherited create(AOwner);
    gForm:= AOwner as TFCadTanques;
End;

procedure TInt_CadTanques.DBActionWindow(Acao: Integer);
begin
    //A��es em Tela iniciadas por BD
    //1 = Novo
    //2 = Editar
    //3 = Gravar
    //4 = Remover
    //5 = Cancelar
    Case Acao Of
      1:Begin //inserir
          //CONFIGURA A�AO HABILITA/DESABILITA BOTOES
          gForm.btnNovo.Enabled     :=False;
          gForm.btnGravar.Enabled   :=True;
          gForm.btnEditar.Enabled   :=False;
          gForm.btnCancelar.Enabled :=True;
          gForm.btnExcluir.Enabled  :=False;

        End;
      2:Begin
          gForm.btnNovo.Enabled     :=False;
          gForm.btnGravar.Enabled   :=True;
          gForm.btnEditar.Enabled   :=False;
          gForm.btnCancelar.Enabled :=True;
          gForm.btnExcluir.Enabled  :=False;
        End;
      3:Begin
             gForm.btnNovo.Enabled     :=True;
             gForm.btnGravar.Enabled   :=False;
             gForm.btnEditar.Enabled   :=True;
             gForm.btnCancelar.Enabled :=False;
             gForm.btnExcluir.Enabled  :=True;
             Try
                gForm.FDTanques.post;
                gForm.FDTransaction.CommitRetaining;
                gForm.FDTanques.Refresh;
             Except on E:Exception Do
                Begin
                  DMSRV_Server.FDConn.Rollback;
                  MessageDlg('Problemas ao gravar o registro.'+#13#10+
                  'Erro: '+E.Message, mtError, [mbOk], 0);
                End;
             end;
        End;
      4:Begin
          if gForm.FDTanques.RecordCount <> 0 then
            begin
              If MessageDlg('Deseja remover esta cadastro? (ap�s a confirma��o, a opera��o n�o poder� ser cancelada)', mtConfirmation, [mbYes, mbNo],0) = mrYes Then
                 Begin
                   Try
                     gForm.FDTanques.Delete;
                   Except on E:Exception Do
                     Begin
                        DMSRV_Server.FDConn.Rollback;
                        MessageDlg('Problemas ao remover o registro.'+#13#10+
                                   'Erro: '+E.Message, mtError, [mbOk], 0);
                      End;
                    end;
                 End;
            end;
        End;
      5:Begin
          gForm.btnNovo.Enabled     :=True;
          gForm.btnGravar.Enabled   :=False;
          gForm.btnEditar.Enabled   :=True;
          gForm.btnCancelar.Enabled :=False;
          gForm.btnExcluir.Enabled  :=True;
        End;
      6:Begin
        
        end;
    End;
end;

Destructor TInt_CadTanques.Destroy;
Begin
    inherited destroy;
End;
//-----------------------------

//FormShow
Procedure TInt_CadTanques.FormShow;
Begin
    With gForm Do
      Begin
          //Pagina Inicial do PageControl
          pcgMain.TabIndex:=0;
          Try
            FDTanques.open;
            FDCombustiveis.Open;
          Except on E:Exception Do
            Begin
              MessageDlg('Erro ao Carregar as Tabelas de Combust�veis!'+#13#10+#13#10+
                         'Mensagem Erro:'+#13#10+
                         'Erro: '+E.Message,mtError,[mbOK],0);
              Exit;
            End;
          End;
      End;
End;

//FormClose
Procedure TInt_CadTanques.FormClose;
Begin
    With gForm Do
      Begin
         FDTanques.Close;
         FDCombustiveis.Close;
      End;
End;

end.
