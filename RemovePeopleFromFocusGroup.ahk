/*
Script Name: RemovePeopleFromFocusGroup.ahk
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: RemovePeopleFromFocusGroup.ahk is an AutoHotkey script designed to remove selected individuals from the active TMG (The Master Genealogist) Focus Group and save the changes. Pressing the Scroll Lock key activates the script. This script requires the ACC.ahk library, which can be found at https://github.com/Descolada/Acc-v2. TMG must be active, and the Focus Group must have been saved at least once before running the program so that the Save function knows where to store the updated list.

Usage:
	. Install AutoHotkey if not already installed (https://www.autohotkey.com/).
	. Download the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
	. Modify the #Include statementsto specify the path of the file where the ahk scirptis  located.
	. Save the script with the ".ahk" extension.
	. Double-click the script file to run it
	. In TMG select the names in the Focus Group you wish to remove
	. Ensure TMG is active and the Focus Group has been saved at least once.
	. In TMG select the names in the Focus Group you wish to remove
	. Press the Scroll Lock key to remove selected individuals from the TMG Focus Group and save the changes.
	. Be patient, it may take a while - when done you will see a message Removed selected individuals and saved the Focus Group
	. If your tmg is slow, adjust the Sleep vaues

Note: This script requires AutoHotkey v2.0+ and is specifically intended for use with TMG.
      Requires the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\

- It also requies the fNotify Function which can be found in the Libary


*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#SingleInstance  ; Ensures only one instance of the script can run at a time.

#include <Acc>  ; Includes the Acc library for accessibility functions.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\remove.jpg"
#HotIf WinActive("ahk_class tmg99c000000")
#F8:: ;Remove People from Focus Group
ScrollLock:: ;Remove People from Focus Group
{
	answer := fNotify(A_scriptname)
	; Wait for a window with the specified class name to appear, with a timeout of 5 seconds.
	if !Winwait('ahk_class tmg99c000000',,5)
		throw

	; Access the application's accessibility interface.
	TMGEl := acc.ElementFromHandle('ahk_class tmg99c000000')

	; Display a message to indicate the action.
	MsgBox('Removing the selected individuals from the active TMG Focus Group and saving the Focus Group',,"T1")

	; Remove the selected item from the focus group.
	lookfor := "{Name:''Remove Selected''}"
	RemoveSelectedEl:= TMGEl.WaitElementExist({Name:'Remove Selected'},2000)
	ckfound(lookfor,RemoveSelectedEl)
	RemoveSelectedEl.Highlight()
	sleep 500
	RemoveSelectedEl.DoDefaultAction()
	RemoveSelectedEl.DoDefaultAction()

	; Find and click the Save button.
	lookfor := "{Name:''Save...''}"
	SaveEl := TMGEl.WaitElementExist({Name:'Save...'},2000)
	ckfound(lookfor,SaveEl )
	SaveEl.Highlight()
	SaveEl.DoDefaultAction()

	; Find and click the Overwrite button.
	lookfor := "Overwrite}"
	OverwriteEl:= TMGEl.WaitElementExist({Name:'Overwrite'},2000)
	ckfound(lookfor,SaveEl )
	OverwriteEl.Highlight()
	OverwriteEl.DoDefaultAction()

	; Display a message to indicate the action.
	sleep 500
	MsgBox('Removed selected individuals and saved the Focus Group',,"T2")
}
return

; Function to check if an element was found.
ckfound(lookfor,found)
{
    ckobj := IsObject(found)
    If ckobj = 0
    {
    	MsgBox  lookfor 'element not found'
    	exit
    }
    return
}

