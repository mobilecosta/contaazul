#Include 'Protheus.ch'

User Function AFTERLOGIN()

Local aArea     := GetArea()

U_fLoginCA()

RestArea(aArea)

Return
