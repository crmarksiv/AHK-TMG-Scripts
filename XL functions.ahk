#Requires Autohotkey v1.1.33+
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