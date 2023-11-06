#Requires AutoHotkey v2.0
Persistent

TraySetIcon "icon.ico"
Tray := A_TrayMenu
Tray.Delete()

Loop Files "barrels\*.barrel"
{
    MenuString := A_LoopFileName
    word_array := StrSplit(MenuString, ".")
    Var := word_array[1]
    Tray.Add(Var, MenuHandler)
}

Tray.Add()
Tray.Add("Barrels", FolderHandler)
Tray.Add("Website", WebHandler)
Tray.Add("Reload", ReloadHandler)
Tray.Add("Quit", ExitHandler)

MenuHandler(ItemName, *) {
Loop read "barrels\" ItemName ".barrel"
{
    if (RegExMatch(A_LoopReadLine, "^#") = 1)
    {
        continue
    }
    if (RegExMatch(A_LoopReadLine,"^\$") = 1)
    {
        App := SubStr(A_LoopReadLine, 3)
        Run("cmd /k" App)
        continue
    }
    if (RegExMatch(A_LoopReadLine,"^_") = 1)
    {
        App := SubStr(A_LoopReadLine, 3)
        Run(App, , "Min")
        continue
    }
    if (RegExMatch(A_LoopReadLine,"^\+") = 1)
    {
        App := SubStr(A_LoopReadLine, 3)
        Run(App, , "Max")
        continue
    }
    else
    {
        Run A_LoopReadLine
    }
}
}

FolderHandler(*) {
    Run("barrels\")
}

WebHandler(*) {
    Run("https://github.com/phantomdiorama/barrel")
}

ReloadHandler(*) {
    reload
}

ExitHandler(*) {
    Exitapp
}
