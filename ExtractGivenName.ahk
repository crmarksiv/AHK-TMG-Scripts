/*
Script Name: ExtractGiven Name
Description:
"Extracts the given name from the clipboard content. The clipboard may contain a string in the format 'given, (middle) last (suffix)', with at least the given and last names present. The script then sends the given (and middle, if provided) name to the active window."

Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024

Usage:
 . Install AutoHotkey if not already installed (https://www.autohotkey.com/).

 . Save the script with the ".ahk" extension.
. Double-click the script file to run it
. Ccopy into your clipboard the full name
. Press the Hot key and the Given name will be sent to the active window.

- It also requies the fNotify Function which can be found in the Libary

#include <fNotify>

answer := fNotify(A_scriptname)

TraySetIcon A_ScriptDir "\res\icons\                      "

"C:\Users\Connie Mini PC\OneDrive\Documents\My AHK Scripts\TMG Scripts\res\icons"
*/
#Requires Autohotkey v2.0+
#SingleInstance force
#include <fNotify>

TraySetIcon  A_ScriptDir "\icons\name3.png"

; Define the hotkey (Win + F by default)
+F1:: ;Get Given Name
{
; Retrieve text from the clipboard aaa bbb ccc ddd aaa bbb ccc ddd
answer := fNotify(A_scriptname)
match := []
; Regular expression pattern to extract first, middle, last names, and suffix
regexPattern := "(\b\w+\b)\s+(\b\w+\b)(?:\s+(\b\w+\b))?(?:\s+(\b\w+\b))?\b"
; Extract first, middle (if present), last names, and suffix using RegExMatch
if RegExMatch(A_Clipboard, regexPattern, &match)
{
    firstName := match[1]
    ; Check if there's a third part (middle name)
    if (match[3] != "")
    {
        middleName := match[2]
        ; Check if there's a fourth part (suffix)
        if (match[4] != "")
        {
             SirName := match[3]
            suffix := match[4]
        }
        else
        {
             SirName := match[3]
            suffix := ""  ; No suffix
        }
    }
    else if (match[4] != "")  ; If only two parts, treat the second part as the last name and the third as the suffix
    {
        middleName := ""  ; Ignore middle name
         SirName := match[2]
        suffix := match[3]
    }
    else  ; If only two parts, treat the second part as the last name
    {
        middleName := ""  ; Ignore middle name
         SirName := match[2]
        suffix := ""  ; No suffix
    }
   ; MsgBox  'First Name:' firstName '`nMiddle Name:' middleName '`nLast Name:'  SirName '`nSuffix:' suffix
	name := firstname ' '  middleName
	;
    MsgBox   'name is ' name
    send name
    }
    else
    {
        MsgBox  'No valid name found in the clipboard.'
    }
}
