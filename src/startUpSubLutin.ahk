
sup_SubCancel:

	return


sup_SubRendarTime:
	if(sglo_timer < A_Now){
		star_startUpExecute()
		
	}
	return

sup_SubCleanOutput:
	GuiControl,11: , EditBox11_1, %A_Space%
	return

sup_SubExplanStrSet:
	gusupf_setExplanStr()
	return

sup_SubIniPos:
	gusupf_initialPosSizeShowGui()
	return

sup_SubShowIcon:
	gusupf_hideGui11_showTray()
	return

sup_SubGuiShowFromTray:
	gusupf_showGui11_hideTray()
	return

sup_SubVersionGuiStartUp:
	;Gui, 12:Show
	gusupf_cleatedDateStartUp2()
	return

sup_SubExitApp:
	SetTimer, sup_SubRendarTime, Off
	star_appEndLogic()
	return


11GuiContextMenu:
	Menu, rClick, Show, %A_GuiX%, %A_GuiY%
	return

11GuiClose:
	if( sglo_txtWinCloseExit ){
		SetTimer, sup_SubRendarTime, Off
		star_appEndLogic()
	} else {
		Gui, 11:Minimize
	}
	return


11GuiEscape:
	Gui, 11:Minimize
return

SubButton11_1:
	SetTimer, sup_SubRendarTime, Off
	star_appEndLogic()
	return

11GuiSize:
	width := A_GuiWidth - 20
	height := A_GuiHeight - 60
	changeY1 := height + 15
	GuiControl, 11:Move, EditBox11_1, w%width%  h%height%
	GuiControl, 11:Move, Button11_1,  y%changeY1%
	return


;12GuiEscape:
;	Gui, 12:Hide
;	return

