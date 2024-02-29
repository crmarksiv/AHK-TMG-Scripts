/*
Script Name: GetFocusName
Author: Connie Marks
Version: 1.0.0
Date: .date
Description: GetFocusName is an AutoHotkey script designed to retrieve the full name of the focused person within the TMG (The Master Genealogist) application when a TMG window is active. Pressing the hotkey Alt + N initiates the process of obtaining the full name of the focused person. The full name is then copied to the clipboard for further use. This script enhances user efficiency in managing genealogical data by simplifying the retrieval of person names.

Usage:
 . Install AutoHotkey if not already installed (https://www.autohotkey.com/).
 . Download the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
 . Download Requires the function fGetFocusID which can be found in this library
 . Modify the #Include statements to specify the path of the files where the ahk scirpts are located.
 . Save the script with the ".ahk" extension.
 . Double-click the script file to run it
 . Run the script by double-clicking the file.
 . Activate a TMG window.
 . In TMG single click a Tag that contains the desired person as the Principal person
 . Press Win+f7 to retrieve the full name of the focused person.
Note:
- This script requires AutoHotkey version 2.0 or later.
- Requires the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
- Requires the function fGetFocusID which can be found in this library

*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#SingleInstance force  ; Ensures only one instance of the script can run at a time.

#Include   <Acc>  ; Includes the Acc library for accessibility functions.
#Include <fGetFocusName>  ; Includes the fGetFocusName library for retrieving the focus person's full name.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\name2.png"
#HotIf WinActive("ahk_class tmg99c000000")  ; Activates a condition for the following hotkey definition.
#F7:: ;Get Name from TMG Tag.
{
    answer := fNotify(A_scriptname)
    FullName := GetFocusName()  ; Retrieve the full name of the focused person within TMG.
    A_Clipboard := FullName  ; Copy the full name to the clipboard.
}
