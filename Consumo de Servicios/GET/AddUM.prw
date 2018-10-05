/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ADDUM ³ Autor ³ Nahim Terrazas     ³ Data ³ 06/09/2018	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descripcao ³ Addiciona UM								              ³±±
±± this is an example of consume of http Get in Advpl	     			   ±±
±± insert information in SAH - Unidad de Medida							±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

user function ADDUM()

	Local cToken := ""
	Local aHeader := {}
	local cHeadRet:=""
	local oObjJson := nil
	Aadd(aHeader, 'Content-Type: application/json')
	Aadd(aHeader, 'tooken: q2341245784539B2YUT5')
	
	//	cBody,url
	cUrl := "https://smart.Nahim.com.br:4433/api" // URL Example
	sPostRet := HttpGet(cUrl,"",120,aHeader,@cHeadRet)
	if !empty(sPostRet)

		FWJsonDeserialize(sPostRet,@oObjJson)
		Aviso(cUrl,sPostRet,{"Ok"},,,,,.T.)

		nQuantUM 	:= 	len(oObjJson[1]:listMinimumUnit)
		nCadastrados:= 0
		For I = 1  to nQuantUM
			DbSetOrder(1)
			DbSelectArea("SAH")
			cCodigo := oObjJson[1]:[I]:id
			cDescri := oObjJson[1]:[I]:description
			If !DbSeek( xfilial() + cCodigo) // somente si encontra
				RecLock("SAH", .T.) // incluyendo
				SAH->AH_FILIAL := xFilial("SAH")
				SAH->AH_UNIMED := cCodigo
				SAH->AH_UMRES :=  cDescri
				SAH->AH_DESCPO := cDescri
				SAH->AH_DESCIN := cDescri
				MsUnLock() // Confirma e finaliza a operação
				nCadastrados++
			endif
		end
		alert("se registraron " + cvaltochar(nCadastrados) + " ")
	else
		alert("Error")
	endif
return