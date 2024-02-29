#Requires Autohotkey v2.0+
#SingleInstance force
#f4::
{
	xx := LongHKname(A_ThisHotkey)
	MsgBox 'long name ' xx
}
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