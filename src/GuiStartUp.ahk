




; ここで設定を実行する
star_viewOptionExe()
star_iconOptionExe()


fontNum2 := gusupf_decideButtonFontSizeFromFontSize(sglo_txtFontSize)
buttonW := gusupf_decideButtonWidthFromFontSize(sglo_txtFontSize)

gusupf_guiFontFromSizeAndNameStartUp(sglo_txtFontSize, sglo_txtFontName, 11)
Gui, 11:Add, Edit, X10 Y5  w300  vEditBox11_1 Multi VScroll  HScroll  HwndhwndEditBox11_1
gusupf_guiFontFromSizeAndNameStartUp(fontNum2, "", 11)
Gui, 11:Add, Button, X10 y+15 w%buttonW%   vButton11_1  gSubButton11_1 , 終了(&E)

Gui, 11:+Resize



; バージョン情報
;Gui, 12:Font, S13
;gusupf_cleatedDateStartUp()

;Gui, 12:+Resize




Menu, rClick, Add, アイコンのみにする(&I), sup_SubShowIcon
Menu, rClick, Add, 標準の位置に表示する(&D), sup_SubIniPos
Menu, rClick, Add, 文字を全て消す(&H), sup_SubCleanOutput
Menu, rClick, Add, 経過を全て表示(&R), sup_SubExplanStrSet
Menu, rClick, Add
Menu, rClick, Add, Calcel(&C), sup_SubCancel

Menu, Tray, Add, 表示する(&H), sup_SubGuiShowFromTray
Menu, Tray, Add, アイコンのみにする(&I), sup_SubShowIcon
Menu, Tray, Add, 標準の位置に表示する(&D), sup_SubIniPos
Menu, Tray, Add, StartUpのバージョン(&A), sup_SubVersionGuiStartUp
Menu, Tray, Add
Menu, Tray, Add, 終了する(&X), sup_SubExitApp
Menu, Tray, NoStandard
Menu, Tray, Click, 1
Menu, Tray, Default, 表示する(&H)
Menu, Tray, Tip, WriteStartupBU


sglo_hwndEditBox11_1 := hwndEditBox11_1
