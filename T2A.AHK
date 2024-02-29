/*
Script Name: T2A
Author: Connie Marks
Version: 8.0.0
Date: 19 Feb 2024
Description: T2A is an AutoHotkey script designed to facilitate the process of selecting a person in TMG (The Master Genealogist) and navigating to that person in your Ancestry.com tree. This script requires certain prerequisites:
- Access to Ancestry.com.
- Use of the Google Chrome browser (though this can potentially be modified).
- The TMG project containing the desired person.
- A corresponding tree on Ancestry.com that includes the focus person.
- Ability to write a file to your system named "t2a.ini," which contains your settings, including hotkeys and the URL of your Ancestry.com tree.
- Installation of AutoHotkey v2.0+ and the ACC and UIA libraries from Descolata
- It also requies the fNotify Function which can be found in the Libary


The script reads an ini file created by T2ASetup.ahk to retrieve the URL and user-defined hotkeys. When activated with the designated hotkey (configured during setup), the script will go to the Root Person in Ancestry.com in your browser window. It will then select the Tree Search box, open it, and enter the focus person's name from TMG into the input field. The user will be presented with one or more names found in the tree, from which they can select the desired person.

Revisions:
- Version 2.001 (13 Oct 2022)
- Rev 2.002 (21 Dec 2022) - Start with a double click of the name, and the paste in Ancestry will be done automatically.
- Rev 3.000 (24 Jan 2023) - Use UIA to access the Ancestry tree to avoid tabbing to the tree.
- Rev 4.000 (31 Jan 2023) - Allow the user to define the hotkey for the script.
- Rev 5.000 (11 Mar 2023) - Switch from UIA to ACC, better method to get Focus Name in TMG, and better method to access Tree Search in Ancestry.
- Rev 6.000 (14 Mar 2023) - Moved the setup of the ini file to a separate script.
- Rev 7 (No date specified) - Add Hotkeyname to show hotkeys with words instead of symbols.
- Version 8.0.0(19Feb 2025) - Use GetFocusName function that does not use ACC Path, add select full name with UIA.

Usage:
	. Install AutoHotkey if not already installed (https://www.autohotkey.com/).
	. Download the ACC.ahk library which can be found at https://github.com/Descolada/Acc-v2\
	. Download the UIA-V2 library which can be found at https://github.com/Descolada/UIA-v2
	. Download the function fGetFocusID which can be found in this library
	. Modify the #Include statements to specify the paths of the files where the ahk scirpt are located.
	. Save the script with the ".ahk" extension.
	. Double-click the script file to run it
	. In TMG single click on a Tag that contains the person you wish to find as the Principal (like the Birth or Death Tag)
	. Press the Hotkey (Mbutton )
	. Be patient, it may take a while -
	. If the Tree Search does not contain the correct name, try again with a different Tag in TMG or Verify you are searching the correct Ancestry Tree

	. If your tmg is slow, adjust the Sleep vaues
*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#SingleInstance  ; Ensures only one instance of the script can run at a time.

#include <UIA>  ; Includes the UIA library for UI automation.
#Include <Acc>  ; Includes the ACC library for accessibility functions.
#Include <fGetFocusName>  ; Includes the fGetFocusName library for retrieving focus name.


#include <fNotify>

answer := fNotify(A_scriptname)


SetTitleMatchMode 2  ; Sets the title matching mode to 2 (match any part of the title).
TraySetIcon  A_ScriptDir "\icons\t2a.png"
hotkey1 := ''  ; Initializes the hotkey variable.

Setupdone := FileExist("t2a.ini")  ; Checks if the setup has been done by looking for the existence of the ini file.

If (Setupdone = "A")  ; If setup has been done, read the configuration from the ini file.
{
	MsgBox "Reading the setup"
	hotkey1 := IniRead("t2a.ini", "main", "hotkey")
	hotkeyname := IniRead("t2a.ini", "main", "hotkeyname")
	url := IniRead("t2a.ini", "main", "url")
	RootPerson := IniRead("t2a.ini", "main", "Rootperson")

	GOTO T2AREAD
}
else
{
	MsgBox "You must run T2ASetup.ahk before running this script."
	ExitApp
}

/*
Main function to handle hotkey activation and execution.
*/
T2AREAD:
{
	hk := '"' . hotkey1 . '"'  ; Prepares the hotkey string.
	HotIfWinActive "ahk_class tmg99c000000"  ; Activates a condition for the following hotkey definition.
	Hotkey hotkey1, MyFunc  ; Defines the hotkey.

	MyFunc(ThisHotkey)
	{
		static Title1 := ''
		static ancestry := ''

		name := ""  ; Initializes the name variable.
		FullName := GetFocusName()  ; Retrieves the full name of the focus person from TMG.
		SelectTreeSearch(Fullname, url, RootPerson)  ; Calls the function to navigate to the focus person in Ancestry.com.
	}
}

/*
Function to select the Tree Search box in Ancestry.com and enter the focus person's name.
*/
SelectTreeSearch(Fullname, url, RootPerson)
{
	Run url  ; Opens the Ancestry.com URL.
	WinWait  url, , 5  ; Waits for the Ancestry.com window to appear.

	chromeEl := UIA.ElementFromHandle(RootPerson)  ; Accesses the Ancestry tree using UIA.
	FindInTreeEl := chromeEL.FindElement({Name: "Find in tree"})  ; Finds the "Find in tree" element.
	FindInTreeEl.Highlight()  ; Highlights the element.
	FindInTreeEl.DoDefaultAction()  ; Performs the default action (assumed to be a click).
	Sleep 2000  ; Introduces a delay for better reliability.

	TypeNameEl := chromeEL.FindElement({Name: "Type in a name or select a filter to search"})  ; Finds the input field for typing the name.
	TypeNameEl.value := fullname  ; Enters the full name of the focus person.
	Return  ; Exits the function.
}
