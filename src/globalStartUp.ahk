
global sglo_myStartUpUserFolder := A_ScriptDir . "\user"

global sglo_myStartUpFile := A_ScriptDir  . "\myStartUp.txt"

global sglo_myStartUpFileDefault := sglo_myStartUpFile

global sglo_winSizePosIni := sglo_myStartUpUserFolder  . "\windowSizePos.ini"

global sglo_optionTxtFile := sglo_myStartUpUserFolder  . "\option.txt"

global sglo_guiTitle := "_TextWriteStartUp"
;global sglo_versionGuiTitle := "StartUpのバージョン情報"

global sglo_delimiter := ","

global sglo_startUpStartUpBuff = 


global sglo_txtFontSize = 13

global sglo_txtFontName =

global sglo_txtView := True

global sglo_txtIcon := True

global sglo_txtWinCloseExit := True

global sglo_txtStartActive := True

;global sglo_timePeriod_sec = 1	; sglo_timePeriod  // 1000  と同じ
global sglo_timePeriod = 2000

global sglo_timer = 0

global sglo_startUpNumber = 1

global sglo_appsObj = Object()

global sglo_appsName =

global sglo_appsArgs =

global sglo_appsWorkDir =

global sglo_appsOption = 1

global sglo_exchangeScript =

global sglo_hideFlag := False

global sglo_fileChangeFlag := False

global sglo_explanStr =

global sglo_hwndEditBox11_1 = 

global MyDocuments := A_MyDocuments

global Desktop := A_Desktop

global ThisSoftDir := A_ScriptDir

SplitPath, A_ScriptDir, , , , , OutDrive
global DriveName := OutDrive

global sglo_dpiNum := libsup_GetDPI()

global sglo_trayIcon := A_ScriptDir . "\doc\iconStartUp.ico"

if(A_IsCompiled == 1){
	sglo_trayIcon := A_ScriptFullPath
} else {
	IfNotExist, %sglo_trayIcon%
	{
		sglo_trayIcon := A_AhkPath
	}
	Menu, Tray, Icon, %sglo_trayIcon%
}
