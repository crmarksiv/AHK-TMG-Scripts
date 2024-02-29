/*
Script Name: Get FocusId .AHK
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: Get FocusId .AHK is an AutoHotkey script designed to retrieve the focus ID from the TMG (The Master Genealogist) application when a TMG window is active. Pressing the hotkey Alt + I initiates the process of obtaining the focus ID from the TMG Tag. The focus ID is then copied to the clipboard for further use. This script streamlines the retrieval of IDs within the TMG application environment, enhancing user efficiency in managing genealogical data.

Usage:
	Ensure AutoHotkey v2.0+ is installed.
	Copy the script into a text editor
	Download ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
	Get the function fGetFocusID which can be found in this library
	Modify the #Include statements and modify the #Include statement to specify the path to the ahk scripts
	Save  this script with the ".ahk" extension.
	Run the script by double-clicking the file.
	Activate a TMG window.
	Click once on any tag where the individual you want to find the ID of is designated as the Principal Person of the tag.
	Press Win + F6 to retrieve the ID from the TMG Tag.

Note: This script requires AutoHotkey v2.0+ and is specifically intended for use within the TMG application environment.
Requires the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
- Requires the function fGetFocusID which can be found in this library
*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.
#SingleInstance force  ; Ensures only one instance of the script can run at a time.
#Include <Acc>  ; Includes the Acc library for accessibility functions.
#Include <fGetFocusID>  ; Includes the fGetFocusID library for retrieving the focus ID.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\id.png"
#HotIf WinActive("ahk_class tmg99c000000")  ; Activates a condition for the following hotkey definition.
#f6::  ;Get ID from the TMG Tag.
{
    answer := fNotify(A_scriptname)
	; Get the Focus ID
    id := GetFocusID()  ; Retrieve the focus ID from the TMG Tag.
    A_Clipboard := id  ; Copy the focus ID to the clipboard.
    ;MsgBox "Clipboard contains: " A_Clipboard  ; Display a message indicating the content copied to the clipboard.
}
