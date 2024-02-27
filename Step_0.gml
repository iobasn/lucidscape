_confirm = keyboard_check_pressed(ord("Z")) or global._buttA
floatIter += floatIterSpeed;
addVal1 = lerp(addVal1, 115, 0.1)
transAlph = lerp(transAlph, 0.3, 0.3);
with obj_portraitDrawer
{
	myPortrait = global.talkerPortrait[other.txtIndex]	
}
if flameImg != sprite_get_number(spr_playerFlame){
	flameImg += 0.3
} else {
	flameImg = 0	
}
while cleanupBuffer = 0 {
	for(var i = 0; i < array_length(global.text); i++)
{
		if global.text[i] == 0 {
			array_delete(global.text, i, 1);
			array_delete(global.talkerName, i, 1);
			array_delete(global.talkerSnd, i, 1);
			array_delete(global.talkerPortrait, i, 1);
			array_delete(global.txtSize, i, 1);	
			array_delete(global.tlkPitch, i, 1);	
		}
		
	}
	for (var k = 0; k < array_length(global.tlkPitch); k++)
	{
		if global.tlkPitch[k] = undefined {
			global.tlkPitch[k] = 1	
		}	
	}
	cleanupBuffer = 1	
}

if letIndex = string_length(global.text[txtIndex]) {
	confirmAmount = 1
}
switch(confirmAmount)
{
	case 0:
		flameShake = lerp(flameShake, 15, 1)
		flameAlph = lerp(flameAlph, 0, 1)
	
	break;
	
	case 1:
		flameShake = lerp(flameShake, 0, 0.1)
		flameAlph = lerp(flameAlph, 1, 0.4)

	break;
}
if letIndex = string_length(global.text[txtIndex]) && txtIndex == array_length(global.text) - 1 {
	finalLine = 1	
}

if _confirm {
	switch(confirmAmount)
	{
		case 0:
		
		if letIndex != string_length(global.text[txtIndex]){
			letIndex = string_length(global.text[txtIndex]);
			msgOutput = global.text[txtIndex];
		}
		confirmAmount = 1;
		break;
		
		case 1:
		scr_portraitDrawerReset()
		nameCharBuffer = 0
		nameChars = 0
		msgOutput = "";
		if txtIndex != array_length(global.text) - 1 {
			letIndex = 1;
			confirmAmount = 0;
			alarm[0] += talkSpd;
			txtIndex++;
		}
		break;
	}	
	if finalLine == 1 {
		if instance_exists(obj_cutscene_handler)
		{
			proceedFlag = 1
		}
		if !instance_exists(obj_cutscene_handler)
		{
			instance_destroy();
		}
	}
}

scr_CHOICELINE();