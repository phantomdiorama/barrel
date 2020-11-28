#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir% 
#Persistent

Menu, Tray, Icon, barrel.ico
Menu, Tray, NoStandard
Loop Files, barrels\*.barrel
{
	MenuString := A_LoopFileName
	word_array := StrSplit(MenuString, ".")
	var:= word_array[1]
	Menu, Tray, Add, %Var%, MenuHandler
}
Menu, Tray, Add 
Menu, Options, Add, Barrel Folder, FolderHandler
; Menu, Options, Add, Add to start up, StartHandler
Menu, Options, Add, Readme, WebHandler
Menu, Tray, Add, Options, :Options
Menu, Tray, Add
Menu, Tray, Add, Reload, ReloadHandler
Menu, Tray, Add, Quit, ExitHandler
return

MenuHandler:
Loop, read, %A_ScriptDir%\barrels\%A_ThisMenuItem%.barrel
{
	if (RegExMatch(A_LoopReadLine, "^#") = 1)
	{
		continue
	}
	if (RegExMatch(A_LoopReadLine, "^\(s") = 1) ;"(show desk)"
		{
			SendInput, #d
			continue
		}
	if (RegExMatch(A_LoopReadLine,"^\$") = 1)
		{
			cmd := SubStr(A_LoopReadLine, 3)
			Run, cmd /k %cmd%
			continue
		}
	if (RegExMatch(A_LoopReadLine,"^_") = 1)
		{
			cmd := SubStr(A_LoopReadLine, 3)
			Run, %cmd%,, Min
			continue
		}
	if (RegExMatch(A_LoopReadLine,"^\+") = 1)
		{
			cmd := SubStr(A_LoopReadLine, 3)
			Run, %cmd%,, Max
			continue
		}
	else
	{
		
		Run, %A_LoopReadLine%
	}
}
return 

FolderHandler:
Run %A_ScriptDir%\barrels
return 

WebHandler:
Run, https://github.com/phantomdiorama/barrel
return 

; StartHandler:
; FileCreateShortcut, %A_ScriptDir%\barrel.ahk, %A_StartMenu%\Programs\Startup\barrel.lnk
; msgbox, Barrel added to start up
; return

ReloadHandler:
reload 
return 

ExitHandler:
Exitapp
return	