draw_set_font(fontBinary);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

//draw_text(scr_GETVIEWX() + 0, scr_GETVIEWY() + 40, "FINAL LINE? = " + string(finalLine));
//draw_text(scr_GETVIEWX() + 0, scr_GETVIEWY() + 80, "CLICK AMT = " + string(confirmAmount));
//draw_text(scr_GETVIEWX() + 0, scr_GETVIEWY() + 90, "LETINDEX = " + string(letIndex));
//draw_text(scr_GETVIEWX() + 0, scr_GETVIEWY() + 120, "NAME LENGTH = " + string(string_length(global.talkerName[txtIndex])));
lineBuf = 10
nameBoxScaleBuf = 23
midBuffer = sprite_get_width(spr_midNameBox)
if global.talkerPortrait[txtIndex] != 0 {
	if letIndex < string_length(global.text[txtIndex]) {
		if portraitImg != sprite_get_number(portraitImg) {
			portraitImg += shuffleSpd;	
		} else {
			portraitImg = 0
		}
	} else {
		portraitImg = 0	
	}
}
//var scale = string_length(global.talkerName[txtIndex])
//draw_text(scr_GETVIEWX() + 0, scr_GETVIEWY() + 140, "SCALE = " + string(scale));
//draw_text(scr_GETVIEWX() + 80, scr_GETVIEWY() + 140, " AMT = " + string(amt));
if global.txtSize[txtIndex] = undefined {
	global.txtSize[txtIndex] = 1.5
}
switch (myState)
{
	case DBOX.CANSKIP:
		if global.talkerName[txtIndex] != 0 {
			while nameCharBuffer = 0 {
				for(var i = 1; i < string_length(global.talkerName[txtIndex]); i++)
				{
					if string_char_at(global.talkerName[txtIndex], i) = " "
					{
						nameChars ++;
					}
				}
				nameCharBuffer = 1	
			}
			draw_sprite_ext(spr_leftNameBox, 0, scr_GETVIEWX() + 70 - 38, scr_GETVIEWY() + 210 - 31, 1, 1, 0, c_white, 1)
			for(var i = 0; i < string_length(global.talkerName[txtIndex]) - nameChars; i++)
			{
				draw_sprite(spr_midNameBox, 0, (scr_GETVIEWX() + 70 - 14) + (midBuffer * i), scr_GETVIEWY() + 210 - 31)	
			}
			var myLen = string_length(global.talkerName[txtIndex]) - nameChars
			draw_sprite(spr_rightNameBox, 0, (scr_GETVIEWX() + 70 - 14) + (sprite_get_width(spr_midNameBox) * myLen), scr_GETVIEWY() + 210 - 31)
		}
		//draw_sprite_ext(spr_textbox, 0, scr_GETVIEWX() + 32, scr_GETVIEWY() + 200, scaleX, scaleY, 0, c_white, 1);
		draw_rectangle_color(scr_GETVIEWX() + 32, scr_GETVIEWY() + 200, scr_GETVIEWX() + 605, scr_GETVIEWY() + 340, c_black, c_black, c_black, c_black, 0)
		draw_sprite_ext(spr_textboxoverlay, 0, scr_GETVIEWX() + 32, scr_GETVIEWY() + 200, scaleX, scaleY, 0, c_white, 1);
		draw_set_font(chosenFont)
		draw_text_ext_transformed_color(scr_GETVIEWX() + 70, scr_GETVIEWY() + 210 + 1, msgOutput, textSep, text_width, global.txtSize[txtIndex] - 0.5, global.txtSize[txtIndex], 0, c_grey, c_grey, c_grey, c_grey, 1)
		draw_text_ext_transformed_color(scr_GETVIEWX() + 70, scr_GETVIEWY() + 210, msgOutput, textSep, text_width, global.txtSize[txtIndex] - 0.5, global.txtSize[txtIndex], 0, c_white, c_white, c_white, c_white, 1)
		draw_set_font(fontMach)
		if global.talkerName[txtIndex] != 0 {
			draw_text_ext_transformed_color(scr_GETVIEWX() + 70 - 28, scr_GETVIEWY() + 210 - 43, global.talkerName[txtIndex], 1000, 1000, 1, 1, 0, c_white, c_white, c_white, c_white, 1)
		}
		draw_set_font(font_VCR)
		//draw_line_width_color(scr_GETVIEWX() + 70 - 20, scr_GETVIEWY() + 210 + 5, scr_GETVIEWX() + 70 - 20, line1DestY + addVal1, 3, lucid, lucid)
		//draw_line_width_color(scr_GETVIEWX() + 70 - 15, scr_GETVIEWY() + 210 + 15, scr_GETVIEWX() + 70 - 15, line1DestY + (addVal1/1.1), 2, lucid, lucid)
		//draw_line_width_color(scr_GETVIEWX() + 70 - 12, scr_GETVIEWY() + 210 + 23, scr_GETVIEWX() + 70 - 12, line1DestY + (addVal1/1.2), 1, lucid, lucid)
		if confirmAmount = 1 {
			draw_sprite_ext(spr_playerFlame, flameImg, scr_GETVIEWX() + 70 + 500 + random(flameShake), scr_GETVIEWY() + 210 + 110 + sin(floatIter) * (amp + 1), 2, 2, 0, lucid, flameAlph)
			draw_sprite_ext(spr_blackStar, 0, scr_GETVIEWX() + 71 + 500 + random(flameShake), scr_GETVIEWY() + 197 + 110 + sin(floatIter) * (amp + 1), 0.9, 0.9, 0, c_white, flameAlph)
		}
		
	break;
	
	case DBOX.CANNOTSKIP:
		draw_sprite_ext(spr_textbox, 0, scr_GETVIEWX() + 100, scr_GETVIEWY() + 100, 16, 4, 0, c_white, 1);
		draw_text_ext_transformed_color(scr_GETVIEWX() + 100, scr_GETVIEWY() + 100, msgOutput, 1000, 20, 2, 2, 0, c_white, c_white, c_white, c_white, 1)
	break;
}

