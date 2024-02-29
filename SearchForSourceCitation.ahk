/*
Script Name: #SingleInstance
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: This AutoHotkey script is designed to search for a source citation in TMG (The Master Genealogist) when a TMG window with the specified class name is active. Pressing the hotkey Alt + S initiates the search process by sending a sequence of keystrokes: {F4}{F2}{Tab 6}{Enter}.
Usage:
1. Ensure AutoHotkey is installed.
2. Copy the script into a text editor and save it with the ".ahk" extension.
3. Run the script by double-clicking the file.
4. Activate a TMG window with the specified class name.
5. Press Win + F9 or Alt + S to search for a source citation in TMG.
- It also requies the fNotify Function which can be found in the Libary

Note: This script requires AutoHotkey and is specifically intended for use with TMG.
*/
#include <fNotify>
#SingleInstance  ; Ensures only one instance of the script can run at a time.
#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#Include <Acc>  ; Includes the Acc library for accessibility functions.

#include <fNotify>
TraySetIcon A_ScriptDir "\icons\search.png"
#HotIf WinActive("ahk_class tmg99c000000")
#F9:: ;Search for a citation
!S::  ;Search for a citation
{
 	answer := fNotify(A_scriptname)
	WinActivate 'ahk_class tmg99c000000'
	oTMG := acc.ElementFromHandle('ahk_class tmg99c000000') ; Connected to TMG
	if !tagEntry := oTMG.FindElement({Name:'Tag Entry'})
	    {
			msgbox 'You must search for a Citation in a Tag Entry Window'
		}
    else
	   ControlSend "{f4}{f2}{tab 6}{enter}",,'ahk_class tmg99c000000'
}

