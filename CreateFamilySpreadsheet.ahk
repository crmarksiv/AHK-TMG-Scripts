/*
Script Name: CreateFamilySpreadsheet
Description: This script automates the process of creating a family spreadsheet in a specific program (identified by window class "ahk_class tmg99c000000").
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024

Usage:
 . Install AutoHotkey if not already installed (https://www.autohotkey.com/).
  . Download Requires the function fGetFocusID which can be found in this library
 . Modify the #Include statements to specify the path of the files where the ahk scirpts are located.
 . Save the script with the ".ahk" extension.
. Double-click the script file to run it
. In TMG single click a Tag that contains the desired person as the Principal person
. Press the designated hotkey (!z by default) to initiate the process of creating a family spreadsheet in the target program.
. The program is expecting the TMG Report definition to specify the Report Destination to designate the Destination to be file type Excel and File name to be Family2
and save it with the ".ahk" extension.
Note:
- This script requires AutoHotkey version 2.0 or later.
- Requires the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
- Requires the function fGetFocusID which can be found in this library
- Requires a TMG Configuration name family and a Filter Group family of person.FLP which can be found in this libaray
- If the program displays a Fill in the blank window with no value supplied, try select cancel and cancel, then try the hotkey again. Know bug!
*/

#SingleInstance force  ; Ensures only one instance of the script can run at a time.

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#Include <Acc>  ; Includes the Acc library for accessibility functions.
#Include <fGetFocusID>  ; Includes the fGetFocusID library for retrieving focus ID.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\spreadsheet.png"
#HotIf WinActive("ahk_class tmg99c000000")  ; Activates a condition for the following hotkey definition.
#f3:: ;CreateFamily Spreadsheet
{
    answer := fNotify(A_scriptname)
	; Retrieve the ID of the focused window.
	ID := GetFocusID()
    ; id := 19806
    ; Activate the target program window by its class.
	WinActivate 'ahk_class tmg99c000000'

    ; Wait for the target program window to become active within 5 seconds.
	if !Winwait('ahk_class tmg99c000000',,5)
		throw

    ; Retrieve the accessibility object for the target program window.
	oTMG := acc.ElementFromHandle('ahk_class tmg99c000000')

    ; Check if the accessibility object is valid.
	if !IsObject(oTMG)
	{
		MsgBox 'There was an error connecting to the TMG program', 'Error', 'IconX'
		ExitApp
	}

    ; Try to find and activate the "family" element within the target program.

	lookfor := '{Name: "family"}'

	SearchEl := oTMG.WaitElementExist({Name: "family"},10000)
     ckfound(lookfor,SearchEl )

    SearchEl.Highlight()
    SearchEl.DoDefaultAction()


    ; Find and activate the "Create Report" element within the target program.

	lookfor := '{Name: "Create Report""}'
	oReport := oTMG.WaitElementExist({Name: "Create Report"},10000)
	ckfound(lookfor,oReport )
	oReport.DoDefaultAction()



    sleep 4000
	SendInput ID
  ;  MsgBox 'Pasted' ID
    ; Iterate through the next two elements and send a 'Tab' keystroke to navigate.
	loop  2
	{
		Send  '{Tab}'
		sleep 10
	}

    ; Send an 'Enter' keystroke to confirm the action.
	send '{Enter}'
}
ckfound(lookfor,found)
{
    ckobj := IsObject(found) ; Check if the 'found' variable is an object.
    If ckobj = 0 ; If 'found' is not an object (i.e., the element was not found).
    {
    	MsgBox  lookfor 'element not found' ; Display a message indicating that the element was not found.
    	exit ; Exit the script.
    }
    return ; Return to the caller.
}

