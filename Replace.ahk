
/*
Script Name: Replace.ahk
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: Replace.ahk is an AutoHotkey script designed to replace data with the contents of the clipboard. When the hotkey Alt + R is pressed, the script selects all text (Ctrl + A) in the active window and then pastes (Ctrl + V) the content of the clipboard, effectively replacing the selected text with the clipboard contents. This script enhances user productivity by providing a quick method for replacing data within various applications.

Usage:
1. Ensure AutoHotkey v2.0+ is installed.
2. Copy the script into a text editor and save it with the ".ahk" extension.
3. Run the script by double-clicking the file.
4. Activate the window where you want to replace data.
5. Press Alt + R to replace the selected text with the content of the clipboard.

Note: This script requires AutoHotkey v2.0+.

- It also requies the fNotify Function which can be found in the Libary

#include <fNotify>

answer := fNotify(A_scriptname)

TraySetIcon A_ScriptDir "\icons\                      "

"C:\Users\Connie Mini PC\OneDrive\Documents\My AHK Scripts\TMG Scripts\res\icons"

*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#SingleInstance  ; Ensures only one instance of the script can run at a time.

#include <fNotify>
TraySetIcon A_ScriptDir "\icons\Replace.png"
!R::  ;Replace data with the contents of the clipboard.
{
    answer := fNotify(A_scriptname)
    Send "^a"  ; Sends Ctrl + A to select all text in the active window.
    Sleep 150  ; Introduces a brief delay for better reliability.
    Send "^v"  ; Sends Ctrl + V to paste the content of the clipboard.
}
