draw_set_halign(fa_center)
draw_set_font(fontMach)
draw_text_ext_transformed_color(room_width/2, 7, "LUCIDSCAPE BATTLE MAKER", 1000, 1000, 1, 0.5, 0, c_grey, c_grey, c_grey, c_grey, 1)
draw_text_ext_transformed(room_width/2, 5, "LUCIDSCAPE BATTLE MAKER", 1000, 1000, 1, 0.5, 0)
draw_set_font(fontBinary)
//draw_text_ext_transformed(room_width/2, 35, "CHOOSE YOUR ACTORS", 1000, 1000, 1, 0.5, 0)
draw_set_font(fontMach)
//draw_text_ext_transformed(480, 70, "CHOOSE YOUR OPPONENTS", 1000, 1000, 0.5, 0.5, 0)
draw_set_halign(fa_left)

//draw_text_ext_transformed(10, 300, "MEMBER AMT = " + string(chosenMemIndex), 1000, 1000, 1, 0.5, 0)
//draw_text_ext_transformed(10, 330, "OPPONENT AMT = " + string(chosenOpponentIndex), 1000, 1000, 1, 0.5, 0)

//draw_text(10, 30, "ROW LIMIT = " + string(rowLimit))
//for(var i = 0; i < ds_list_size(global.heroDSList); i++)
//{
//	draw_sprite(global.heroDSList[|i].sprite, 0, memberX[i], 180)	
//}

//for(var i = 0; i < ds_list_size(global.enemyDSList); i++)
//{
//	draw_sprite(global.enemyDSList[|i].sprite, 0, 150 + (70 * i), 180)	
//}

for(var i = 1; i < array_length(boxX); i++)
{
	draw_sprite_ext(spr_textbox, 0, boxX[i], boxY[i], 1.5, 1.5, 0, c_white, 0.5)
}	

while setBuf = 0 {
	for(var i = 1; i < ds_list_size(global.heroDSList); i++)
		{
			var _tile = instance_create_layer(boxX[i], boxY[i], "OVERLAY", obj_battleMakerTile)	
			_tile.timesPicked = 0
			_tile.selected = 0
			_tile.myStruct = global.heroDSList[|i]
			_tile.myPort = global.heroDSList[|i].portrait
			_tile.myActor = global.heroDSList[|i].name
			_tile.myActorInstance = global.heroDSList[|i].myObject
			_tile.class = global.heroDSList[|i].class
			_tile.x = boxX[i] + instBuf
			_tile.y = boxY[i] + instBuf
			_tile.index = i
			ds_list_add(entityPool, _tile.id)
			heroOffset++
			
		}
	setBuf = 1
}

while enemyPopulateBuf = 0 {
		for(var k = 0; k < ds_list_size(global.enemyDSList); k++)
	{
		var _tile = instance_create_layer(boxX[heroOffset], boxY[heroOffset], "OVERLAY", obj_battleMakerTile)	
		_tile.timesPicked = 0
		_tile.selected = 0
		_tile.myStruct = global.enemyDSList[|k]
		_tile.myPort = global.enemyDSList[|k].portrait
		_tile.myActor = global.enemyDSList[|k].name
		_tile.myActorInstance = global.enemyDSList[|k].myObject
		_tile.class = global.enemyDSList[|k].class
		_tile.x = boxX[heroOffset] + instBuf
		_tile.y = boxY[heroOffset] + instBuf
		_tile.index = heroOffset	
		ds_list_add(entityPool, _tile.id)
		heroOffset++
	}
	enemyPopulateBuf = 1
}



for(var i = 1; i < array_length(boxX); i++)
{
	draw_sprite_ext(spr_textboxoverlay, 0, boxX[i], boxY[i], 1.5, 1.5, 0, c_white, 1)
}	

for(var i = 0; i < array_length(chosenHeros); i++)
{
	if chosenHeros[i] != undefined 
	{
		draw_sprite_ext(chosenHeros[i].sprite, 0, memX[i], memY, 2, 2, 0, c_white, 1)	
	}
}

for(var i = 0; i < array_length(chosenOpponents); i++)
{
	if chosenOpponents[i] != undefined 
	{
		draw_sprite_ext(chosenOpponents[i].sprite, 0, enemX[i], memY, 2, 2, 0, c_white, 1)	
	}
}

//for(var o = 0; o < array_length(global.enemyArray); o++)
//{
//	if global.enemyArray[o] != undefined {
//		draw_text_ext_transformed(200, 200 + (10 * o), "CHOSEN ENEMIES = " + string(global.enemyArray[o]), 10, 2000, 0.2, 0.2, 0)	
//	}
//}

//for(var o = 0; o < array_length(chosenHeros); o++)
//{
//	if chosenHeros[o] != undefined {
//	draw_text_ext_transformed(200, 200 + (10 * o), "CHOSEN HEROS = " + string(chosenHeros[o]), 10, 2000, 0.2, 0.2, 0)	
//	}
	
//for(var o = 0; o < array_length(global.partyMemberArray); o++)
//{
//	draw_text_ext_transformed(200, 200 + (30 * o), "MEM ARRAY = " + string(global.partyMemberArray[o]), 30, 2000, 0.2, 0.2, 0)	
//}
draw_set_font(fontBinary)
draw_text_ext_transformed(10, 340, "CUSTOM BATTLES WON = " + string(global.customBattlesWon), 10, 2000, 0.5, 0.5, 0)	
draw_text_ext_transformed(200, 340, "HERO NULL AMT = " + string(heroNullAmt), 10, 2000, 0.5, 0.5, 0)	
draw_text_ext_transformed(400, 340, "ENEM NULL AMT = " + string(enemyNullAmt), 10, 2000, 0.5, 0.5, 0)
draw_set_font(fontMach)

//for(var o = 0; o < ds_list_size(puckPool); o++)
//{
//	draw_text_ext_transformed(200, 200 + (10 * o), "ENTITIES = " + string(puckPool[|o]), 10, 2000, 0.2, 0.2, 0)	
//}
//for(var i = 0; i < array_length(enemyBoxX); i++)
//{
//	draw_sprite_ext(spr_textbox, 0, enemyBoxX[i], enemyBoxY[i], 1.5, 1.5, 0, c_white, 1)
//	draw_sprite_ext(spr_textboxoverlay, 0, enemyBoxX[i], enemyBoxY[i], 1.5, 1.5, 0, c_white, 1)
//}	