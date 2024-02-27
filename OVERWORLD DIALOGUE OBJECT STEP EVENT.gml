//step event for the overworld dialogue handler

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

//checking if you're at the end of the current dialogue string
//the letIndex variable is added to at the same time each individual character is printed, therefore when all characters are printed letIndex 
//will equal the string length, then you can proceed
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

//checking if you're at the final line of a batch of dialogue.
//if you are, finalLine is set to one and another confirmation will close the dialogue object
if letIndex = string_length(global.text[txtIndex]) && txtIndex == array_length(global.text) - 1 {
	finalLine = 1	
}

if _confirm {
	switch(confirmAmount)
	{
		case 0:
		//if you're not at the end of the line yet and you press confirm, the whole
		//line will be displayed instantaneously
		if letIndex != string_length(global.text[txtIndex]){
			letIndex = string_length(global.text[txtIndex]);
			msgOutput = global.text[txtIndex];
		}
		confirmAmount = 1;
		break;
		
		case 1:
		//if you ARE at the end of the line, reset it all to 0 for the next line to be 
		//displayed
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
		//will continue a cutscene with a baked in dialogue sequence if cutscene object exists
		if instance_exists(obj_cutscene_handler)
		{
			proceedFlag = 1
		}
		//will simply close the dialogue object if not
		if !instance_exists(obj_cutscene_handler)
		{
			instance_destroy();
		}
	}
}

scr_CHOICELINE();
