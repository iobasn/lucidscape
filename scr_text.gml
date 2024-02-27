function scr_text(_name, _text, _portrait, _snd, _size, _pitch){
	global.talkerName[array_length(global.talkerName) - 1] = _name
	array_resize(global.talkerName, array_length(global.talkerName) + 1);
	
	global.text[array_length(global.text) - 1] = _text
	array_resize(global.text, array_length(global.text) + 1);
	
	global.talkerPortrait[array_length(global.talkerPortrait) - 1] = _portrait;
	array_resize(global.talkerPortrait, array_length(global.talkerPortrait) + 1);
	
	global.talkerSnd[array_length(global.talkerSnd) - 1] = _snd;
	array_resize(global.talkerSnd, array_length(global.talkerSnd) + 1);
	
	
	global.txtSize[array_length(global.txtSize) - 1] = _size;
	array_resize(global.txtSize, array_length(global.txtSize) + 1);
	
	global.tlkPitch[array_length(global.tlkPitch) - 1] = _pitch;
	array_resize(global.tlkPitch, array_length(global.tlkPitch) + 1);
	
}