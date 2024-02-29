;~ #Requires Autohotkey v2.0+
;~ #SingleInstance force
;~ #Include C:\Users\Connie Mini PC\OneDrive\Documents\AutoHotkey\Lib\Acc.ahk
;~ !Z::
;~ {
 ;~ ID := GetFocusID()
 ;~ ;MsgBox 'the foucus person id is>' ID '<'
;~ A_Clipboard := ID
;~ }

GetFocusID()
{
	/*
		This function make TMG the active window, builds an object,finds the Copy Persons(s) Drop under The Add Tab, then reads the ID
		Requires the ACC libary
	*/

	WinActivate 'ahk_class tmg99c000000'
	if !Winwait('ahk_class tmg99c000000',,5)
			throw

	TMGo := acc.ElementFromHandle('ahk_class tmg99c000000') ; Connected to TMG

	XXX := TMGo.FindElement({Name:"Copy Person(s)"}).DoDefaultAction()
    ID  :=  TMGo.FindElement({Name:"txtInput"}).value
	XXX := TMGo.FindElement({Name:"Cancel"}).DoDefaultAction()


	 return ID

}