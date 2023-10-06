unit UDMSRV_Server;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,Dialogs,IniFiles, Forms;

type
  TDMSRV_Server = class(TDataModule)
    FDConn: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    Function ConexaoBancoDadosLocal(Usuario,Senha,DataBase,Servidor:String;Sender:TObject):Boolean;
    Function VerificarConexao(Tipo:Integer;Sender:TObject):Boolean;
    Function getConfigTipoConexao(Sender:TObject):String;
    Function getConfigParametrosLocal(Valor:String;Sender:TObject):String;
  end;

var
  DMSRV_Server: TDMSRV_Server;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Function TDMSRV_Server.ConexaoBancoDadosLocal(Usuario,Senha,DataBase,Servidor:String;Sender:TObject):Boolean;
//var ConexaoForm: TFAguardarConexao;
Begin
    With DMSRV_Server Do
      Begin
          Try
            FDConn.LoginPrompt:=False;
            FDConn.Params.Add('CharSet=csNONE');
            FDConn.Params.Add('Database='+DataBase);
            FDConn.Params.Add('DriverID=FB');
            FDConn.Params.Add('Password='+Senha);
            FDConn.Params.Add('Server='+Servidor);
            FDConn.Params.Add('UserName='+Usuario);

            FDConn.Open;

            Result:=FDConn.Connected;
          Except on E:Exception Do
            Begin
                Try FDConn.Close;
                Except
                End;
                //Tratamento de Erros
                MessageDlg('Erro ao conectar a Base de Dados!'+#13#10+#13#10+
                       'Mensagem Erro:'+#13#10+
                       'Erro: '+E.Message,mtError,[mbOK],0);
                Result:=False;
                Exit;
            End;
          End;
      End;
End;

//Tipo = 0-> Teste | 1-> DMServer
Function TDMSRV_Server.VerificarConexao(Tipo:Integer;Sender:TObject):Boolean;
var Servidor,DataBase,Usuario,Senha: String;
Begin
    Result:=False;
    //Verificar Conexão com o Banco de Dados
    With DMSRV_Server Do
      Begin
          If getConfigTipoConexao(Self) <> '' Then
            Begin
                //Local Connection
                If getConfigTipoConexao(Self) = 'LOCAL' Then
                  Begin
                      Servidor:=getConfigParametrosLocal('Servidor',Self);
                      DataBase:=getConfigParametrosLocal('BaseDados',Self);
                      Usuario:=getConfigParametrosLocal('Username',Self);
                      Senha:=getConfigParametrosLocal('Password',Self);

                      If Servidor <> '' Then
                        DataBase:=DataBase;//Servidor+':'+DataBase;

                      Case Tipo Of
                        0:Begin
                              //Teste na Conexão com o Banco de Dados
                                Begin
                                    Result:=True;
                                    Exit;
                                End;
                          End;
                        1:Begin
                              //Conexão Definitiva com o DMServer
                              If not ConexaoBancoDadosLocal(Usuario,Senha,DataBase,Servidor,Self) Then
                                Begin
                                    Exit;
                                End
                              Else
                                Begin
                                    Result:=True;
                                    Exit;
                                End;
                          End;
                      End;
                  End
             End
          Else
            Begin
                //Arquivo de Configuração não existe
                Try
                   Exit;
                 Except on E:Exception Do
                  Begin
                     MessageDlg('Arquivo ini inexistente!'+#13#10+#13#10+
                               'Mensagem Erro:'+#13#10+
                               'Erro: '+E.Message,mtError,[mbOK],0);
                     Exit;
                  End;
                End;
            End;
      End;
End;

Function TDMSRV_Server.getConfigTipoConexao(Sender:TObject):String;
var ConfigIni: TIniFile;
    ConsIniCfg: String;
Begin
    Try
       ConsIniCfg:=ExtractFilePath(Application.ExeName)+'PostoABC.ini';//cNomeConfigIni;
       If not FileExists(ConsIniCfg) Then
         Begin
              Result:='';
              Exit;
         End;
       ConfigIni:=TIniFile.Create(ConsIniCfg);

       //Conexao
       Result:=Uppercase(ConfigIni.ReadString('CONEXAO','TIPO',''));
       ConfigIni.Free;
    Except on E:Exception Do
      Begin
         MessageDlg('Tipo de conexão não configurado!'+#13#10+#13#10+
                       'Mensagem Erro:'+#13#10+
                       'Erro: '+E.Message,mtError,[mbOK],0);
         Result:='';
      End;
    End;
End;

Function TDMSRV_Server.getConfigParametrosLocal(Valor:String;Sender:TObject):String;
var ConfigIni: TIniFile;
    ConsIniCfg: String;
    Servidor,DataBase,Username,Password:String;
Begin
    Try
       Servidor:='';
       DataBase:='';
       Username:='';
       Password:='';

       ConsIniCfg:=ExtractFilePath(Application.ExeName)+'PostoABC.ini';//cNomeConfigIni;
       If not FileExists(ConsIniCfg) Then
         Begin
           Exit;
         End;
       ConfigIni:=TIniFile.Create(ConsIniCfg);

       //BancoDados
       Servidor:=ConfigIni.ReadString('BANCODADOS','SERVIDOR','');
       DataBase:=ConfigIni.ReadString('BANCODADOS','BASEDADOS','');
       Username:=ConfigIni.ReadString('BANCODADOS','USERNAME','');
       Password:=ConfigIni.ReadString('BANCODADOS','PASSWORD','');

       ConfigIni.Free;

       If Uppercase(Valor) = 'SERVIDOR' Then
         Result:=Servidor
       Else If Uppercase(Valor) = 'BASEDADOS' Then
         Result:=DataBase
       Else If Uppercase(Valor) = 'USERNAME' Then
         Result:=UserName
       Else If Uppercase(Valor) = 'PASSWORD' Then
         Result:=Password
       Else
         Result:='';

    Except on E:Exception Do
      Begin
           MessageDlg('Erro com parametros de conexao com BD!'+#13#10+#13#10+
                       'Mensagem Erro:'+#13#10+
                       'Erro: '+E.Message,mtError,[mbOK],0);
          Exit;
      End;
    End;
End;

end.
