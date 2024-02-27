haxis = gamepad_axis_value(0, gp_axislh);
vaxis = gamepad_axis_value(0, gp_axislv);
#region PORTRAIT COLOR CONTROL
portraitAddVal = lerp(portraitAddVal, 0, 0.3)
redValue = lerp(redValue, 255, 0.2)
greenValue = lerp(greenValue, 255, 0.2)
blueValue = lerp(blueValue, 255, 0.2)
portraitColor = make_color_rgb(redValue, greenValue, blueValue)
#endregion
sprite_index = currentSprite
camX = camera_get_view_x(view_camera[0])
camY = camera_get_view_y(view_camera[0])
camWidth = camera_get_view_width(view_camera[0])
camHeight= camera_get_view_height(view_camera[0])
distanceFromLeaderX = (global.CURRENTLY_CONTROLLED_CHARA.x + x)
distanceFromLeaderY = (global.CURRENTLY_CONTROLLED_CHARA.y + y)
indicatorBuffer  = 15 
distanceFromCamX = x - camX 
distanceFromCamY = y - camY





if place_meeting(x, y, SLOPE_LEFT_FACING) or place_meeting(x, y, SLOPE_LEFT_FACING_TRI)
{
	var slopeId = instance_place(x, y, SLOPE_LEFT_FACING)
	if movingHorizontally { y += ((MYMOVEMENTSPEED/2) * haxis)  }	
}

if place_meeting(x, y, SLOPE_RIGHT_FACING) or place_meeting(x, y, SLOPE_RIGHT_FACING_TRI)
{
	var slopeId = instance_place(x, y, SLOPE_RIGHT_FACING)
	if movingHorizontally { y -= ((MYMOVEMENTSPEED/2) * haxis) }	
}

if x > (camX + camWidth) or x < camX { offscreen = 1 }
if y > (camY + camHeight) or y < camY { offscreen = 1 }
if x < (camX + camWidth) && x > camX && y < (camY + camHeight) && y > camY { offscreen = 0 } 

if jumpValue > 0 { jumpValue -= (jumpValue) } 
y -= jumpValue

switch(flag)
{
	
	#region RUNNING AROUND AND SHIT
	//case -5:
	//	if movingHorizontally = 0 && movingVertically = 0 { stationary = 1 } else { stationary = 0 }  
	//	currentSprite = spr_worm
	//	if stationary != 0 { image_speed = 0 } else { image_speed = 0.5 if !audio_is_playing(sfx_worming) audio_play_sound(sfx_worming, 2000, false)}
	//	switch(facingDirection)
	//	{
	//		case LEFT:
	//			image_xscale = -1
	//			
	//		break;
	//		
	//		case RIGHT:
	//			image_xscale = 1
	//		break;
	//	}
	//	
	//break;
	case 0:
	
	switch(stationary)
	{	
		//YOU ARE NOT STATIONARY
		case 0:
		
		break;
		
		//YOU ARE STATIONARY 
		case 1:
		//cycleRate = baseCycleRate
		//currentSprite = idleSprite
		break;
	}
	OCCUPIED = 0
	//groundChecker.flag = 0
	
	canCancel = 0
	velocityFlag = 0
	spriteFlag = 0
	moveIndex = 0
	if image_number = 1 { image_index = 0 } else { image_speed = global.imageCycleRate }
	
	break;
	#endregion
	
	#region ATTACKING
	//ATTACKING ON GROUND
	case 1:
	if MYTARGET != undefined
	{
		if MYTARGET.x < x { facingDirection = LEFT }
		if MYTARGET.x > x { facingDirection = RIGHT}
	}
	while MOVE_INSTANCE_SPAWNBUFFER = 0 { 
		var ATTACK = instance_create_layer(x, y, "Instances", GROUND_COMBO[moveIndex].INSTANCE) 
		with ATTACK {
			MY_PARENT = global.CURRENTLY_CONTROLLED_CHARA
			NAME = other.GROUND_COMBO[other.moveIndex].NAME	
		}
		if moveIndex != array_length(GROUND_COMBO) { moveIndex++ canCancel = 0 image_index = 0 }
		MOVE_INSTANCE_SPAWNBUFFER = 1 
	}
	
	//switch(canCancel) { case 1: if moveIndex != moveLimit { scr_actionMoveReset() } break; }
	//if _attack
	//{
	//	
	//	
	//	
	//	
	//}
	//if combo[moveIndex].yLurch != 0 { onGround = 0 }
	//ANIMATION CANCELLING
	//if moveIndex != moveLimit {	if image_index >= combo[moveIndex].targetFrame { canCancel = 1 } }
	//																								//if image_index >= combo[moveIndex].targetFrame { canCancel = 1 OCCUPIED = 0} else { canCancel = 0 OCCUPIED = 1 }
	//image_speed = global.imageCycleRate
	//spriteFlag = 1
	//currentSprite = combo[moveIndex].sprite;
	//		switch(image_index)
	//			{	
	//				case combo[moveIndex].targetFrame:
	//				while velocityFlag = 0 {
	//						
	//					switch(facingDirection)
	//					{
	//						case LEFT:
	//						if MYTARGET = undefined {
	//							horizAddVal -= combo[moveIndex].xLurch
	//						}
	//						if MYTARGET != undefined {
	//							horizAddVal += targetDistanceX/2
	//							vertAddVal  += targetDistanceY/2
	//						}
	//						var hitbox = instance_create_layer(x - sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionHitbox)
	//						hitbox.damage = MYPOWER
	//						//hitbox.image_xscale = combo[moveIndex].hitScale
	//						//hitbox.image_yscale = combo[moveIndex].hitScale
	//						hitbox.parent = self
	//						break;
	//	
	//						case RIGHT:
	//						if MYTARGET = undefined {
	//							horizAddVal += combo[moveIndex].xLurch
	//						}
	//						if MYTARGET != undefined {
	//							horizAddVal += targetDistanceX/2
	//							vertAddVal  += targetDistanceY/2
	//						}
	//						var hitbox = instance_create_layer(x + sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionHitbox)
	//						hitbox.damage = MYPOWER
	//						//hitbox.image_xscale = combo[moveIndex].hitScale
	//						//hitbox.image_yscale = combo[moveIndex].hitScale
	//						hitbox.parent = self
	//						break;
	//					}
	//				velocityFlag = 1
	//			}
	//	break;
	//}
	//
	//switch(spriteFlag)
	//{
	//	case 1:
	//	switch(onGround)
	//	{
	//		case 0:
	//		
	//		break;
	//		
	//		case 1:
	//		if image_index = image_number - 1
	//		{
	//			flag = 0
	//		}
	//		break;
	//	}
	//	
	//	break;
	//}
	break;
	#endregion
	
	#region ROLLING
	case 2:
	cycleRate = global.imageCycleRate
	OCCUPIED = 1
	stationary = 0
	spriteFlag = 1
	currentSprite = spr_frameManRoll
	
	switch(spriteFlag)
	{
		case 1:
		if image_index = image_number - 1 { flag = 0 }
		break;
	}
	break;
	#endregion
	
	#region GUARDING
	case 3:
	spriteFlag = 1
	currentSprite = spr_frameManBlock
	if image_index >= sprite_get_number(sprite_index) - 8 { canCancel = 1 OCCUPIED = 0} else { canCancel = 0 OCCUPIED = 1 }
	image_speed = global.imageCycleRate
	switch(spriteFlag)
	{
		case 1:
		if image_index = image_number - 1 { flag = 0 }
		break;
	}
	break;
	
	#endregion
	
	#region JUMPING
	case 4:
	onGround = 0
	spriteFlag = 1
	currentSprite = jumpSprite
	switch(fallFlag)
	{
		case 0: 
		y -= velocity velocity -= myGravity
		if velocity <= 0 { velocity = 0  fallFlag = 1 }
		break;
		
		case 1:
		if gravityFlag = 0
			{
				y += velocity
				if velocity < maximumVelocity  { velocity += myGravity } 
				if velocity >= maximumVelocity { velocity = maximumVelocity fallFlag = 0 flag = 0  onGround = 1 }	
			}
		break;
	}
	switch(spriteFlag)
	{
		case 1: if image_index = image_number - 1 { image_speed = 0 } else { image_speed = global.imageCycleRate } break;
	}
	break;
	#endregion
	
	#region ATTACKING MIDAIR
	case 5:
	//ATTACKING MIDAIR
	y -= velocity
	if velocity > jumpHeight { velocity -= myGravity } 
	if velocity <= jumpHeight { velocity = jumpHeight fallFlag = 0 flag = 0  onGround = 1 veloAddBuffer = 0}	
	if _attack
	{
		switch(canCancel)
		{
			case 1: if moveIndex != moveLimit {	scr_actionMoveReset() } break;
		}
	}
		currentSprite = airCombo[moveIndex].sprite;
		if moveIndex != moveLimit {	if image_index >= airCombo[moveIndex].targetFrame { canCancel = 1 } }
			switch(image_index)
				{	
					case airCombo[moveIndex].targetFrame:
					while velocityFlag = 0 {
						var finalVolHoriz = (airCombo[moveIndex].xLurch)
						var finalVolVert = (airCombo[moveIndex].yLurch)
						switch(facingDirection)
						{
							case LEFT:
							horizAddVal -= finalVolHoriz
							velocity -= finalVolVert
							var hitbox = instance_create_layer(x - (airCombo[moveIndex].hitBoxX + sprite_get_width(sprite_index)), y + airCombo[moveIndex].hitBoxY, "Instances", obj_actionHitbox)
							hitbox.image_xscale = airCombo[moveIndex].hitScale
							hitbox.image_yscale = airCombo[moveIndex].hitScale
							hitbox.parent = self
							break;
		
							case RIGHT:
							horizAddVal += finalVolHoriz
							velocity -= finalVolVert
							var hitbox = instance_create_layer(x + (airCombo[moveIndex].hitBoxX + sprite_get_width(sprite_index)), y + airCombo[moveIndex].hitBoxY, "Instances", obj_actionHitbox)
							hitbox.image_xscale = airCombo[moveIndex].hitScale
							hitbox.image_yscale = airCombo[moveIndex].hitScale
							hitbox.parent = self
							break;
						}
						velocityFlag = 1
					}
					break;
				}
		switch(spriteFlag)
		{
			case 1: if image_index = image_number - 1 {  flag = 4 } break;
		}
	break;
	
	#endregion
}











//if place_meeting(x, y, obj_enemyProximityHitbox)
//{	
//	if addBuffer = 1 { addBuffer = 0 }
//	var _inst = instance_place(x, y, obj_enemyProximityHitbox)
//	var _enemyID = _inst.parent
//	while addBuffer = 0 { subtractionBuffer = 0 ds_list_add(enemiesInProximity, _enemyID) addBuffer = 1}	
//	addBuffer = 1
//}



