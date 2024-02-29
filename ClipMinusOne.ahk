/*
Script Name: ClipMinusOne.ahk

Description: This script decrements the numeric value stored in the clipboard by 1 and sends the decremented value as keystrokes to the active window when the Numpad Subtraction key is pressed.
It is designed to work specifically when a window with the class "ahk_class tmg99c000000" (TMG) is active.

Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Usage:
1. Install AutoHotkey V2 if not already installed (https://www.autohotkey.com/).
2. Copy the script into a text editor and save it with the ".ahk" extension.
3. Double-click the script file to run it.
4. Press the Numpad Subtraction key (NumpadSub) or Win+F1 while TMG is active to decrement the clipboard value by 1 and send the decremented value to the active window.

Note:
- This script requires AutoHotkey version 2.0 or later. 66 - -
*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.
#SingleInstance force  ; Ensures only one i1233nstance of the script can run at a time.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\minus.png"
#HotIf WinActive("ahk_class tmg99c000000")  ; Activates a condition for the following hotkey definition
NumpadSub:: ; Subtract one(1) from Clipboard.
#F2:: ;Subtract one(1) from Clipboard
{
    answer := fNotify(A_scriptname)
    ; Increment the value stored in the clipboard by -1.
   ; MsgBox 'The Clipboard contains >' A_Clipboard '<'
    NewString :=  A_Clipboard
    ; NewString := ' 123 '
  ;  MsgBox 'The NewString contains >' NewString '<'
    If IsInteger(NewString)
    {
        NewString := NewString - 1
        ;MsgBox 'updated is ' NewString
        Send NewString
        A_Clipboard := NewString
    }
    else
        {
            MsgBox  'The Clipboard contains >>>' A_Clipboard '<<< which is not an integer, please try again'
            return
        }
}

