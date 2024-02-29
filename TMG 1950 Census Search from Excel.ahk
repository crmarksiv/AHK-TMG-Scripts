#Requires Autohotkey v1.1.33+
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;******************************************************************************************
;~ Script to read two adjacent cells of and Excel Speadsheet that contain a TMG Person Id, and Person Name
;~ Then search in Ancestry.com for a 1950 Census Record for the Person and make the Focus Person in TMG the selected ID
;~ Some know requirements
;~ 1. Ability  to Use Ancestry.com
;~ 2. One Excel Speadsheet open
;~ 3. TMG open to the desired Project
;~ 4. Select two adjacent cells that contain an Id and Name - hidden cells are ignored
;
;~ Version 1.000  5 Sep 2022
:~ Version 2.0    13 Oct 2022  Person Name in Cell 2 should be format "Last, Given" > Pass to Ancestry as Given_last
;****************************************************************************************
;F8:: ;  Set the Hot Key to invoke this macro
MButton:: ; Middle mouse button

XL:=XL_Handle(1) ; Establish Connection to the Excel Spead sheet
;~ tf := IsObject(XL)
;~ IfNotEqual tf,1
;~ {
;~ MsgBox "You do not have an Excel spreadsheet open, Please open one, select the two cells containg ID and Name and execute this script again"
;~ Exit
;~}
if (!IsObject(XL) )
{
    MsgBox "You do not have an Excel spreadsheet open, Please open one, select the two cells containg ID and Name and execute this script again"
    Exit
}

rangex := XL_Get_Selected_Range(xl) ; find the two or more selected cells
ExcelString := XL_Copy_to_Var(xl,rangex) ; fetch the values from the cells
;MsgBox % "The excel array is  " ExcelString
word_array := StrSplit(ExcelString,["|", ","], ".") ; split the values into parts  rev 2
;;MsgBox % "The 1nd word is " word_array[1]
;MsgBox % "The 2nd word is " word_array[2]
Person_ID := word_array[1] ; the 1st cell will be the person id
Person_LastName := word_array[2] ; the 2nd cell is the person Last name  rev 2
Person_Given    := word_array[3] ; the second part of Cell 2 is the Given name  - rev2
;MsgBox % "The Id is:" Person_ID
;Msgbox % "The Last Name is" Person_LastName
;Msgbox %  "The givn name is" Person_Given
 
If Person_Id is not Integer
{
	Msgbox % "You did not select a Excel range where the 1st cell contained a person ID NUMBER. The excel Sting you selectgfed  was>" ExcelString "<.The Id you selected  was>" Person_ID "< Please reslect two adjacent cells contaning ID and Name and the Execute the script again"
	Exit
}
If Person_Name is Integer
{
	Msgbox % "You did not select a Excel range where the 2nd cell contained a person NAME. The excel Sting you selectgfed  was>" ExcelString "<.The Name you selected  was>" Person_Name "< Please reslect two adjacent cells contaning ID and Name and the Execute the script again"
	Exit
}

; Now open and search Ancestry for 1950 Census records for the Person
tgt := "https://www.ancestry.com/search/categories/cen_1950/?name=" Person_Given "_" Person_LastName ; rev2 e
;MsgBox the target is %tgt%
;Return
; Now open and search Ancestry for 1950 Census records for the Person
run, %tgt%

; wait a bit for Ancestry open and search
Sleep, 1000  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  this is one second, might need adjusting
SetTitleMatchMode,2
WinActivate,The Master 
IfWinNotExist,The Master
{
	MsgBox % "TMG must be running, please start it and run the script again"
	return   
}

 
Sleep,1000
send ^+i
Sleep,250
;MsgBox % "i got here with person id" Person_ID
send, %Person_ID%

sleep,250
send {Enter}
return

XL_First_Row(PXL){
	Return, PXL.Application.ActiveSheet.UsedRange.Rows(1).Row ;first used row in Excel
}

XL_Last_Row(PXL){
	Return, PXL.Application.ActiveSheet.UsedRange.Rows(PXL.Application.ActiveSheet.UsedRange.Rows.Count).Row
}
;******************************************* Excel Functions used above ***************************************
XL_Used_rows(PXL){
	Return,PXL.Application.ActiveSheet.UsedRange.Rows.Count
}

;  Function for connecting to Excel
XL_Handle(Sel){
	ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN ;identify the hwnd for Excel
	Obj:=ObjectFromWindow(hwnd,-16)
	return (Sel=1?Obj.Application:Sel=2?Obj.Parent:Sel=3?Obj.ActiveSheet:"")
}
;***borrowd & tweaked from Acc.ahk Standard Library*** by Sean  Updated by jethrow*****************
ObjectFromWindow(hWnd, idObject = -4){
	if(h:=DllCall("LoadLibrary","Str","oleacc","Ptr"))
		If DllCall("oleacc\AccessibleObjectFromWindow","Ptr",hWnd,"UInt",idObject&=0xFFFFFFFF,"Ptr",-VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
			Return ComObjEnwrap(9,pacc,1)
}
;***********************Show name of object handle is referencing********************************.
;~ XL_Reference(XL) ;will pop up with a message box showing what pointer is referencing
XL_Reference(PXL){
	;~ MsgBox, %HWND%
	;~ MsgBox, % ComObjType(window)
	MsgBox % ComObjType(PXL,"Name")
}

XL_Get_Selected_Range(PXL,Absolute:=0){
		if Absolute
			Address:=PXL.Selection.address ;;~  Selected range with $ in them
		Else
			Address:=PXL.Selection.address(0,0) ;;Selected range without $ in them
		return Address
	}

	XL_Copy_to_Var(PXL,RG:="",Delim:="|"){ ;pipe is defualt
	For Cell in PXL.Application.ActiveSheet.Range(RG)
		Data.=Cell.Text Delim
	return Data:=Trim(Data,Delim) ;trimming off last delimiter
}