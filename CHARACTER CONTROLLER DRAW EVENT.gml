//draw current analogue stick values
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 60, "HAXIS " + string(haxis))
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 80, "VAXIS " + string(vaxis))

//draw the action menu index
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 140, actionMenuIndex)

//a member object stores how far it is from the borders of the camera with some simple subtraction
//when they are out of the cameras bounds, the members offscreen value is set to one- inversely, it is set to 0 if they are within the cameras bounds
//this loop parses that offscreen value and draws a line from the currently controlled member to the offscreen member/s if they are in fact off screen
//this implementation is probably not permanent. the idea is i want the player to have at least some semblance of an idea where offscreen members are
//when choosing who to switch to on the fly.

for(var i = 0; i < array_length(mate); i++)
{
	if mate[i].offscreen = 1 && mate[i] != global.CURRENTLY_CONTROLLED_CHARA
	{
		draw_line_width_color(mate[i].x, mate[i].y, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y, 2, mate[i].COLOR, global.CURRENTLY_CONTROLLED_CHARA.COLOR)
	}
	//draw_text(scr_GETVIEWX() + 200, scr_GETVIEWY() + 20 + (20 * i), "MEMBER @ INDEX " + string(i) + " " + string(mate[i]))
}



//set coordinates for the UI Star and accompanying icon of MENU[currentMenuIndex]
menuStarX = scr_GETVIEWX() + ((sprite_get_width(spr_UISTAR)/2) - 36)
itemIconX = scr_GETVIEWX() + ((sprite_get_width(MENU[i].SPRITE)/2) + 110) + itemIconOffset
itemIconY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - sprite_get_height(MENU[i].SPRITE)/2)
menuStarY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - (sprite_get_height(spr_UISTAR)/2) + 18)

//final star rotation value lerps to 0 so when it's added or subtracted from a jerking rotational motion is generated when the player
//flips through the action menu
//it's totally cosmetic :)
finalStarRotation = lerp(finalStarRotation, 0, 0.5)

//draw the UI Star and accompanying icon of MENU[currentMenuIndex]
draw_sprite_ext(MENU[actionMenuIndex].SPRITE, 0, itemIconX, itemIconY, 1, 1, 0, MENU[actionMenuIndex].COLOR, random_range(0.05, 0.15))
draw_sprite_ext(spr_UISTAR, 0, menuStarX, menuStarY, 1, 1, finalStarRotation, MENU[actionMenuIndex].COLOR, 1)


//the backdrop slots for action menu entries are drawn dynamically based on the length, scale and font being used for MENU[i].string.
//i set it up this way purely for ease of use when fine tuning the action menu. i love dynamiiiicsss!!!
//note, the MENU array is populated by constructor entries- not simple strings- in order to make attributing unique properties to each entry easier
//like giving each entry a unique color and a state that can be kept track of(like disabled/enabled, for example)

var desiredFont = fontMach
var fontSize = font_get_size(desiredFont)
var fontBuffer = 12
var elementScale	= 1
var horizontalBuffer 
var randomOffset
var elementOffsetTotal 

for(var i = 0; i < array_length(MENU); i++)
{
	if actionMenuIndex == i {
		horizontalBuffer = 35
		//randomOffset = random(0.3)
		//draw_text_ext_transformed_color(scr_GETVIEWX() + (MENU_XOFFSET + (horizontalBuffer - fadeTextOffset)) + randomOffset, scr_GETVIEWY() + MENU_YOFFSET + (((fontSize + fontBuffer) * elementScale) * actionMenuIndex), MENU[actionMenuIndex].NAME, 10, 1000, elementScale, elementScale, 0, col, col, col, col, fadeTextAlpha)	
	} else { 
		horizontalBuffer = 0
		//randomOffset = 0
	}
	elementOffsetTotal = (((fontSize + fontBuffer)* elementScale) * actionMenuIndex)

	MENUX[i] = lerp(MENUX[i], scr_GETVIEWX() + ((MENU_XOFFSET + (15 * i)) + horizontalBuffer), uiLerpRate)
	MENUY[i] = lerp(MENUY[i], scr_GETVIEWY() + MENU_YOFFSET + (((fontSize + fontBuffer) * elementScale) * i), uiLerpRate)
	
}



menuSlotIter += menuSlotIterSpeed

//this is where the action menu is actually drawn, and where them being struct entries comes in handy
//if actionMenuIndex == i, then the loop has the go ahead to draw MENU[i] in its assigned color- creating the highlight effect
//else, it's drawn as white

for(var i = 0; i < array_length(MENU); i++)
{
	draw_set_font(desiredFont)
	var baseColor = c_white
	var baseUnderColor = c_grey
	var highlightUnderColor = c_green
	var highlightColor = global.LUCID_GREEN
	var col
	var elementScale = 1
	var col2 = c_black
	var underSlotBuffer		= 0 
	
	if i == actionMenuIndex {
		col = MENU[i].COLOR
		horizontalBuffer = 35
		sinBuffer = sin(menuSlotIter) * 0.5
	} else { 
		col = c_white
		horizontalBuffer = 0
		randomOffset = 0
		sinBuffer = 0
	}
	var slotBufferHorizontal = 4
	var slotBufferVertical	 = 1
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i] + 2.5, MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, MENU[i].COLOR, MENU[i].COLOR, MENU[i].COLOR, MENU[i].COLOR, 1)
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i] + 2, MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, col2, col2, col2, col2, 1)	
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i], MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, col, col, col, col, 1)	
	
	//draw_sprite_ext(spr_actionMenuRow, 0, MENUX[i], MENUY[i], string_width(MENU[i].NAME)/3, string_height(MENU[i].NAME)/3, 0, c_white, 1)

}

//coordinates for the action menu being set
//note, the GETVIEW scripts return the coordinates of the camera and provide them as an offset for UI elements to assure they 
//follow the player around as they should

actionX = scr_GETVIEWX() + actionAnchorX
actionY = scr_GETVIEWY() + actionAnchorY
draw_set_font(fontKHGummi)
draw_text_ext_transformed_color(actionX, actionY, "ACTION", 10, 1000, 1, 0.5, 0, c_white, c_white, c_white, c_white, 1)

//parameters for some cosmetic text that appears to fade away from the highlighted action menu entry
fadeTextOffset += 0.1
if fadeTextOffset >= 35 { fadeTextOffset = 0}
var fadeTextPercent = (fadeTextOffset * 35)/100
fadeTextAlpha = 1/fadeTextPercent

 //draw an arrow over the currently controlled character as well as their name and the control index
draw_sprite(spr_arrowbottom, 0, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y - (sprite_get_height(global.CURRENTLY_CONTROLLED_CHARA.sprite_index) + sin(floatIter)))
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 10, global.CURRENTLY_CONTROLLED_CHARA.NAME)
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 30, CONTROL_INDEX)

//setting coordinates for battle portraits and promptly drawing them
initialPortraitX = scr_GETVIEWX() + (camera_get_view_width(view_camera[0]) - 10)
initialPortraitY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - 35)

//i've been playing around with UI lerping to its final destination rather than it being drawn to static coordinates
//like in nier automata, i kinda like it! we'll see

portraitX[0] = lerp(portraitX[0], initialPortraitX, uiLerpRate)
portraitX[1] = lerp(portraitX[1], portraitX[0], uiLerpRate)
portraitX[2] = lerp(portraitX[2], portraitX[1], uiLerpRate)

portraitY[0] = lerp(portraitY[0], initialPortraitY, uiLerpRate)
portraitY[1] = lerp(portraitY[1], portraitY[0] - 124, uiLerpRate)
portraitY[2] = lerp(portraitY[2], portraitY[1] - 62, uiLerpRate) 

var myFont = fontMach
var portraitBuffer
draw_set_font(myFont)
for(var i = 0; i < array_length(mate); i++)
{
	portraitBuffer = ((sprite_get_width(mate[i].currentPortrait)/2) * myPortraitScale[i])
	//FOR THE FIRST PORTRAIT
	draw_set_halign(fa_right)
	draw_sprite_ext(spr_portraitBackground, 0, portraitX[i] - portraitBuffer, portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, c_white, 0.8)
	draw_sprite_ext(spr_portraitGradient, 0, portraitX[i] - portraitBuffer, portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, global.LUCID_GREEN, 1)
	draw_sprite_ext(spr_portraitContainerUpper, 0, portraitX[i] - portraitBuffer, portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, c_white, 1)
	draw_sprite_ext(mate[i].currentPortrait, 0, portraitX[i] - portraitBuffer, portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, mate[i].portraitColor, 1)
	draw_sprite_ext(spr_portraitContainerLower, 0, portraitX[i] - portraitBuffer, portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, c_white, 1)
	
	draw_sprite_ext(spr_actionHealthbarBacking, 0, portraitX[i], portraitY[i], -myPortraitScale[i], myPortraitScale[i], 0, global.RESOURCE_BAR_BACKING, 1);
	draw_sprite_part_ext(spr_actionHealthBar, 0, 0, 0, mate[i].LIFEspriteWidth * mate[i].LIFEPercent, mate[i].LIFEspriteHeight, portraitX[i], portraitY[i], -myPortraitScale[i], myPortraitScale[i], global.LUCID_GREEN, 1);
	draw_sprite_ext(spr_actionMPBar, 0, portraitX[i], portraitY[i] - ((mate[i].MPspriteHeight * myPortraitScale[i]) + 1), -myPortraitScale[i], myPortraitScale[i], 0, global.RESOURCE_BAR_BACKING, 1)
	draw_sprite_part_ext(spr_actionMPBar, 0, 0, 0, mate[i].MPspriteWidth * mate[i].MPPercent, mate[i].MPspriteHeight, portraitX[i], portraitY[i] - ((mate[i].MPspriteHeight * myPortraitScale[i]) + 1), -myPortraitScale[i], myPortraitScale[i], global.CYAN, 1);


}

//draw the currently controlled characters name 
var nameScaleX = 1
var nameScaleY = 0.5 
draw_text_ext_transformed_color(portraitX[0] + 1, portraitY[0] + sprite_get_height(mate[0].MYLIFEBAR) + 4.5, mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0, global.LUCID_GREEN, global.LUCID_GREEN, global.LUCID_GREEN, global.LUCID_GREEN, 1)
draw_text_ext_transformed_color(portraitX[0] + 1, portraitY[0] + sprite_get_height(mate[0].MYLIFEBAR) + 4, mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0, c_black, c_black, c_black, c_black, 1)
draw_text_ext_transformed(portraitX[0] + 1, portraitY[0] + (sprite_get_height(mate[0].MYLIFEBAR) + 1), mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0)
