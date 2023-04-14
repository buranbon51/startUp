



; ウインドウを表示するのではなくて、文字を出力するだけ
gusupf_cleatedDateStartUp2(){
	version := "v1.00"
	cleatedDate := "2023年4月14日"
	softName := "WriteStartupBU"

	message := "`nソフト名　　：　" . softName . "`nバージョン　：　" . version . "`n更新日　　 ：　" . cleatedDate . "`n作者　　　　：　ブランボン`n"
	message .= "AHKのバージョン：" . A_AhkVersion . "`n" . startupma_bitVar . "`n" . startupma_sign . "`n"
	gusupf_appendEditBox11_1(message)
}

/*
gusupf_cleatedDateStartUp(){
	version := "v1.00"
	cleatedDate := "2019年10月12日"
	softName := "WriteStartupBU"

	Gui, 12:Add, Text,   X70 Y10 , %softName%

	groupW := gusupf_anyOfNumFromDpi(250, 270, 290)
	groupH := gusupf_anyOfNumFromDpi(120, 140, 160)
	Gui, 12:Add, GroupBox, X10 y+15  w%groupW% h%groupH%
	Gui, 12:Add, Text,  X30 yp+20,    バージョン：
	Gui, 12:Add, Text,    x+20 yp+0 , %version%
	Gui, 12:Add, Text,  X30 y+15,    更新日　：
	Gui, 12:Add, Text,    x+20 yp+0 , %cleatedDate%
	Gui, 12:Add, Text,  X30 y+15,    作者　　：
	Gui, 12:Add, Text,    x+20 yp+0 ,    宮本　健次
}
*/

gusupf_initialPosSizeShowGui() {
	width := gusupf_decideWindowWidthFromFontSize(sglo_txtFontSize)
	height := gusupf_decideWindowHeightFromFontSize(sglo_txtFontSize)

	IfExist, %sglo_winSizePosIni%
	{
		FileDelete, %sglo_winSizePosIni%
	}

	DetectHiddenWindows, On
	WinMove, %sglo_guiTitle%, , 40, 75 , %width%, %height%
	if(sglo_hideFlag) {
		;Gui, 11:Show, Hide x40 y75
	}  Else {
		Gui, 11:Show
	}

	; バージョン情報のウインドウも
	;gusupf_initGui12()
}

/*
gusupf_initGui11() {
	Gui, 11:Show, Hide x40 y75 w380 h305, %sglo_guiTitle%
}
*/

/*
gusupf_initGui12(){
	Gui, 12:Show, Hide x160 y300  AutoSize, %sglo_versionGuiTitle%
}
*/

gusupf_guiFontFromSizeAndNameStartUp(fontNum, fontName, GuiNum){
	if(fontName == ""){
		Gui, %GuiNum%:Font, S%fontNum%
		return
	}
	Gui, %GuiNum%:Font, S%fontNum%, %fontName%
}

gusupf_showGui11_Only() {
	if(sglo_hideFlag) {
		;何もしない
	}  Else {
		Gui, 11:Show
	}
}

gusupf_showGui11StartUpStartUp(){
	if(sglo_hideFlag == False) {
		if( sglo_txtStartActive ){
			Gui, 11:Show
		} else {
			Gui, 11:Show, NA
		}
	}
}

gusupf_showGui11_hideTray(){
	sglo_hideFlag := False
	gusupf_showGui11_Only()
	if( sglo_txtIcon == False ){
		Menu, Tray, NoIcon
	}
}
gusupf_hideGui11_showTray(){
	sglo_hideFlag := True
	Gui, 11:Hide
	Menu, Tray, Icon
}

;  エラー表示用に改良  
gusupf_setEditBox11_1Cust(append="", str2="@", str3="@", str4="@") {
	DetectHiddenWindows, On
	GuiControlGet, EditBox11_1, 11:
	if(append == "@") {
		sglo_explanStr = %sglo_explanStr%`n
		GuiControl,11: , EditBox11_1, %EditBox11_1%`n
	} else if (str2 == "@") {
		sglo_explanStr = %sglo_explanStr%%append%`n
		GuiControl,11: , EditBox11_1, %EditBox11_1%%append%`n
	} else if (str3 == "@") {
		sglo_explanStr = %sglo_explanStr%%append%`n%str2%`n
		GuiControl,11: , EditBox11_1, %EditBox11_1%%append%`n%str2%`n
	} else if (str4 == "@") {
		sglo_explanStr = %sglo_explanStr%%append%`n%str2%`n%str3%`n
		GuiControl,11: , EditBox11_1, %EditBox11_1%%append%`n%str2%`n%str3%`n
	} else {
		sglo_explanStr = %sglo_explanStr%%append%`n%str2%`n%str3%`n%str4%`n
		GuiControl,11: , EditBox11_1, %EditBox11_1%%append%`n%str2%`n%str3%`n%str4%`n
	}
	ControlSend , , ^{End}, ahk_id  %sglo_hwndEditBox11_1%
}


gusupf_setEditBox11_1Append(append) {
	sglo_explanStr := sglo_explanStr  . append  . "`n"
	DetectHiddenWindows, On
	GuiControlGet, EditBox11_1, 11:
	after := EditBox11_1 . append  . "`n"
	GuiControl,11: , EditBox11_1, %after%
	ControlSend , , ^{End}, ahk_id  %sglo_hwndEditBox11_1%
}

; gusupf_setEditBox11_1Append()  の別名
gusupf_appendEditBox11_1(append) {
	gusupf_setEditBox11_1Append(append)
}

gusupf_setExplanStr(){
	DetectHiddenWindows, On
	GuiControl,11: , EditBox11_1, %sglo_explanStr%
	ControlSend , , ^{End}, ahk_id  %sglo_hwndEditBox11_1%
}

;  エラーレベルがあるならFalseを  なければTrueに
gusupf_checkErrorLevel11_1(append="", str2="@", str3="@", str4="@") {
	if(ErrorLevel >= 1){
		gusupf_setEditBox11_1Cust("Error   " . ErrorLevel, append, str2, str3)
		return False
	}
	return True
}

gusupf_longIfShortWord(str, wordCount){
	StringLen, length, str
	if(length > wordCount){
		StringLeft, leftStr, str, 13
		StringRight, rightStr, str, 22
		str := leftStr  . "......" . rightStr
	}
	return  str
}

gusupf_decideButtonWidthFromFontSize(fontSize){
	width = 70
	if(fontSize <= 6){
		width = 40
	} else if(fontSize <= 10){
		width = 50
	} else if(fontSize <= 12){
		width = 60
	} else if(fontSize >= 26){
		width = 150
	} else if(fontSize >= 24){
		width = 130
	} else if(fontSize >= 22){
		width = 110
	} else if(fontSize >= 20){
		width = 100
	} else if(fontSize >= 18){
		width = 90
	} else if(fontSize >= 16){
		width = 80
	}

	width2 := width + 20
	width3 := width + 40
	width := gusupf_anyOfNumFromDpi(width, width2, width3)
	return width
}

gusupf_decideButtonFontSizeFromFontSize(fontSize){
	size := fontSize - 2
	size := outsup_lessThanZeroIsOne(size)
	return size
}

gusupf_decideWindowWidthFromFontSize(fontSize){
	width = 420
	if(fontSize <= 6){
		width = 350
	} else if(fontSize <= 10){
		width = 370
	} else if(fontSize <= 12){
		width = 400
	} else if(fontSize >= 26){
		width = 600
	} else if(fontSize >= 24){
		width = 570
	} else if(fontSize >= 22){
		width = 540
	} else if(fontSize >= 20){
		width = 520
	} else if(fontSize >= 18){
		width = 490
	} else if(fontSize >= 16){
		width = 450
	}

	width2 := width + 20
	width3 := width + 40
	width := gusupf_anyOfNumFromDpi(width, width2, width3)
	return width
}

gusupf_decideWindowHeightFromFontSize(fontSize){
	height = 325
	if(fontSize <= 6){
		height = 265
	} else if(fontSize <= 10){
		height = 285
	} else if(fontSize <= 12){
		height = 305
	} else if(fontSize >= 26){
		height = 445
	} else if(fontSize >= 24){
		height = 425
	} else if(fontSize >= 22){
		height = 405
	} else if(fontSize >= 20){
		height = 385
	} else if(fontSize >= 18){
		height = 365
	} else if(fontSize >= 16){
		height = 345
	}

	height2 := height + 20
	height3 := height + 40
	height := gusupf_anyOfNumFromDpi(height, height2, height3)
	return height
}

gusupf_anyOfNumFromDpi(lessThan110, lessThan140, moreThan140){
	if(sglo_dpiNum <= 110){
		return lessThan110
	} else if(sglo_dpiNum <= 140){
		return lessThan140
	} else if(sglo_dpiNum >= 140){
		return moreThan140
	}
	return lessThan110
}

