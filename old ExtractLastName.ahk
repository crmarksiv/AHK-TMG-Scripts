; Script Information ===========================================================
; Name .........: TMG SirName
; Description ..: Extract the Last Name from the clipboard and send to an input field
; Requires Autohotkey v2.0+
; By Constant(Connie) Marks @ crmarksiv@gmail.com
;==================================================================================================================
; While viewing a person in Ancestry.com if the hotkey is pressed this script will perform the following step.
;1 Read the Cipboard
;2 Get the last field and assign it to Var  SirName
;3 Send Given Name
; ==============================================================================
; Revision 1 30 Sep 2013)
; ==============================================================================
#Requires Autohotkey v2.0+
#SingleInstance


TraySetIcon  "C:\My icons\name2.png"

+F3:: ;Send Last name from Clipboard
{
	Array1  := StrSplit(A_Clipboard," ")
	NumItems := Array1.Length
    if (Numitems <2) | (Numitems > 3)
	{
		Msgbox "Cliboard Does not appear to contain a vailid full name `nCorrect or do not use hotkey"
		return
	}
	If (NumItems = 2)
		{
			;MsgBox array1[1]
			 SirName := Array1[2]
		}
	If (NumItems = 3)
		{
		  ; Msgbox array1[1] array1[2]
		    SirName := Array1[3]
		}
	;MsgBox 'the Last is'  SirName
	Send  SirName
}









