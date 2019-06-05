#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir% 
#Persistent

Menu, Tray, Icon, barrel.ico
Menu, Tray, NoStandard
Loop Files, barrels\*.barrel ; Recurse into subfolders.
{
    StringTrimRight, Var, A_LoopFileName, 7
    Menu, Tray, Add, %Var%, MenuHandler
}
Menu, Tray, Add 
Menu, Options, Add, Barrel Folder, FolderHandler
Menu, Options, Add, Readme, WebHandler
Menu, Options, Add, Github, WebHandler
Menu, Tray, Add, Options, :Options
Menu, Tray, Add
Menu, Tray, Add, Reload, ReloadHandler
Menu, Tray, Add, Quit, ExitHandler
return

MenuHandler:
Loop, read, %A_ScriptDir%\barrels\%A_ThisMenuItem%.barrel
{
    if A_LoopReadLine contains `#
    {
        continue
    }
    if A_LoopReadLine = (show desk)
        {
            SendInput, #d
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

ReloadHandler:
reload 
return 

ExitHandler:
Exitapp
return  