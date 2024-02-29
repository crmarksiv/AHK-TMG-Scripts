/*
Script Name: fNotify.ahk
Author: Connie Marks
Version: 1.0.0
Date: 19 Feb 2024
Description: fNotify.ahk is an AutoHotkey function designed to provide notification functionality for scripts. It allows scripts to display a message box when activated, optionally triggered by a hotkey. The function reads configuration settings from the TmgToolsNotify.ini file to determine whether to display notifications and whether to show help instructions. After displaying a message box, it can optionally open a PDF help file associated with the script. Users can choose whether to display the help message again in future runs of the script.

Usage: Call the fNotify function passing the script name as a parameter.

Example:
fNotify("MyScriptName")

Message have been added to assist in debuging this script, set Debug to Y to enable;


*/

fNotify(scriptname)
{
   ;MsgBox 'where am i'

    Debug := 'n'  ; Debug mode (change to 'Y' to enable debug messages)

    If Debug = 'Y'
        MsgBox 'scriptname is ' scriptname

    If Debug = 'Y'
      MsgBox 'i need this stmt'
    Notify := 'yes'
    Value := IniRead('TmgToolsNotify.ini', 'Notify', ScriptName, 'yes')

    If Debug = 'Y'
        MsgBox 'value is >' value '<' A_LineNumber

    if value = 'No'
    {
        Notify := 'No'
        Return
    }

    If Debug = 'Y'
        MsgBox 'Notify set to <' Notify '<' A_LineNumber

    if Notify = 'yes'
    {
        seehotkey := ''
        if A_ThisHotkey != ''
        {
            seehotkey := 'With a Hotkey of >' A_ThisHotkey '<'
        }

        ;Answer := MsgBox('You have Activated ' ScriptName ' ' seehotkey '`n `nIf you wish to see and how to use the Script Press Yes  Else Press No`n`n Press Cancel to terminate the script ',,"Y/N/C T20")
                Answer := MsgBox('You have Activated ' ScriptName '`n `nIf you wish to see and how to use the Script Press Yes  Else Press No`n`n Press Cancel to terminate the script ',,"Y/N/C T20")

        If Debug = 'Y'
            MsgBox 'the answer was3 ' Answer '<' A_LineNumber

        if Answer = 'Cancel'
        {
            MsgBox 'This script will now terminate, you must run again in order to use the hotkey to execute this script'
            ExitApp
        }

        if Answer = 'no'
        {
            If Debug = 'Y'
                MsgBox 'in the' A_ThisFunc 'the answer is' answer '<' A_LineNumber
            return
        }

        if Answer = 'yes' || 'Timeout'
        {

          ; MsgBox 'in the' A_ThisFunc 'the answer is' answer '<' A_LineNumber
           hk := LongHKName(A_ThisHotkey)
           ;hk := 'i am testing this'
            Msgbox 'The HotKey for '  ScriptName ' is >'   hk   '<'
           x := HowToUse(ScriptName)
            Answer2 := MsgBox("Would you like to avoid seeing this prompt about viewing help the next time you run this script? `n`nPress 'Yes' to stop seeing it, or press 'No' to continue seeing it." ,,"Y/N T20")
             If answer2 = 'yes'
            {
                Iniwrite 'No', 'TmgToolsNotify.ini', 'Notify', ScriptName

                if value != 'yes'
                {
                    Iniwrite ScriptName, 'TmgToolsNotify.ini', "info", "Script"
                    IniWrite A_WorkingDir, 'TmgToolsNotify.ini', "info", "path"
                }

                MsgBox('Your data was saved to file TmgToolsNotify.ini in the directory ' A_WorkingDir)
            }

            return answer
        }
    }
}
;***********************************************************************************
HowToUse(scriptname)
{

     Switch scriptname,0 ; look at the Script Name, case inssensitive
       {

        Case 'ClipMinusOne.ahk'  :
            Msgbox 'When you have a number in the clipboard and you are working in an input box within TMG, pressing the  hotkey will decrease the value in the clipboard by one and then send this updated number to the input box. Importantly, this action does not replace the existing content in the input box.'
        Case 'ClipPlusOne.ahk'  :
            Msgbox 'When you have a number in the clipboard and you are working in an input box within TMG, pressing the  hotkey will increment the value in the clipboard by one and then send this updated number to the input box. Importantly, this action does not replace the existing content in the input box.'

        Case 'CreateFamilySpreadsheet.ahk'  :
            Msgbox 'Streamlines the procedure of generating a familial spreadsheet within TMG. By clicking once on a Tag containing the desired individual as the Principal person in TMG, Pressing the hotkey will create an excel family spreadsheet . The application anticipates that the TMG Report definition will specify the Report Destination as an Excel file labeled "Family2". Furthermore, it mandates the presence of a TMG Configuration labeled "family" and a Filter Group titled "family of person". A duplicate of this FLP is accessible in this library. Should the application present a "Fill in the blank window" devoid of any supplied values, attempting to select cancel and retrying the hotkey is advisable, as this behavior is recognized as a bug'
        Case 'deceased.ahk'  :
            Msgbox 'When a TMG window is active, pressing the hotkey inserts the text   ,deceased,   at the mouse location'
        Case 'ExtractGivenName.ahk'  :
            Msgbox "Extracts the given name from the clipboard content. The clipboard may contain a string in the format 'given, (middle) last (suffix)', with at least the given and last names present. The script then sends the given (and middle, if provided) name to the active window."
        Case 'ExtractSirName.ahk'  :
            Msgbox "Extracts the Last name from the clipboard content. The clipboard may contain a string in the format 'given, (middle) last (suffix)', with at least the given and last names present. The script then sends the last name to the active window."
        Case 'FamlyPickID.ahk'  :
            Msgbox 'This script facilitates the retrieval of TMG ID numbers from an Excel spreadsheet titled "family2.xls". When the "family2.xls" window is in focus, simply pressing the  hotkey on any row within the spreadsheet will swiftly copy the corresponding value from column A (Person ID) to the clipboard.'
        Case 'fNotify.ahk'  :
            Msgbox 'The HotKey for '  ScriptName ' is > '   A_ThisHotkey   '<'
        Case 'GetFocusId.AHK'  :
            Msgbox 'Retrieves an ID from TMG. Simply select a tag that contains the ID of the person of interest (such as the Birth Tag) and press the  Hotkey. Subsequently, the Principal ID of that tag will be automatically copied to the clipboard for your convenience.'
        Case 'GetFocusName.ahk'  :
            Msgbox 'Retrieves the full name of a person from TMG. To initiate, select a tag where the person of interest is designated as the Principal Person (e.g., Birth Tag), then press the  Hotkey. Subsequently, the Principal Name of that tag will be swiftly copied to the clipboard for your convenience.'
        Case 'RemovePeopleFromFocusGroup.ahk'  :
            Msgbox 'Removes selected individuals from the active TMG Focus Group and saves the updated configuration. Select the person(s) within the Focus Group, then press the  Hotkey. This  removes the selected individual(s) and automatically saves the revised Focus Group.'

        Case 'Replace.ahk'  :
            Msgbox 'Replaces data with the contents of the clipboard. When the hotkey Alt+R is pressed, the script selects all text (Ctrl+A) in the active window and then pastes (Ctrl+V) the content of the clipboard into the active Window, effectively replacing the selected text with the clipboard contents. '

        Case 'SearchFor1950Census.ahk'  :
            Msgbox 'Search for the 1950 Census for the focus person on Ancestry.com. Upon viewing a person on Ancestry.com, pressing the hotkey executes the following steps:`n`n1. Presses the "Search" button specific to the selected Person (excluding the Tree Search or the Search button in the menu bar.`n2. Upon presentation of the "All Results"screen, the script automatically selects the "Census & Voter list"option.`n3. When the "All Census & Voter list" results screen appears, the script proceeds to select the 1950s census for further exploration.'
        Case 'SearchForSourceCitation.ahk'  :
            Msgbox 'Search for a source citation within TMG. By pressing the hotkey, a sequence of keystrokes {F4}{F2}{Tab 6}{Enter} is sent to TMG, triggering the search process.'
        Case 'SiteSearchJohnCardinalGenealogyPrograms.ahk'  :
            Msgbox 'The script offers checkboxes for selecting desired websites (e.g., Second Site, GedSite, TMG 2 GEDCOM, etc.) and includes an input field for entering search terms. Upon clicking the Search button, the script dynamically generates a Google search URL customized to the chosen websites and search term. This URL is then used to open the default web browser, presenting users with targeted search results.'

        Case 'T2A.AHK'  :
            MsgBox 'See T2A Instructions.docx'
        Case 'test.ahk'  :
            Msgbox ' this is a test'
        Default:
            Msgbox ' I did not find a case for ' Scriptname
        }
}
;****************************************************************************************************************
LongHKName(ThisHotkey)
{
  Pre := SubStr(ThisHotkey,1,1)
  pre2 := StrSplit(thisHotkey,pre)
  Len := Pre2.Length

  ;~ MsgBox 'len is' len
  ;~ MsgBox 'pre2 ' pre2[2]

  if len = 0
    Return ThisHotkey
    else
  {

     ;~ MsgBox 'i am goin to switch on ' pre
	  switch pre,0
	    {
		case '#':
	       	  return  "Win +"  pre2[2]
		case '^' :
			return  "Ctrl +" pre2[2]
		case '!' :
			return  "Alt+" pre2[2]
		case '+' :
			return  "Shift +" pre2[2]
		Default :
		      return ThisHotkey
	}
  }
}
