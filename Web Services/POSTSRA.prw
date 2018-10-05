#INCLUDE "TOTVS.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#Include "aarray.ch"
#Include "json.ch"
#INCLUDE "RESTFUL.CH"

WSRESTFUL POSTSRA DESCRIPTION "SRA Rest"

WSDATA session_id      AS string

WSMETHOD PUT  DESCRIPTION "integration" WSSYNTAX "/POSTSRA"

END WSRESTFUL

WSMETHOD PUT  WSSERVICE POSTSRA
	Local lPost := .T.
	Local cBody
	Local oObj
	::SetContentType("application/json")

	cBody := ::GetContent()
	FWJsonDeserialize(cBody,@oObj)
	if empty(cBody)
		cBody := "Sin Valor"
	else
		dbSelectArea("SRA")
		dbSetOrder(1)
		lEncuentra := dbseek(cvaltochar(oObj:FILIAL) + cvaltochar(oObj:MATRICULA))
		if lEncuentra
			SRA->(RecLock('SRA', .F.))
			SRA->RA_FILIAL 	:= cvaltochar(oObj:FILIAL)
			SRA->RA_NOME  	:= cvaltochar(oObj:NOME)
			SRA->RA_RG  	:= cvaltochar(oObj:CPF)
			SRA->RA_EMAIL  	:= cvaltochar(oObj:EMAIL)
			SRA->RA_TELEFON := cvaltochar(oObj:TELEFONE)
			SRA->(MsUnlock())
			dbSkip()
		dbclosearea()
		::SetResponse('{"Status":"' + "Success" + '"}')
		else
		::SetResponse('{"Status":"' + "not found" + '"}')
		end
	endif

Return lPost