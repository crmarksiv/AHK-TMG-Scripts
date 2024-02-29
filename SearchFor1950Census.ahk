; Script Information ===========================================================
; Name .........: SearchFor1950Census
; Description ..: Search for 1950 Cenus canadates for focus person in Ancestry.cm
; Requires Autohotkey v2.0+ Acc and optionaly NotifyV2
; By Constant(Connie) Marks @ crmarksiv@gmail.com
;==================================================================================================================
; While viewing a person in Ancestry.com if the hotkey is pressed this script will perform the following step.
;1 Press the “Search” button for the selected Person (Not the Tree Seach nor the Search button in the menu bar.
;2 When the All Results screen is presented the script will then select the “Census & Voter list”.
;3 When the All Census & Voter list results screen is presented the script will select 1950s.
; Note that the script was  designed to allow time for the various screen to be presented, and to help you know the script is running Notification messages are presented in the Notification area on your PC.
; If you wish you to use this feature you can modify the code  by removing or Uncomm the Notify calls.
; =================================================================================================================*
; Installation:
; . Install AutoHotkey if not already installed (https://www.autohotkey.com/).
; . Download the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
;  Optionally download the Notify class at https://www.the-automator.com/downloads/maestrith-notify-class-v2/
; . Modify the #Include statements to specify the path of the files where the ahk scirpts are located.
; . Save the script with the ".ahk" extension.
; ==============================================================================
;
; ==============================================================================
;*******************************************************
; Want a clear path for learning AutoHotkey; Take a look at  AutoHotkey courses. https://the-Automator.com/Learn
; They're structured in a way to make learning AHK EASY
;*******************************************************

#Requires Autohotkey v2.0+
#SingleInstance
;#include <Notifyv2>
#include <fNotify>
#Include <acc>

;TraySetIcon  "C:\My icons\1950 Census.png"


; "Define the default actions that will be used for the Notifications. This can be removed if you do not wish to use this feature
;~ Notify.Default :=
;~ {
	;~ HDText        : "1950's Census",
	;~ HDFontSize    : "14",
	;~ HDFontColor   : "298939",
	;~ HDFont        : "Book Antiqua",
	;~ BDText        : "",
	;~ BDFontSize    : "10",
	;~ BDFontColor   : "Black",
	;~ BDFont        : "Book Antiqua",
	;~ GenColor      : "FFD23E",
	;~ GenDuration   : 5,
	;~ GenSound	  : "Notify",
	;~ GenIcon		  : "",
	;~ GenIconSize	  : 30
;~ }

TraySetIcon A_ScriptDir "\icons\1950census.jpg"
;Notify.show("Press shift f12 navigate to 1950's Census")
;#HotIf WinActive("ahk_exe Chrome.exe")
#f10:: ;Search Ancestry for 1950 Census data
{
	;Menu, Tray, Icon, C:\WINDOWS\system32\imageres.dll,102 ;Set custom Script icon ({Name:'Save...'},2000)
	;TraySetIcon "C:\WINDOWS\system32\imageres.dll" 102 ;Set custom Script icon
    answer := fNotify(A_scriptname)

	ancestry := acc.ElementFromHandle('ahk_exe Chrome.exe')
	if !IsObject(ancestry)
	{
		MsgBox 'Chrome is not found', 'Error', 'IconX'
		ExitApp
	}

;Notify.show('looking for 1950 Census Records')
	MsgBox('Be Patient, I am working',,'OK T2')
	lookfor := ' Search '
    	SearchEl := ancestry.WaitElementExist({Name: "Search", State:4194304},10000)
     ckfound(lookfor,SearchEl )
	SearchEl.Highlight()
	;MsgBox ' i am at' A_LineNumber
	 SearchEl.doDefaultAction()

	;

    ;Sleep 1000
		;MsgBox ' i am at' A_LineNumber

	;Notify.show('looking for Census & voter Lists')
	lookfor :=  "Census & voter lists"
	cvlEl := ancestry.WaitElementExist({Name: "Census & voter lists"},10000)
	ckfound(lookfor,cvlEl )
   ; cvlEl .Highlight()
	cvlEl.doDefaultAction()

	;Notify.show('looking for 1950s record')
	LookFor  := 'name: "1950s"'
	El1950 := ancestry.WaitElementExist({Name: "1950s"},10000)
	ckfound(lookfor,El1950 )
   ; El1950.Highlight()
    El1950.DoDefaultAction()
    MsgBox('I am done',,'OK T1')

	;Notify.show('Script has finished his job')
}
ckfound(lookfor,found)
{
    ckobj := IsObject(found) ; Check if the 'found' variable is an object.
    If ckobj = 0 ; If 'found' is not an object (i.e., the element was not found).
    {
    	MsgBox  lookfor 'Selection not found, please try again or start with another person' ; Display a message indicating that the element was not found.
    	exit ; Exit the script.
    }
    return ; Return to the caller.
}