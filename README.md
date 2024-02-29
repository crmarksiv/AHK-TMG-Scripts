 
ClipPlusOne  	"NumpadAdd(+)
Win+F1"	Adds one (1) from the value in the clipboard and sends the value to the active window. This only works in a TMG.
		Example: You are in a TMG TAG box that excepts a number and the clipboard contains the ID number of child 1234 if you press the Hotkey the number 1235 will be added to the box. Note current content of the box is not deleted 
		
ClipMinusOne  	"NumpadSub(-)
Win+F2"	Subtracts one (1) from the value in the clipboard and sends the value to the active window. This only works in a TMG.
		
CreateFamilySpreadsheet 	Win+F3	Streamlines the procedure of generating a familial spreadsheet within TMG. By clicking once on a Tag containing the desired individual as the Principal person in TMG, Pressing the hotkey will create an excel family spreadsheet . The application anticipates that the TMG Report definition will specify the Report Destination as an Excel file labeled "Family2". Furthermore, it mandates the presence of a TMG Configuration labeled "family" and a Filter Group titled "family of person". A duplicate of this FLP is accessible in this library. Should the application present a "Fill in the blank window" devoid of any supplied values, attempting to select cancel and retrying the hotkey is advisable, as this behavior is recognized as a bug. 
		 
Deceased	Win+F4	When a TMG window is active, pressing the hotkey inserts the text ",deceased,"  at the mouse location. 
		
 FamlyPickID	Win+F5	This script facilitates the retrieval of TMG ID numbers from an Excel spreadsheet titled "family2.xls". When the "family2.xls" window is in focus, simply pressing the designated hotkey on any row within the spreadsheet will swiftly copy the corresponding value from column A (Person ID) to the clipboard.
		
GetFocusId	Win+F6	Retrieves an ID from TMG. Simply select a tag that contains the ID of the person of interest (such as the Birth Tag) and press the designated Hotkey. Subsequently, the Principal ID of that tag will be automatically copied to the clipboard for your convenience.
		
GetFocusName  	Win+F7	Retrieves the Full Name of a person  from TMG.Select a Tag where the name of the person of interest is the Principal Person (like the Birth Tag) and press the Hotkey. The Principal Name of that tag will be copied to the clipboard.     
		
RemovePeopleFromFocusGroup	"Win+F8
Scroll Lock"	Removes selected individuals from the active TMG Focus Group and saves the updated configuration. Select the person(s) within the Focus Group, then press the designated Hotkey. This  removes the selected individual(s) and automatically saves the revised Focus Group. 
		
SearchForSourceCitation	Win+F9	Search for a source citation within TMG. By pressing the hotkey, a sequence of keystrokes {F4}{F2}{Tab 6}{Enter} is sent to TMG, triggering the search process.
		
Replace	Alt+R	Replaces data with the contents of the clipboard. When the hotkey Alt + R is pressed, the script selects all text (Ctrl + A) in the active window and then pastes (Ctrl + V) the content of the clipboard, effectively replacing the selected text with the clipboard contents. 
		
SearchFor1950Census	Win+F10	Search for the 1950 Census for the focus person on Ancestry.com. Upon viewing a person on Ancestry.com, pressing the designated hotkey executes the following steps:
		
T2A	user defined	T2A is a  designed to facilitate the process of selecting a person in TMG (The Master Genealogist) and navigating to that person in your Ancestry.com tree. Note that T2ASetup must be run once before using T2A to define the Ancestry tree address(UR) and the hotkey you wish to use. 
		
T2ASetup 	none	Set up or modify user choices for the Ancestry.com tree, root person, and hotkeys to be used with the T2A script. This script must be run before executing T2A.
		
 Site Search John Cardinal Genealogy Programs	none	The script offers checkboxes for selecting desired websites (e.g., Second Site, GedSite, TMG 2 GEDCOM, etc.) and includes an input field for entering search terms. Upon clicking the Search button, the script dynamically generates a Google search URL customized to the chosen websites and search term. This URL is then used to open the default web browser, presenting users with targeted search results.
		
 fNotify	none	 This  function  notification functionality for scripts. It allows scripts to display a message box when activated, optionally triggered by a hotkey. The function reads configuration settings from the TmgToolsNotify.ini file to determine whether to display notifications and whether to show help instructions. After displaying a message box, it can optionally open a PDF help file associated with the script. Users can choose whether to display the help message again in future runs of the script.
		
		
 ExtractGivenName 	Shift+F1	"Extracts the given name from the clipboard content. The clipboard may contain a string in the format 'given, (middle) last (suffix)', with at least the given and last names present. The script then sends the given (and middle, if provided) name to the active window."
		
ExtractSirName	Shift+F2	"Extracts the Last name from the clipboard content. The clipboard may contain a string in the format 'given, (middle) last (suffix)', with at least the given and last names present. The script then sends the last name to the active window."
![image](https://github.com/crmarksiv/AHK-TMG-Scripts/assets/98748846/c3ae141b-891c-49ad-bf5f-990c712d879e)
