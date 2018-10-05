#include 'protheus.ch'
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT462MNU �Autor  �Nahim Terrazas� Data �  27/09/18   		  ���
�������������������������������������������������������������������������͹��
���Desc.     �Punto de Entrada que adiciona un boton para imprimir        ���
���          �de acuerdo a una rutina en especifica 					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT462MNU()
	Do Case
		Case FUNNAME()=='MATA102N'      // remito
		AADD(AROTINA,{ 'HOLA NAHIM',"U_NAHIM()"     , 0 , 5})
		AADD(AROTINA,{ 'NUM PEDIDO',"U_GETNUMPED()"     , 0 , 5})
	EndCase

Return
