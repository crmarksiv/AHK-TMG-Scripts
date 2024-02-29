
; By Constant(Connie) Marks @ crmarksiv@gmail.com
;==================================================================================================================
; While viewing a person in Ancestry.com if the hotkey is pressed this script will perform the following step.
;1 Read the Cipboard
;2 take all but the last field and assign it to Var GivenName
;3 Send Given Name
; ==============================================================================
; Revision 1 30 Sep 2013)
; ==============================================================================
#Requires Autohotkey v2.0+
#SingleInstance
;TraySetIcon "C:\My icons\1st.ico"
;#HotIf WinActive("ahk_exe Chrome.exe") Constant r  Marks 5
f4:: ;Send Given name from Clipboard
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
			GivenName := Array1[1]
		}
	If (NumItems = 3)
		{
		  ; Msgbox array1[1] array1[2]
		   GivenName := Array1[1] " " array1[2]
		}
	MsgBox 'the given name is' GivenName
	;Send GivenName
}









