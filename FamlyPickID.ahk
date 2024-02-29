/*
Script Name: Family pick ID.ahk
Author: Connie Marks
Version: 1.0.0
Date: 27 Feb 2024
Description: Family pick ID.ahk is an AutoHotkey script designed to facilitate the process of retrieving family IDs from an Excel spreadsheet named "family2.xls". When the "family2.xls" window is active, pressing the hotkey Window Key+F4 on any row in the spreadsheet will copy the value from column A (family ID) of that row to the clipboard. This functionality is particularly useful for quickly accessing family IDs for further processing.

Usage:
1. Ensure AutoHotkey v2.0+ is installed.
2.Obtain the XL.ahk library. (Download link: https://www.the-automator.com/excel-and-autohotkey/) and
   modify the #Include statement to specify the path of the files where the library is located.
3. Copy the script into a text editor, modify the #Include statement to specify the path of the files where the library is located and save it with the ".ahk" extension.
4. Run the script by double-clicking the file.
5. Activate the "family2.xls" window.
6. Press Window Key+F4 on a  row and the ID of that row will be copied to the clipboard.

Note: This script requires AutoHotkey v2.0+ and the XL.ahk library. It is specifically intended for use with Excel spreadsheets containing family data and contains the name family2.xls

- It also requies the fNotify Function which can be found in the Libary

*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.
#SingleInstance  ; Ensures only one instance of the script can run at a time.
#include "C:\Users\Connie Mini PC\Downloads\XL-Function-Lib\V2\XL.ahk"  ; Includes the XL.ahk library for Excel automation.
#include <fNotify>
TraySetIcon A_ScriptDir "\icons\familypicid.png"
#HotIf WinActive("family2.xls")  ; Activates a condition for the following hotkey definition.
#F5:: ;Get ID Col A
{
    answer := fNotify(A_scriptname)
    PXL := XL_Start_Get()  ; Connects to the active Excel application or starts a new workbook if no Excel application is active.
    row := XL_Get_First_Selected_Row(PXL)  ; Retrieves the index of the first selected row.
    XL_Copy_to_Clipboard(PXL, RG:="A" row " :A" row)  ; Copies the value from column A (family ID) of the selected row to the clipboard.
}

