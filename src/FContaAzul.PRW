#Include "Protheus.ch"
#Include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"  
#Include "Rwmake.ch"

/*                                        l
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fLoginCA      บAutor  ณ Luiz Alberto    บ Data ณ  Novrembro/2023   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Login Conta Azul                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CONEDI                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fLoginCA()
Local aArea 	:= GetArea()
Local cClient_Id        := GetNewPar("MV_CLIDCA",'8ClbYE7AqF3kXmbEH6PXvHcf8HFs2PDy')
Local cClient_Secret    := GetNewPar("MV_CLISCA",'158uI31f4OAcuoqTSqzR8dZi8U9N2iiQ')
Local oToken
Local cIToken           := GetNewPar("MV_ITOKCA",'0EIOkygF2M0PzuUbTNNKbQZx8tSPIltr')
Local cRToken           := GetNewPar("MV_RTOKCA",'ugBvXad1ElizCNkosCIGbgtu22dvtv8J')

aHeader 		:= {}
cHeadRet 		:= ""
cHeaderGet 	:= ""
aadd(aHeader,'Authorization: Basic ' + Encode64(AllTrim(cClient_Id) + ':' + AllTrim(cClient_Secret)) )
aAdd(aHeader, 'Content-Type: application/x-www-form-urlencoded')

oRest := FwRest():New('https://api.contaazul.com')

oRest:SetPath('/oauth2/token')

cSend := "grant_type=authorization_code&redirect_uri=https://conedi165571.protheus.cloudtotvs.com.br:2523/rest/OAUTHCALLBACK&code=71vEPKURs7i4E1kOyaStxJGJnauaJZUm"

oRest:SetPostParams(cSend)

If oRest:Post(aHeader)
    conOut(oRest:GetResult())

    cIToken := oRest:cResult

    FWJsonDeserialize(encodeUtf8(cIToken,"UTF-8"), @oToken)

    cIToken := oToken:ACCESS_TOKEN
    cRToken := oToken:REFRESH_TOKEN

    PutMV("MV_ITOKCA",cIToken)
    PutMV("MV_RTOKCA",cRToken)
Else
    conout(oRest:GetLastError())

    cIToken := U_fRefTokenCA()
Endif

RestArea(aArea)
Return cIToken



/*                                        l
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fLoginCA      บAutor  ณ Luiz Alberto    บ Data ณ  Novrembro/2023   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Login Conta Azul                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CONEDI                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fRefTokenCA()
Local aArea 	:= GetArea()
Local cClient_Id        := GetNewPar("MV_CLIDCA",'8ClbYE7AqF3kXmbEH6PXvHcf8HFs2PDy')
Local cClient_Secret    := GetNewPar("MV_CLISCA",'158uI31f4OAcuoqTSqzR8dZi8U9N2iiQ')
Local oToken
Local cIToken           := GetNewPar("MV_ITOKCA",'0EIOkygF2M0PzuUbTNNKbQZx8tSPIltr')
Local cRToken           := GetNewPar("MV_RTOKCA",'ugBvXad1ElizCNkosCIGbgtu22dvtv8J')

aHeader 		:= {}
cHeadRet 		:= ""
cHeaderGet 	:= ""
aadd(aHeader,'Authorization: Basic ' + Encode64(AllTrim(cClient_Id) + ':' + AllTrim(cClient_Secret)) )
aAdd(aHeader, 'Content-Type: application/x-www-form-urlencoded')

oRest := FwRest():New('https://api.contaazul.com')

oRest:SetPath('/oauth2/token')

cSend := "grant_type=refresh_token&refresh_token="+cRToken

oRest:SetPostParams(cSend)

If oRest:Post(aHeader)
    conOut(oRest:GetResult())

    cIToken := oRest:cResult

    FWJsonDeserialize(encodeUtf8(cIToken,"UTF-8"), @oToken)

    cIToken := oToken:ACCESS_TOKEN
    cRToken := oToken:REFRESH_TOKEN

    PutMV("MV_ITOKCA",cIToken)
    PutMV("MV_RTOKCA",cRToken)
Else
    conout(oRest:GetLastError())
Endif

RestArea(aArea)
Return cIToken

User Function fRetDataCA(nTipo)
Local aArea := GetArea()
Local aDados := {}
Local oJson

DEFAULT nTipo := 1

If nTipo == 1 // Lista Fornecedores
    cTokenCA := U_fLoginCA()

    aHeader 		:= {}
    cHeadRet 		:= ""
    cHeaderGet 	:= ""
    aadd(aHeader,'Authorization:Bearer '+ (AllTrim(cTokenCA)) )
    aadd(aHeader,'Content-Type: application/json')
            
    cUrlPedi    := 'https://api.contaazul.com/v1/costumers'

	cJsonParc := HTTPQuote(cUrlPedi, "GET", "", "", 160, aHeader, @cHeaderGet)
		
    nStatusHTTP :=  HttpGetStatus() 

    If ( nStatusHTTP == 200 .OR. nStatusHTTP == 201 ) 
        FWJsonDeserialize(encodeUtf8(cJsonParc,"UTF-8"), @oJson)

        IF ( Valtype(oJson) == "O" )
            ProcRegua(Len(oJson:Data))
        ENDIF
    EndIf
Endif

RestArea(aArea)
Return .T.


/*

Configura็ใo concluํda com sucesso
As suas chaves de acesso foram geradas. Use-as para configurar a sua integra็ใo. Em caso de d๚vidas voc๊ pode ler nossa documenta็ใo no ambiente de testes da API 
client_id: F6jjyUEuyqfaEBQHUrqdUm7PLonbEpx4
client_secret: yplPszl0RHOyNtDpf0lwB55p5H8dp9lP

Espere, ainda tem mais!
Criamos uma conta teste na Conta Azul. Esta conta ficarแ disponํvel para uso por 30 dias. Guarde seus dados para acessar a Conta Azul 

Usuแrio: testebrb@contaazul.com
Senha: dGVzdGVicmI=
"{"refresh_token":"0oA5P97Ov0UfugQH3nBGXQ76GXvOLGwL","token_type":"bearer","access_token":"4jGP40ysTf0EyUcq4UjG13r4kb8bnNeT","expires_in":3600}
"

*/
