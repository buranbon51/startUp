
; ファイルに書かれた文字の書式をチェックする。
; 普通行われるルールの変わりにチェックする処理を記入する。
; 返り値が 1 なら、正しい書式として、普通行われるチェックをせずスルーする。
; 返り値が 2 なら、エラー扱とし、中断する。（ファイルの中のこの行のみ処理を止める。）普通行われるチェックはせずスルーする。
; 返り値が 0 なら、普通行われるチェックが実行される。
; plusOption には ６つめのオプションに指定した文字が入ってる。
; count には、何個目に実行する処理かを表した数字が入ってる。



; オプション２（通常はソフトのパスが入る場所）のルール。
uservrfos_validatorRuleForOption2(option2, option3, option4, option5, plusOption, count){

	; 返り値
	number = 0

/*
	if( plusOption == 1 ){
		IfExist, %option2%
		{
			number = 1
			return number
		}
		startup_output(count . " つめの処理でエラー`n２つめのオプションにはファイル名を入れるように")
		number = 2
	}
*/


	return number
}


; オプション３（通常は引数が入る場所）のルール。
uservrfos_validatorRuleForOption3(option2, option3, option4, option5, plusOption, count){

	; 返り値
	number = 0

/*
	if( plusOption == 1 ){
		IfExist, %option3%
		{
			number = 1
			return number
		}
		startup_output(count . " つめの処理でエラー`n３つめのオプションにはファイル名を入れるように")
		number = 2
	}
*/


	return number
}


; オプション４（通常は作業フォルダが入る場所）のルール。
uservrfos_validatorRuleForOption4(option2, option3, option4, option5, plusOption, count){

	; 返り値
	number = 0

/*
	if( plusOption == 1 ){
		IfExist, %option4%
		{
			number = 1
			return number
		}
		startup_output(count . " つめの処理でエラー`n４つめのオプションにはファイル名を入れるように")
		number = 2
	}
*/


	return number
}


; オプション５（通常は　ウインドウの表示の状態　が入る場所）のルール。
uservrfos_validatorRuleForOption5(option2, option3, option4, option5, plusOption, count){

	; 返り値
	number = 0

/*
	if( plusOption == 1 ){
		if(option5 == ""){
			number = 1
			return number
		}
		
		If option5 is integer
		{
			if(option5 < 6){
				if(option5 > 0){
					number = 1
					return number
				}
			}
		}
		startup_output(count . " つめの処理でエラー`n５つめのオプションに1～5以外が指定されている")
		number = 2
	}
*/


	return number
}


; オプション６（plusOptionのこと。この userPlus で利用するためだけの項目）のルール。
uservrfos_validatorRuleForPlusOption(option2, option3, option4, option5, plusOption, count){

	; 返り値
	; 他のオプションと違って、0 を指定しても、何も書式をチェックしない
	number = 1

/*

	if(plusOption == ""){
		number = 1
		return number
	}
	
	If plusOption is integer
	{
		if(plusOption == 0){
			number = 1
			return number
		} else if(plusOption == 1){
			number = 1
			return number
		}
	}
	startup_output(count . " つめの処理でエラー`n６つめのオプションは True か False のみ指定する")
	number = 2

*/


	return number
}
