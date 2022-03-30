
#SingleInstance FORCE	;終了してから再起動

#KeyHistory 0
;#NoTrayIcon

; 後で設定
;DetectHiddenWindows, Off
DetectHiddenText, Off

SetWorkingDir, %A_ScriptDir%


global startupma_bitVar := "64ビット"
global startupma_sign := ""

#Include %A_ScriptDir%\src\globalStartUp.ahk

#Include %A_ScriptDir%\src\beforehandInitStartUp.ahk

#Include %A_ScriptDir%\src\argUseStartUp.ahk

#Include %A_ScriptDir%\src\GuiStartUp.ahk

#Include %A_ScriptDir%\src\iniSettingStartUp.ahk
gusupf_checkErrorLevel11_1("", A_LineFile, A_LineNumber, ErrorLevel)

DetectHiddenWindows, Off


;global trrma_bitVar := "64ビット"
;global trrma_sign := ""
;#Include %A_ScriptDir%\trrEvery\src\var2\newAhk_Gui\startTrrVar2\startUpExecute.ahk
;gusupf_checkErrorLevel11_1("", A_LineFile, A_LineNumber, ErrorLevel)


gusupf_showGui11StartUpStartUp()


return

;#Include %A_ScriptDir%\trrEvery\src\var2\newAhk_Gui\startTrrVar2\subroutineAndFunction.ahk

#Include %A_ScriptDir%\src\startUpSubLutin.ahk

#Include %A_ScriptDir%\src\guiStartUpFunction.ahk

#Include %A_ScriptDir%\src\startUpFunc.ahk

#Include %A_ScriptDir%\src\outSideStartUpFunc.ahk

#Include %A_ScriptDir%\src\easyToUse\easyToUseStartUpFunc.ahk

#Include %A_ScriptDir%\src\userPlus\exchangeScriptExecute.ahk

#Include %A_ScriptDir%\src\userPlus\validatorRulesForOptions.ahk

#Include %A_ScriptDir%\src\libFunc.ahk
