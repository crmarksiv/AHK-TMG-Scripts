#Requires Autohotkey v1.0+
#SingleInstance, force

Gui, Add, Text, , Check if Programs A, B, or C are Running
Gui, Add, Checkbox,  vNotepad, Notepad
Gui, Add, Checkbox, Checked, vProgramB, Program B
Gui, Add, Checkbox, Checked, vProgramC, Program C
Gui, Add, Button, gCheckRunning, Check Running Programs
Gui, Add, Button, gStopSelected, Stop Selected Programs
Gui, Show, , Program Checker
return

CheckRunning:
    ProgramsRunning := ""

    if Notepad.Checked
        ProgramsRunning .= Process, Exist ,"Notepad.exe"  ? "Program A is running.`n" : "Program A is not running.`n"
    if ProgramB.Checked
        ProgramsRunning .= Process, Exist,"ProgramB.exe"  ? "Program B is running.`n" : "Program B is not running.`n"
    if ProgramC.Checked
        ProgramsRunning .= Process, Exist,"ProgramC.exe"  ? "Program C is running.`n" : "Program C is not running.`n"

    if ProgramsRunning = ""
        ProgramsRunning := "No programs are currently running."

    MsgBox, %ProgramsRunning%
return

StopSelected:
    if Notepad.Checked
        Process, Close, Notepad.exe
    if ProgramB.Checked
        Process, Close, ProgramB.exe
    if ProgramC.Checked
        Process, Close, ProgramC.exe
return

GuiClose:
    ExitApp
