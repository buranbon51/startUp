

star_startUpExecute(){
	num := sglo_startUpNumber - 1
	; ユーザーが追加して使用する関数を実行
	res := userpese_exchangeScriptExecute(sglo_appsName, sglo_appsArgs, sglo_appsWorkDir, sglo_appsOption, sglo_exchangeScript, num)
	if( res == False ){
		dbQuouteChar := """"
		sglo_appsName := star_dbQuouteEdgeTrim(sglo_appsName)
		sglo_appsName := dbQuouteChar . sglo_appsName . dbQuouteChar
		appNameArgs := sglo_appsName . " " . sglo_appsArgs
		appNameArgs := Trim(appNameArgs)
		if(sglo_appsOption == ""){
			Run, %appNameArgs% , %sglo_appsWorkDir%, UseErrorLevel
		} else if(sglo_appsOption == "NotActive"){		; ウインドウを背面にする機能を追加
			Run, %appNameArgs% , %sglo_appsWorkDir%, UseErrorLevel, OutputVarPID

			;WinWait, ahk_pid %OutputVarPID% , , 7
			Sleep, 2000
			WinSet, Bottom, , ahk_pid %OutputVarPID%
		} else {
			Run, %appNameArgs% , %sglo_appsWorkDir%, %sglo_appsOption% UseErrorLevel
		}

		res := gusupf_checkErrorLevel11_1(num  . " つめの処理が実行出来ていません`n")
		if(res){
			gusupf_appendEditBox11_1(num  . " つめの処理を無事実行`n")
		}
	}
	star_nextAppSetting()
}

star_insertObj(){
	i = 1
	flag := True	; 実行可能か判定する
	
	str_1 =
	str_2 =
	str_3 =
	str_4 =
	str_5 =
	str_6 =

	; myStartUp.txt があるかどうか確認する
	star_existMyStartUp()

	Loop, Read, %sglo_myStartUpFile%
	{
		lineStr := Trim(A_LoopReadLine)
		if(lineStr == ""){
			Continue
		}
		StringLeft, leftChar, lineStr, 1
		if(leftChar != "#"){			; # があったらコメント扱い

			StringSplit, str_ , lineStr, %sglo_delimiter%, %A_Space%

			;おまけ要素  %%で囲まれてる文字を展開する
			str_2 := outsup_textOutTrimssParsent(str_2)
			str_3 := outsup_textOutTrimssParsent(str_3)
			str_4 := outsup_textOutTrimssParsent(str_4)

			; 項目１
			if( star_checkIsNotNumber(str_1, i) ){
				gusupf_appendEditBox11_1("    " . i . " つめのは処理しないままにします")
				flag := False
			}

			; 項目２
			validateNum := uservrfos_validatorRuleForOption2(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 0 ){
				if( star_checkIsNotFile(str_2, i) ){
					str_2 := gusupf_longIfShortWord(str_2, 37)
					gusupf_setEditBox11_1Cust("    " . i  . " のリンク先が認識出来ません", i  . " つめのは処理しないままにします", str_2)
					flag := False
				}
			} else if( validateNum == 2 ){
				flag := False
			}

			; 項目３
			validateNum := uservrfos_validatorRuleForOption3(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 2 ){
				flag := False
			}

			; 項目４
			validateNum := uservrfos_validatorRuleForOption4(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 0 ){
				str_4 := star_workDirIsNull(str_4, str_2)
				if( star_checkIsNotDir(str_4, i) ){
					str_4 := gusupf_longIfShortWord(str_4, 37)
					gusupf_appendEditBox11_1("    " . i  . " の作業フォルダがフォルダ名と認識出来ず`n    (だだ、実行はします。)`n" . str_4)
				}
			} else if( validateNum == 2 ){
				flag := False
			}

			; 項目５
			validateNum := uservrfos_validatorRuleForOption5(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 0 ){
				if( star_checkWindowViewOptionNot(str_5, i) ){
					flag := False
				}
			} else if( validateNum == 2 ){
				flag := False
			}


			; 項目６
			validateNum := uservrfos_validatorRuleForPlusOption(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 2 ){
				flag := False
			}

			if(flag) {
				optionObj := Object()
				optionObj.Insert(str_1)
				optionObj.Insert(str_2)
				optionObj.Insert(str_3)
				str_4 := star_dbQuouteEdgeTrim(str_4)
				optionObj.Insert(str_4)
				optionObj.Insert(str_5)
				optionObj.Insert(str_6)
				
				sglo_appsObj.Insert(optionObj)
			}
			i++
			flag := True	; フラグを元に戻しておく
			; 初期化しておく
			str_1 =
			str_2 =
			str_3 =
			str_4 =
			str_5 = 1
			str_6 =
		}
	}
}

; myStartUp.txt があるかどうか確認する
star_existMyStartUp(){
	if(sglo_myStartUpFile == sglo_myStartUpFileDefault){
		IfNotExist, %sglo_myStartUpFileDefault%
		{
			star_easyFolderCheckMakeFolder(sglo_myStartUpUserFolder)
			str := "`n#秒数 , ソフトのパス, パラメータ, 作業フォルダ, ウインドウの表示状態`n#例`n150, C:\Program Files\Mozilla Firefox\firefox.exe`n"
			FileAppend , %str% , %sglo_myStartUpFileDefault%
			gusupf_appendEditBox11_1("user\myStartUp.txt  のファイルに起動したいソフトを記述する。`n例`n150,C:\Program Files\Mozilla Firefox\firefox.exe")
			gusupf_showGui11_Only()
		}
	}
}

otam_check(){
	for key, optionObj in  sglo_appsObj
	{
		gusupf_setEditBox11_1Cust(optionObj[1], optionObj[2], optionObj[3], optionObj[4]  . "`n")
	}
	gusupf_checkErrorLevel11_1("", A_LineFile, A_LineNumber)
}

star_formatWindowViewOption(str){
	if(str == ""){
		return True
	} else if(str == "Max") {
		return True
	} else if(str == "Min") {
		return True
	} else if(str == "NotActive") {
		return True
	} else if(str == "Hide") {
		return True
	}
	return False
}

star_windowViewOption(str){

	; Max や Min の文字だったら、そのまま返す
	if( star_formatWindowViewOption(str) ){
		return str
	}

	if(str == 1){
		return ""
	} else if(str == 2) {
		return "Max"
	} else if(str == 3) {
		return "Min"
	} else if(str == 4) {
		return "NotActive"
	} else if(str == 5) {
		return "Hide"
	}

	return ""
}

; 正しければ False
star_checkIsNotNumber(str, num){
	If str is integer
	{
		if( star_checkIsNotSecond(str) ){
			gusupf_appendEditBox11_1(num  . " の秒数が大きすぎ")
			return True
		}
		return False
	}
	gusupf_appendEditBox11_1(num  . " の１つ目に秒数が指定されてない")
	return True
}

; 正しければ False
star_checkIsNotSecond(str){
	if(str < 100000){
		return False
	}
	return True
}

; 両端の " " を取る
star_dbQuouteEdgeTrim(str_local){
	dbQuouteChar := """"
	StringLeft, LChar, str_local, 1
	if(LChar == dbQuouteChar){
		StringTrimLeft, strTmp, str_local, 1
		StringRight, rChar, strTmp, 1
		if(rChar == dbQuouteChar){
			StringTrimRight, str_local, strTmp, 1
		}
	}
	return str_local
}

; 正しければ False
star_checkIsNotFile(str, num){
	str := star_dbQuouteEdgeTrim(str)
	IfExist,  %str%
	{
		return  False
	}
	return  True
}

; 空の場合 フォルダ名を返す
star_workDirIsNull(str, appName){
	if(str == ""){
		appName := star_dbQuouteEdgeTrim(appName)
		IfExist,  %appName%
		{
			SplitPath, appName , , OutDir
			return  OutDir
		}
	}
	return  str
}

; 正しければ False
star_checkIsNotDir(str, num){
	; カラでも 正しい
	if(str == ""){
		return  False
	}

	str := star_dbQuouteEdgeTrim(str)
	type := FileExist(str)
	IfInString, type, D
	{
		return  False
	}
	return  True
}

; 正しければ False
star_checkWindowViewOptionNot(str, num){
	if( star_formatWindowViewOption(str) ){
		return  False
	}
	
	If str is integer
	{
		if(str < 6){
			if(str > 0){
				return  False
			}
		}
	}
	gusupf_appendEditBox11_1(num  . " の5つめの項目のエラー`n  1～5を指定して")
	return True
}

star_nextAppSetting(){
	optionObj := sglo_appsObj[sglo_startUpNumber]
	opt1 := optionObj[1]
	if( opt1 != "" ){
		dateTime = %A_Now%
		EnvAdd, dateTime, %opt1% , Seconds
		sglo_timer := dateTime
		sglo_appsName := optionObj[2]
		sglo_appsArgs := optionObj[3]
		sglo_appsWorkDir := optionObj[4]
		; 文字が長い場合、省略する
		appsName := gusupf_longIfShortWord(optionObj[2], 37)
		appsArgs := gusupf_longIfShortWord(optionObj[3], 37)
		appsWorkDir := gusupf_longIfShortWord(optionObj[4], 37)

		opt5 := star_windowViewOption(optionObj[5])
		sglo_appsOption := opt5
		sglo_exchangeScript := optionObj[6]
		buff := "    " . sglo_startUpNumber  . "  つめの処理`n" . optionObj[1]  . "  秒後に実行`nパス`n" . appsName  . "  " . appsArgs
		if(appsWorkDir != ""){
			buff .= "`n作業フォルダ`n" . appsWorkDir
		}
		gusupf_appendEditBox11_1(buff)
	} else {
		SetTimer, sup_SubRendarTime, Off
		if(sglo_startUpNumber > 1){
			gusupf_appendEditBox11_1("無事すべて実行")
		} else {
			gusupf_appendEditBox11_1("実行するものがないのでそのまま終了。")
			gusupf_showGui11_Only()
		}
		Sleep, 7000
		star_appEndLogic()
	}
	sglo_startUpNumber++
}

star_appEndLogic(){
	if( sglo_hideFlag ) {
		; 何もしない
	} Else {
		WinRestore, %sglo_guiTitle%
		star_easyFolderCheckMakeFolder(sglo_myStartUpUserFolder)
		SetTimer, sup_SubRendarTime, Off
		WinGetPos , X, Y, Width, Height, %sglo_guiTitle%
		IniWrite, %X%, %sglo_winSizePosIni%, guiSizePos, GuiX
		IniWrite, %Y%, %sglo_winSizePosIni%, guiSizePos, GuiY
		IniWrite, %Width%, %sglo_winSizePosIni%, guiSizePos, GuiWidth
		IniWrite, %Height%, %sglo_winSizePosIni%, guiSizePos, GuiHeight
	}
	;Sleep, 2000
	ExitApp
}

star_checkFileAndFolderMakeFolderAndFile(){
	star_easyFolderCheckMakeFolder(sglo_myStartUpUserFolder)

	; myStartUp のファイルは別の場所で作成する
	;defaultWord1 := "`n#秒数 , ソフトのパス, パラメータ, 作業フォルダ, ウインドウの表示状態`n#例`n#150, C:\Program Files\Mozilla Firefox\firefox.exe`n"
	;star_easyFileCheckMakeFolderAndFile(sglo_myStartUpFile, "", defaultWord1)

	defaultWord2 := "`n#設定をする。何も記入しなければ初期値を使用する。`nfontSize=13`nview=True`nicon=True`n"
	star_easyFileCheckMakeFolderAndFile(sglo_optionTxtFile, sglo_myStartUpUserFolder, defaultWord2)

}

star_fileNotExistReturnNull(file){
	IfNotExist,  %file%
	{
		returnValue := ""
		Return  returnValue
	}
	Return  file
}

star_easyFolderCheckMakeFolder(folder){
	type := FileExist(folder)
	if(type == ""){
		FileCreateDir, %folder%
	} else {
		IfNotInString, type, D
		{
			ToolTip , %folder%はフォルダ名ではない, A_CaretX, A_CaretY, 2
		}
	}
}

star_easyFileCheckMakeFolderAndFile(file, parentFolder, defaultStr=""){
	IfNotExist, %file%
	{
		type := FileExist(parentFolder)
		if(type == ""){
			FileCreateDir, %parentFolder%
		} else {
			IfNotInString, type, D
			{
				ToolTip , %parentFolder%はフォルダ名ではない, A_CaretX, A_CaretY, 2
				return
			}
		}
		FileAppend , %defaultStr%, %file%
	}
}

star_iniSettingSizePos(){
	DetectHiddenWindows, On
	Gui, 11:Show, Hide, %sglo_guiTitle%
	; 380
	defaultWidth := gusupf_decideWindowWidthFromFontSize(sglo_txtFontSize)
	; 305
	defaultHeight := gusupf_decideWindowHeightFromFontSize(sglo_txtFontSize)

	IniRead, VarX, %sglo_winSizePosIni%, guiSizePos, GuiX , 40
	IniRead, VarY, %sglo_winSizePosIni%, guiSizePos, GuiY , 75
	IniRead, VarWidth, %sglo_winSizePosIni%, guiSizePos, GuiWidth , %defaultWidth%
	IniRead, VarHeight, %sglo_winSizePosIni%, guiSizePos, GuiHeight , %defaultHeight%

	WinMove, %sglo_guiTitle%, , %VarX%, %VarY% , %VarWidth%, %VarHeight%
}

star_parameterSettingAny(argText){
	if(argText == ""){
		return
	}
	star_optionSettingAny(argText, False)
}

star_parameterUseFunc(arg1, arg2, arg3, arg4, arg5){
	star_parameterSettingAny(arg1)
	star_parameterSettingAny(arg2)
	star_parameterSettingAny(arg3)
	star_parameterSettingAny(arg4)
	star_parameterSettingAny(arg5)
}


/*
	使わないことにした
star_argUseFunc(arg1, arg2){
	star_argFileExist(arg1)
	star_argFileExist(arg2)
	if( sglo_fileChangeFlag ){
		star_appendStartUpStartUpBuff("ファイル名  " . sglo_myStartUpFile  . "`n  で処理")
	}
}

star_argFileExist(arg){
	if(arg == ""){
		Return
	}
	IfExist, %arg%
	{
		if( star_argIsStartUpFileCheck(arg) ){
			sglo_myStartUpFile := arg
			sglo_fileChangeFlag := True
		} else {
			MouseGetPos, OutputVarX, OutputVarY
			ToolTip , そのファイルは処理できない。このまま終了します。, %OutputVarX%, %OutputVarY%
			Sleep, 3000
			ToolTip
			ExitApp
		}
	} else {
		; 引数が -icon かどうか調べる
		if( star_argIsIcon(arg) ) {

		; 引数が -hide かどうか調べる
		} else if( star_argIsHide(arg) ) {

		} else {
			MouseGetPos, OutputVarX, OutputVarY
			ToolTip , 引数 %arg% が不明。そのファイルは存在しない。`nこのまま終了します。, %OutputVarX%, %OutputVarY%
			Sleep, 3000
			ToolTip
			ExitApp
		}
	}
}

star_argIsStartUpFileCheck(arg1){
	; 最初の行に 空白や # があってもいいようにループで確認
	Loop, Read, %arg1%
	{
		lineStr := Trim(A_LoopReadLine)
		if(lineStr == ""){
			Continue
		}
		StringLeft, leftChar, lineStr, 1
		if(leftChar != "#"){			; # があったらコメント扱い
			StringSplit, str_ , lineStr, %sglo_delimiter%, %A_Space%
			if( star_checkIsNotNumber(str_1, i) ){
				return  False
			}

			;おまけ要素  %%で囲まれてる文字を展開する
			str_2 := outsup_textOutTrimssParsent(str_2)
			if( star_checkIsNotFile(str_2, i) ){
				return  False
			}
			return  True
		}
	}
	return  False
}
*/


star_argIsHide(arg){
	if(arg == "-hide"){
		sglo_hideFlag := True
		Return  True
	}
	Return  False
}

star_argIsIcon(arg){
	if(arg == "-icon"){
		sglo_hideFlag := True
		Menu, Tray, Icon
		Return  True
	}
	Return  False
}

star_anotherFileUse(arg){
	dbQuoute := """"
	arg := Trim( arg, dbQuoute )
	star_anotherFileUseLogic(arg)
	if( sglo_fileChangeFlag ){
		star_appendStartUpStartUpBuff("指定された`n" . sglo_myStartUpFile . "`nのファイルを使って動作します。")
	}
}

star_anotherFileUseLogic(arg){
	if(arg == ""){
		return
	}
	IfExist, %arg%
	{
		if( star_anotherFileCheck(arg) ){
			sglo_myStartUpFile := arg
			sglo_fileChangeFlag := True
		} else {
			MouseGetPos, OutputVarX, OutputVarY
			ToolTip , %arg%`nこのファイルは書式が解析できない。`nこのまま終了します。, %OutputVarX%, %OutputVarY%
			Sleep, 8000
			ToolTip
			ExitApp
		}
	} else {
		MouseGetPos, OutputVarX, OutputVarY
		ToolTip , ファイルパス`n%arg%`nが存在しない。`nこのまま終了します。, %OutputVarX%, %OutputVarY%
		Sleep, 8000
		ToolTip
		ExitApp
	}
}

star_anotherFileCheck(arg){
	; 最初の行に 空白や # があってもいいようにループで確認
	Loop, Read, %arg%
	{
		lineStr := Trim(A_LoopReadLine)
		if(lineStr == ""){
			Continue
		}
		StringLeft, leftChar, lineStr, 1
		if(leftChar != "#"){			; # があったらコメント扱い
			StringSplit, str_ , lineStr, %sglo_delimiter%, %A_Space%
			if( star_checkIsNotNumber(str_1, i) ){
				return  False
			}

			; 項目２
			;おまけ要素  %%で囲まれてる文字を展開する
			str_2 := outsup_textOutTrimssParsent(str_2)
			validateNum := uservrfos_validatorRuleForOption2(str_2, str_3, str_4, str_5, str_6, i)
			if( validateNum == 0 ){
				if( star_checkIsNotFile(str_2, i) ){
					return  False
				}
			} else if( validateNum == 2 ){
				return  False
			}
			return  True
		}
	}
	return  False
}

star_appendStartUpStartUpBuff(append){
	sglo_startUpStartUpBuff .= append . "`n"
}

star_checkErrorLevelStartUpStartUpBuff(append="") {
	if(ErrorLevel >= 1  && ErrorLevel < 5){
		star_appendStartUpStartUpBuff("ErrorLevel   " . ErrorLevel  . "`n" . append)
		ErrorLevel = 0
		return False
	}
	return True
}

star_startUpStartUpBuffOutput(){
	if(sglo_startUpStartUpBuff != ""){
		gusupf_appendEditBox11_1(sglo_startUpStartUpBuff)
	}
}

star_viewOptionExe(){
	if( sglo_txtView == False ){
		sglo_hideFlag := True
	}
}

star_iconOptionExe(){
	if( sglo_txtIcon ){
		;Menu, Tray, Icon
	} else {
		Menu, Tray, NoIcon
	}
}

star_fontSizeOptionSet(oneLineText){
	rightStr := outsup_rightStrOrNullFromSearchStr(oneLineText, "=")
	if(rightStr == ""){
		rightStr = 13
	}
	If rightStr is integer
	{
		if(rightStr <= 0){
			star_appendStartUpStartUpBuff("フォントサイズのエラー`n0 以下の値になっているのでエラー`n" . oneLineText . "`n")
			rightStr = 13
		} else if(rightStr >= 51){
			star_appendStartUpStartUpBuff("フォントサイズのエラー`n数字が大きすぎるのでエラーにする`n" . oneLineText . "`n")
			rightStr = 13
		}
		return rightStr
	}
	star_appendStartUpStartUpBuff("フォントサイズのエラー`n数字以外が指定されているのでエラー`n" . oneLineText . "`n")
	rightStr = 13
	return rightStr
}

star_twoSelectOptionSet(oneLineText, errorMsg){
	rightStr := outsup_rightStrOrNullFromSearchStr(oneLineText, "=")
	if(rightStr == ""){
		rightStr = 1
		return rightStr
	}

	; ON や OFF の文字列か True や False の文字列なら Trueをかえす
	if( outsup_checkFlagStr(rightStr) ){
		rightStr := outsup_getFlagByOnOffStr(rightStr)
		return rightStr
	}

	errorPlus := errorMsg . "`nTrueかFalse以外が指定されているのでエラー`n" . oneLineText
	star_appendStartUpStartUpBuff(errorPlus)
	rightStr = 1
	return rightStr
}

star_optionSettingAny(oneLineText, fromTxtFlag){
	leftStr := outsup_leftStrOrNullFromSearchStr(oneLineText, "=")
	if(leftStr == ""){
		if(fromTxtFlag == False){
			star_appendStartUpStartUpBuff("このパラメータは使用できない`n" . oneLineText)
		}
	} else {
		StringLower, leftStr, leftStr
		if(leftStr == "fontsize"){
			sglo_txtFontSize := star_fontSizeOptionSet(oneLineText)
		} else if(leftStr == "view"){
			sglo_txtView := star_twoSelectOptionSet(oneLineText, "表示の設定のエラー")
		} else if(leftStr == "icon"){
			sglo_txtIcon := star_twoSelectOptionSet(oneLineText, "アイコンの設定のエラー")
		} else if(leftStr == "windowcloseisexit"){
			sglo_txtWinCloseExit := star_twoSelectOptionSet(oneLineText, "ウインドウを閉じた時の設定のエラー")
		} else if(leftStr == "startactive"){
			sglo_txtStartActive := star_twoSelectOptionSet(oneLineText, "起動時にアクティブの状態で表示の設定のエラー")
		} else if(leftStr == "fontname"){
			sglo_txtFontName := outsup_rightStrOrNullFromSearchStr(oneLineText, "=")
			sglo_txtFontName := Trim(sglo_txtFontName)
		} else if(leftStr == "file"){
			rightStr := outsup_rightStrOrNullFromSearchStr(oneLineText, "=")
			rightStr := Trim(rightStr)
			star_anotherFileUse(rightStr)
		} else {
			errorMsg = 
			if(fromTxtFlag){
				errorMsg := "使用できないオプションがある`n"
			} else {
				errorMsg := "このパラメータは使用できない`n"
			}
			star_appendStartUpStartUpBuff(errorMsg . oneLineText)
		}
	}
}

star_optionSettingFromTxtFile(){
	comment := "#"		; コメントの文字
	loopCount = 0

	Loop, Read, %sglo_optionTxtFile%
	{
		; 現時点では 8 回までのループ
		if(loopCount >= 8){
			break
		}

		oneLineText := Trim(A_LoopReadLine)
		if(oneLineText != ""){
			StringLeft, leftChar, oneLineText, 1
			if(leftChar != comment){		; # が左にあったらコメント扱い
				loopCount++
				star_optionSettingAny(oneLineText, True)
			}
		}
	}
}
