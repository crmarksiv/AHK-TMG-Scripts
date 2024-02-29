/*
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: Deceased.ahk is an AutoHotkey script designed to facilitate the process of marking individuals as deceased within the TMG (The Master Genealogist) application. When a TMG window is active, pressing the hotkey Shift + F2 inserts the text ",deceased," into the input box.

Usage:
1. Ensure AutoHotkey v2.0 64-bit is installed.
2. Copy the script into a text editor and save it with the ".ahk" extension.
3. Run the script by double-clicking the file.
4. Activate a TMG window where data entry is required.
5. Press Shift + F2 to insert ",deceased," into the input box.

Note: This script requires AutoHotkey v2.0  and is specifically intended for use within the TMG application environment.
*/

#SingleInstance  ; Ensures only one instance of the script can run at a time.

#Requires AutoHotkey v2.0   ; Specifies the required version of AutoHotkey.

#include <fNotify>
TraySetIcon A_ScriptDir "\icons\coffin.png"

#HotIf WinActive("ahk_class tmg99c000000")  ; Activates a condition for the following hotkey definition.
#f4:: ;Insert ,deceased,
{
answer := fNotify(A_scriptname)
SendText ",deceased," ;Insert ,deceased,
}
