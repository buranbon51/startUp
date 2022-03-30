



; ON や OFF の文字列か True や False の文字列なら Trueをかえす
outsup_checkFlagStr(flagStr){
	flag := False
	StringLower, flagStrLower, flagStr
	if(flagStrLower == "on"){
		flag := True
	} else if(flagStrLower == "true"){
		flag := True
	} else if(flagStrLower == "1"){
		flag := True
	} else if(flagStrLower == "off"){
		flag := True
	} else if(flagStrLower == "false"){
		flag := True
	} else if(flagStrLower == "0"){
		flag := True
	}
	return flag
}

; ON や OFF の文字列ならTrue や False を返す
; それ以外の文字列なら、Falseを返す
outsup_getFlagByOnOffStr(flagStr){
	flag := False
	StringLower, flagStrLower, flagStr
	if(flagStrLower == "on"){
		flag := True
	} else if(flagStrLower == "true"){
		flag := True
	} else if(flagStrLower == "1"){
		flag := True
	} else if(flagStrLower == "off"){
		flag := False
	} else if(flagStrLower == "false"){
		flag := False
	}
	return flag
}

outsup_lessThanZeroIsOne(num){
	if(num <= 0){
		num = 1
	}
	return num
}

; 指定した文字の 右の文字を返す。なければ 空の文字を返す
outsup_rightStrOrNullFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%
	StringLen, length, searchStr
	count += length
	StringTrimLeft, rStr , str, %count%
	rStr  := Trim(rStr )
	return  rStr 
}

; 指定した文字の 左の文字を返す。なければ 空の文字を返す
outsup_leftStrOrNullFromSearchStr(str, searchStr){
	IfNotInString, str, %searchStr%
	{
		return  ""
	}
	StringGetPos, count, str, %searchStr%
	StringLeft, leftStr, str, %count%
	leftStr := Trim(leftStr)
	return  leftStr
}

; % で囲まれた変数の中身を表示させる
outsup_textOutTrimssParsent(com2) {
	pasentChar := "%"
	IfInString, com2, %pasentChar%
	{
		Loop
		{
			res := RegExMatch(com2, "i)^([^%]*)%(\w+)%([\w\W]*)" , val_ )
			; ちなみに \s は半角Space \D は半角以外の文字 \\ は \  \wは[0-9a-zA-Z_]と同じ
			if(val_2 != ""){
				val_2 := outsup_ansValuePersent(val_2)		; 変数の中身を取得
				if(val_2 == ""){
					; 値が空なので中断
					break
				}
				com2 := val_1 . val_2 . val_3		; 元の値を変更して、ループを繰り返す
			} else {
				break
			}
		}
	}
	return com2
}


outsup_ansValuePersent(str) {
	res := RegExMatch(str, "^[0-9a-zA-Z_@#$]+$")
	if(res == 1) {
		if (%str% == "") {			; 変数を表示させる
			;outsup_outPattern1("%の値が見つかりません")
		} else {
			var2 := %str%
			return var2
		}
	} else {
		gusupf_appendEditBox11_1("%%の中に無効な文字が入ってます")
	}
	gusupf_checkErrorLevel11_1(A_LineFile, A_LineNumber, ErrorLevel)
	return ""
}
