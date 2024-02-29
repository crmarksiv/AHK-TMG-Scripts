/*
Script Name: Site Search John Cardinal Genealogy Programs.ahk
Author: Connie Marks
Version: 1.0.0
Date: 19 Feb 2024
Description: Site Search John Cardinal Genealogy Programs.ahk is an AutoHotkey script designed to search specific genealogy websites using Google. The script provides checkboxes to select the websites to search (e.g., Second Site, GedSite, TMG 2 GEDCOM, etc.) and allows users to enter a search term. Upon clicking the Search button, the script constructs a Google search URL tailored to the selected websites and search term, opening the default web browser with the search results.

Instructions:
1. Run the script.
2. Check the desired websites to search.
3. Enter a search term.
4. Click the Search button.
5. The script constructs a Google search URL and opens the default web browser with the search results.
6. Click the Cancel button to hide the GUI.

Note: The script requires AutoHotkey v1.1.33+.

*/

#Requires Autohotkey v1.1.33+  ; Specifies the required version of AutoHotkey.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
GUI Creation:
- Adds checkboxes for selecting genealogy websites.
- Allows users to enter a search term.
- Provides buttons for searching and canceling the operation.
*/
gui, new
gui, font, S12  ; Change font size to 12
Gui, Add, GroupBox, x0 w460 h150, Search ; Add a group box
gui, Add, Checkbox, x20 y30 checked0 vSS, Second Site ; First checkbox
gui, Add, Checkbox, checked0 vGedSite, GedSite
gui, Add, Checkbox, checked0 vT2G, TMG 2 GEDCOM (T2G)
gui, Add, Checkbox, checked0 vORA, Online Repository Assistant (ORA)
gui, Add, Text, x10 y+20, Search for:
gui, Add, Edit ,x+10 yp-5 w360  vSearchTerm
gui, Add, Button, w75 gSearch Default, &Search
gui, Add, Button, w75 x+25 gCancel Cancel, &Cancel
gui, font, S10 cblue  ; Font size to 10 and color to blue
gui, Add, Checkbox, x300 yp+8  vquotes, Wrap Search in Double quotes  ; Add checkbox to wrap in double quotes
gui, Show
GuiControl,Focus,SearchTerm
return

/*
Search Function:
- Retrieves search term and checkbox values from the GUI.
- Constructs Google search URLs based on selected websites and search term.
- Opens the default web browser with the search results.
*/
Search:
Gui Submit  ; Needed to pull info from controls
if quotes  ; If selected, URL includes double quotes around search term
    SearchTerm:="%22" SearchTerm "%22"

If SS
    run "http://www.google.com/search?q=%SearchTerm%+site:https://www.secondsite8.com"

If GedSite
    run "http://www.google.com/search?q=%SearchTerm%+site:https://www.gedsite.com"

If T2G
    run "http://www.google.com/search?q=%SearchTerm%+site:https://www.tmgtogedcom.com"

If RM
    run "http://www.google.com/search?q=%SearchTerm%+site:http://wiki.rootsmagic.com/wiki/RootsMagic_8:RootsMagic_8"

If FTA
    run "http://www.google.com/search?q=%SearchTerm%+site:http://ftanalyzer.com/"

If ORA
    run "http://www.google.com/search?q=%SearchTerm%+site:www.ora-extension.com"

if ! InStr(SearchTerm,"AutoHotkey")  ; If AutoHotkey isn't in the search
    SearchTerm.= " AutoHotkey"  ; Append AutoHotkey

gui, hide  ; Hide the GUI after search
return

/*
Cancel Function:
- Hides the GUI when the Cancel button is clicked.
*/
Cancel:
gui, hide
return

Escape::ExitApp  ; Allows pressing the Escape key to exit the application.

