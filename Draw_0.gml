for(var i = 0; i < array_length(mate); i++)
{
	if mate[i].offscreen = 1 && mate[i] != global.CURRENTLY_CONTROLLED_CHARA
	{
		draw_line_width_color(mate[i].x, mate[i].y, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y, 2, mate[i].COLOR, global.CURRENTLY_CONTROLLED_CHARA.COLOR)
	}
	//draw_text(scr_GETVIEWX() + 200, scr_GETVIEWY() + 20 + (20 * i), "MEMBER @ INDEX " + string(i) + " " + string(mate[i]))
}

menuStarX = scr_GETVIEWX() + ((sprite_get_width(spr_UISTAR)/2) - 36)
itemIconX = scr_GETVIEWX() + ((sprite_get_width(MENU[i].SPRITE)/2) + 110) + itemIconOffset
itemIconY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - sprite_get_height(MENU[i].SPRITE)/2)
menuStarY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - (sprite_get_height(spr_UISTAR)/2) + 18)
//var lifePercent = (dummyHealth/dummyHealthMax) * 100
//draw_sprite_part_ext(spr_PORTRAIT_BATTLE_KINOPUNCH, 0, 0, 0, lifePercent, sprite_get_height(spr_PORTRAIT_BATTLE_KINOPUNCH), scr_GETVIEWX() + 170, scr_GETVIEWY() + 100, -1, 1, c_white, 1)

draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 60, "HAXIS " + string(haxis))
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 80, "VAXIS " + string(vaxis))

finalStarRotation = lerp(finalStarRotation, 0, 0.5)
draw_sprite_ext(MENU[actionMenuIndex].SPRITE, 0, itemIconX, itemIconY, 1, 1, 0, MENU[actionMenuIndex].COLOR, random_range(0.05, 0.15))
//draw_sprite_ext(spr_UISTAR, 0, menuStarX, menuStarY, -1, 1, 0, MENU[actionMenuIndex].COLOR, 0.2 + (sin(floatIter) * 0.05))
draw_sprite_ext(spr_UISTAR, 0, menuStarX, menuStarY, 1, 1, finalStarRotation, MENU[actionMenuIndex].COLOR, 1)

//draw_text(global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y, starRotationAddition)
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

draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 120, string(color_get_red(MENU[actionMenuIndex].COLOR)))
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 140, actionMenuIndex)

var sandwichBuffer1 = 2
var sandwichBuffer2 = 2.5

menuSlotIter += menuSlotIterSpeed

for(var i = 0; i < array_length(MENU); i++)
{
	draw_set_font(desiredFont)
	var baseColor = c_white
	var baseUnderColor = c_grey
	var highlightUnderColor = c_green
	var highlightColor = global.LUCID_GREEN
	var col
	var col2 = c_black
	
	//var colorOffset			= 5
	//var desiredColorRed		= color_get_red(MENU[i].COLOR)		//- colorOffset
	//var desiredColorBlue	= color_get_blue(MENU[i].COLOR)		//- colorOffset
	//var desiredColorGreen	= color_get_green(MENU[i].COLOR)	//- colorOffset
	//var underColor			= make_color_rgb(desiredColorRed, desiredColorGreen, desiredColorBlue)
	var underSlotBuffer		= 0 
	var sinBuffer 
	
	if i == actionMenuIndex {
		col = MENU[i].COLOR
		horizontalBuffer = 35
		elementScale = 1
		sinBuffer = sin(menuSlotIter) * 0.5
		//draw_text_ext_transformed_color(MENUX[i] - 35, MENUY[i], MENU[actionMenuIndex].NAME, 10, 1000, elementScale, elementScale, 0, col, col, col, col, 0.1)	
		//draw_text_ext_transformed_color(MENUX[i] - 15, MENUY[i], MENU[actionMenuIndex].NAME, 10, 1000, elementScale, elementScale, 0, col, col, col, col, 0.3)	
		//draw_line_width_color(menuStarX, menuStarY, MENUX[i], MENUY[i], 2, global.LUCID_GREEN, global.LUCID_GREEN)
	} else { 
		elementScale = 1
		col = c_white
		horizontalBuffer = 0
		randomOffset = 0
		sinBuffer = 0
	}
	var slotBufferHorizontal = 4
	var slotBufferVertical	 = 1
	//draw_sprite_ext(spr_battleMenuCommandSlot, 0, (MENUX[i] - slotBufferHorizontal) + 4 + sinBuffer, MENUY[i] - slotBufferVertical, (string_width(MENU[i].NAME)/2) + slotBufferHorizontal, (string_height(MENU[i].NAME)/3) + slotBufferVertical, 0, col, 1)
	//draw_sprite_ext(spr_battleMenuCommandSlot, 0, (MENUX[i] - slotBufferHorizontal) + sinBuffer, MENUY[i] - slotBufferVertical, (string_width(MENU[i].NAME)/2) + slotBufferHorizontal, (string_height(MENU[i].NAME)/3) + slotBufferVertical, 0, col, 1)
	//var slotEndBuffer = (string_width(MENU[i].NAME)) + slotBufferHorizontal
	//draw_sprite_ext(spr_battleMenuCommandSlotEnd, 0, (MENUX[i] + (slotEndBuffer + 4)) + sinBuffer, MENUY[i] - slotBufferVertical, 1, 1, 0, col, 1)
	//draw_sprite_ext(spr_battleMenuCommandSlotEnd, 0, (MENUX[i] + slotEndBuffer) + sinBuffer, MENUY[i] - slotBufferVertical, 1, 1, 0, col, 1)
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i] + 2.5, MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, MENU[i].COLOR, MENU[i].COLOR, MENU[i].COLOR, MENU[i].COLOR, 1)
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i] + 2, MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, col2, col2, col2, col2, 1)	
	draw_text_ext_transformed_color((MENUX[i]) + sinBuffer, MENUY[i], MENU[i].NAME, 10, 1000, elementScale, elementScale, 0, col, col, col, col, 1)	
	
	//draw_sprite_ext(spr_actionMenuRow, 0, MENUX[i], MENUY[i], string_width(MENU[i].NAME)/3, string_height(MENU[i].NAME)/3, 0, c_white, 1)

}
actionX = scr_GETVIEWX() + actionAnchorX
actionY = scr_GETVIEWY() + actionAnchorY
draw_set_font(fontKHGummi)
draw_text_ext_transformed_color(actionX, actionY, "ACTION", 10, 1000, 1, 0.5, 0, c_white, c_white, c_white, c_white, 1)
fadeTextOffset += 0.1
if fadeTextOffset >= 35 { fadeTextOffset = 0}
var fadeTextPercent = (fadeTextOffset * 35)/100
fadeTextAlpha = 1/fadeTextPercent

draw_sprite(spr_arrowbottom, 0, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y - (sprite_get_height(global.CURRENTLY_CONTROLLED_CHARA.sprite_index) + sin(floatIter)))

//GET THE TILE CURRENTLY BEING STOOD ON
//var lay_id = layer_get_id("Tiles_1");
//var map_id = layer_tilemap_get_id(lay_id);
//var data = tilemap_get_at_pixel(map_id, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y);
//data = tile_set_flip(data, true);
//tilemap_set_at_pixel(map_id, data, global.CURRENTLY_CONTROLLED_CHARA.x, global.CURRENTLY_CONTROLLED_CHARA.y);
//draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 10, data
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 10, global.CURRENTLY_CONTROLLED_CHARA.NAME)
draw_text(scr_GETVIEWX() + 10, scr_GETVIEWY() + 30, CONTROL_INDEX)

initialPortraitX = scr_GETVIEWX() + (camera_get_view_width(view_camera[0]) - 10)
initialPortraitY = scr_GETVIEWY() + (camera_get_view_height(view_camera[0]) - 35)



//for(var i = 0; i < array_length(mate); i++)
//{
//	
//	if i = 0 { scaleMultiplier = 1 } 
//	if i > 1 { scaleMultiplier = 0.5} 
//	verticalBuffer = (sprite_get_height(mate[i].currentPortrait) * scaleMultiplier)
//	
//	portraitX[i]		= initialPortraitX	
//	portraitY[i]		= initialPortraitY - (verticalBuffer * i)
//	myPortraitScale[i]	= 1 * scaleMultiplier
//}

//portraitX[0] = initialPortraitX
//portraitX[1] = portraitX[0]
//portraitX[2] = portraitX[1]

//portraitY[0] = initialPortraitY 
//portraitY[1] = portraitY[0] - 124
//portraitY[2] = portraitY[1] - 62

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
font_get_size(myFont)
var nameScaleX = 1
var nameScaleY = 0.5 
draw_text_ext_transformed_color(portraitX[0] + 1, portraitY[0] + sprite_get_height(mate[0].MYLIFEBAR) + 4.5, mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0, global.LUCID_GREEN, global.LUCID_GREEN, global.LUCID_GREEN, global.LUCID_GREEN, 1)
draw_text_ext_transformed_color(portraitX[0] + 1, portraitY[0] + sprite_get_height(mate[0].MYLIFEBAR) + 4, mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0, c_black, c_black, c_black, c_black, 1)
draw_text_ext_transformed(portraitX[0] + 1, portraitY[0] + (sprite_get_height(mate[0].MYLIFEBAR) + 1), mate[0].NAME, 10, 1000, nameScaleX, nameScaleY, 0)