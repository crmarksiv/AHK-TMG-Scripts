GetFocusName()
{
	/*
		This function make TMG the active window, builds an object, and get the Principal Name.  Must be in TMG and in Tag Entry Box
		Requires the ACC libary
	*/

	WinActivate 'ahk_class tmg99c000000'
	if !Winwait('ahk_class tmg99c000000',,5)
			throw
    ControlSend '{f5}',,'ahk_class tmg99c000000'


    oTMG := acc.ElementFromHandle('ahk_class tmg99c000000') ; Connected to TMG
	if !tagEntry := oTMG.FindElement({Name:'Tag Entry'})
		return msgbox('Tag Entry Window not found')


	name := tagEntry.FindElement({Role: 34, i:3}).name
    send '{esc}'
	return  name
}