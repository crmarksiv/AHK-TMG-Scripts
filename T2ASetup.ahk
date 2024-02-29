/*
Script Name: T2ASetup.ahk
Author: Connie Marks
Version: 2.0.0
Date: 19 Feb 2024
Description: T2ASetup.ahk is an AutoHotkey script designed to set up or modify user choices for the Ancestry.com tree, root person, and hotkeys to be used with the T2A script. This script must be run before executing T2A.ahk.

Definitions:
- URL: The address of the Ancestry.com tree.
- Focus Person: The name of a person in TMG that the user wishes to view in Ancestry.
- Tree Search: A feature in Ancestry.com that allows users to search for a person in their tree.
- Root Person: Any name selected in the Ancestry tree, serving as the starting point for the Tree Search.
- Hotkeys: Two or more keys used in T2A to select a focus person in TMG and trigger the action to navigate to Ancestry.

Usage:
1. Run T2ASetup.ahk to set up or modify your choices.
2. Define the URL of your Ancestry.com tree, select a root person, and set hotkeys.
3. The information is stored in the "t2a.ini" file for later use by the T2A script.

Outline:
- If "t2a.ini" exists:
  - Read and report the existing configurations.
  - Prompt the user to change the URL or hotkeys.
  - If the user chooses to change:
    - Prompt to change the URL.
    - Prompt to change hotkeys.
- If "t2a.ini" does not exist:
  - Get the URL and save it to "t2a.ini".
  - Get hotkeys and save them to "t2a.ini".

Revisions:
- Release 1.0 (14 Mar 2023)
- Revision 1.0a: Add Hotkeyname to show modifications as names.
- Release 2.0.0 (19 Feb 2024) Cleanup
*/

#Requires Autohotkey v2.0+  ; Specifies the required version of AutoHotkey.

#SingleInstance force  ; Forces single instance of the script to run.

Setupdone := FileExist("t2a.ini")  ; Checks if the setup has been done by looking for the existence of the ini file.

If (Setupdone = "A") {
    hotkey1 := IniRead("t2a.ini", "main", "hotkey")
    hotkeyname := IniRead("t2a.ini", "main", "hotkeyname")
    url := IniRead("t2a.ini", "main", "url")
    rp := IniRead("t2a.ini", "main", "RootPerson")
    date := IniRead("t2a.ini", "info", "date")
    path := IniRead("t2a.ini", "info", "path")
    MsgBox "You have defined your choices for the T2A script on " date "`nFor the Root person: " rp "`nUsing Ancestry.com tree: " url "`nAnd your hotkeys are: " hotkeyname
    change := InputBox("Do you want to change the Tree and/or the hotkeys? Enter Y if yes", "Request to Change", , "Y")
    if (change.value = "Y") {
        url := Inputbox("Do you wish to change the ancestry tree (url)? Enter Y if yes", "Request to change URL", , "Y")
        If (url.value = "Y") {
            xx := GetUrl(url.value)
        }
        key := InputBox("Do you wish to change your hotkeys? Enter Y or press Ok if yes", "Request to change Hotkeys", , "Y")
        If (key.value = "y") {
            GuiName := "Step1"
            Guisize := "s20"
            alt :=
            Win := 0
            Ctrl := 0
            ctrlprefix := ""
            Altprefix := ""
            Winprefix := ""
            get := "new"
            get := Gethotkey(alt)
        }
    }
} Else {
    msgbox 'created the ini file'
    xx := GetUrl(setupdone)
    GuiName := "Step1"
    Guisize := "s20"
    alt :=
    Win := 0
    Ctrl := 0
    ctrlprefix := ""
    Altprefix := ""
    Winprefix := ""
    get := "new"
    get := Gethotkey(alt)
}

/*
Function to retrieve the URL of the Ancestry.com tree.
*/
GetUrl(*) {
    MsgBox "Please log on to Ancestrey.com and select a Tree (but don't select a person yet)"
    SetTitleMatchMode 2
    run "https://www.ancestry.com"
    sleep 2000
    WinActivate "Genealogy"
    Title1 := WinGetTitle("A")
    pos := InStr(title1, "Genealogy, Family")
    If (pos != 1) {
        MsgBox("You went to" Title "`nPlease log on to ancestry.com and try again")
        EXIT
    }
    select:
    obj := InputBox("Select any person in your tree `nSo that I can get the URL `nThenSelect OK")
    Sleep 500
    Title := WinGetTitle("A")
    If (title = title1) {
        Msgbox("You did not select a person.nPlease select any person in your tree", "Get Url", "T60")
        goto select
    }
    winactive title
    send "^l"
    sleep 1000
    send "^c"
    sleep 500
    URL := A_Clipboard
    Title3 := WinGetTitle("A")
    parts := StrSplit(Title3, "-")
    MsgBox("`nThe root person for the Treee Search will be " parts[1] "`nAnd the URL is `n " URL)
    IniWrite url, "t2a.ini", "main", "url"
    Iniwrite parts[1], "t2a.ini", "main", "Rootperson"
    Iniwrite A_ScriptName, "t2a.ini", "info", "Script"
    IniWrite A_WorkingDir, "t2a.ini", "info", "path"
    Iniwrite A_Now, "t2a.ini", "info", "date"
    msgbox("Your data was saved to file t2a.ini in the directory " A_WorkingDir)
}

/*
Function to set up hotkeys for the T2A script.
*/
gethotkey(xxx) {
    MsgBox("On the next screen, please define the Hotkey to use with this script.`n`nPick a single key and one to three Prefixes.`nThe Prefix keys are Alt, Ctrl, and Win (Windows logo key).`n`nIf you use the Win key prefix alone, you may not use the keys B, D, E, F, H, I, K, L, P, R, S, T, W, or X.`n`nIf you use the Ctrl key prefix alone, you can only use keys F, G, J, Q, W, or Z.`n`nIf you use the Alt key prefix alone, you may not use the keys A, B, E, F, H, R, or T")
    win := 0
    ctrl := 0
    Altname := ''
    WinName := ''
    Ctrlname := ''
    letter := ""
    OK := "OK"
    win := 0
    ctrl := 0
    letter := ""
    GuiName := "Step1"
    Guisize := "s20"
    GuiName := Gui(, GuiName)
    ; set the size of the text
    GuiName.SetFont(GuiSize)
    GuiName.Add("Text", "x0", "Input a Key")
    GuiName.Add("Edit", "vLetter x+10 yp-5 w25 Center Limit1")
    Guiname.Add("Text", " x10 y+30", "Select at Least one prefix")
    GuiName.Add("Checkbox", "vAlt  x+20 yp", "Alt")
    GuiName.Add("Checkbox", "vWin  x+10 yp", "Win")
    GuiName.Add("Checkbox", "vctrl x+10 yp", "Ctrl")
    GuiName.Add("Button", "x+10 y+30 Default ", "OK").OnEvent("Click", ButtonOK)
    GuiName.Show()

    ButtonOK(*) {
        global get
        get := "befor buttton"
        saved := Guiname.Submit()
        letter := StrUpper(saved.letter)
        alt := saved.alt
        Win := saved.win
        ctrl := saved.ctrl
        ctrlprefix := ""
        Altprefix := ""
        Winprefix := ""

        If (letter = "") {
            MsgBox "You did not enter a Key, please try again"
            GuiName.Show()
        }

        if ((alt = 0) and (win = 0) and (Ctrl = 0)) {
            MsgBox "You must pick at least one Prefix, Please try again"
            GuiName.Show()
        }

        hotkey := letter

        if (Alt = 1) {
            altprefix := "!"
            Altname := "Alt "
            if ((ctrl = 0) and (Win = 0)) {
                foundPos := RegExMatch(letter, "i)A|B|E|F|H|R|T")
                If (FoundPOs != 0) {
                    MsgBox("The Key combination of the Alt key and " Letter "  is a reserved Hotkey `nIf you use the alt prefix alone you can only use may not use keys the leter keys A, B, E, F, H, R, or T`nPlease pick a new hotkey")
                    GuiName.Show()
                }
            }
        }

        if (Ctrl = 1) {
            Ctrlprefix := "^"
            Ctrlname := "Ctrl"
            if ((alt = 0) and (Win = 0)) {
                foundPos := RegExMatch(letter, "i)A|B|C|D|E|H|I|K|M|O|P|R|S|T|U|V|X|Y")
                If (FoundPOs != 0) {
                    MsgBox("The Key combination of the Ctrl key and " Letter "  is a reserved Hotkey `nIf you use the ctrl prefix alone you can only use keys F, G, J, Q, W,or Z`nPlease pick a new hotkey")
                    GuiName.Show()
                }
            }
        }

        if (Win = 1) {
            Winprefix := "#"
            Winname := "Win"
            if ((alt = 0) and (ctrl = 0)) {
                foundPos := RegExMatch(letter, "i)B|D|E|F|H|I|K|L|P|R|S|W|X")
                If (FoundPOs != 0) {
                    Msgbox("The Keys combination of the Win key and " letter " is a reserved hotkey, `n The reserved letters are `n B, D, E, F, H, I, K, L, P, R, S, T, W, X `nPlease pick a new hotkey")
                    GuiName.Show()
                }
            }
        }

        Hotkeyname := ctrlname . Altname . WinName . letter
        Hotkey := ctrlprefix . Altprefix . Winprefix . letter
        Iniwrite Hotkey, "t2a.ini", "main", "Hotkey"
        Iniwrite Hotkeyname, "t2a.ini", "main", "Hotkeyname"
        msgbox('Your hotkey >' Hotkeyname '< was saved to file t2a.ini in the directory ' A_WorkingDir '`nYour are ready to run T2A')
    }
}
