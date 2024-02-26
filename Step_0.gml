draw_set_font(fontKHGummi)

STATS[9] = synchroBaseScale
#region INPUT
_left = keyboard_check(vk_left) 
_right = keyboard_check(vk_right) 
_up = keyboard_check(vk_up)
_down = keyboard_check(vk_down)
_attack = keyboard_check_pressed(ord("X")) or global._buttA
_roll = keyboard_check_pressed(ord("Z")) or global._buttX
_jump = keyboard_check_pressed(ord("C")) or global._buttB 
_lockOn = keyboard_check_pressed(ord("V")) or global._shoulderL
_focusHeal = global._buttYHold
_memberSwitch = global._shoulderR

_powerSacrifice = global._upDpadTap
_lifeSacrifice = global._downDpadTap
_lucidSacrifice = global._leftDpadTap
_defenseSacrifice = global._rightDpadTap

_chooseMember0 = global._upDpadTap
_chooseMember1 = global._rightDpadTap
_chooseMember2 = global._downDpadTap
_chooseMember3 = global._leftDpadTap



#endregion 

#region PAUSE MENU
if global._gpStart 
{
	switch(menuFlag)
	{
		case 0: break;
		case 1: break;
	}
}
{
//if !instance_exists(obj_actionMenu)
//	{ 
//		instance_create_layer(scr_GETVIEWX(), scr_GETVIEWY(), "OVERLAY", obj_actionMenu)
//	} 
}
#endregion

dpadX = global.CURRENTLY_CONTROLLED_CHARA.x
dpadY = global.CURRENTLY_CONTROLLED_CHARA.y + 50
shieldScale = lerp(shieldScale, 0, 0.3)
flameScale  = lerp(flameScale, 0, 0.3)
heartScale = lerp(heartScale, 0, 0.3)
swordScale  = lerp(swordScale, 0, 0.3)
dpadAddValue = lerp(dpadAddValue, 0, 0.4)


synchroPercent = (synchroAmplitude2*2)/100
if synchroAmplitude2 < 4
{
	if synchroBaseScale < 6 { synchroBaseScale += 0.01 }	
} else {
	if synchroBaseScale > 2 { synchroBaseScale -= 0.01 } 	
}

//STATS[0] = "SACRIFICE MENU DISMISSAL BUFFER " + string(sacrificeMenuDismissBuffer) + " SACRIFICE BUFFER " + string(sacrificeBuffer)
//STATS[1] = "PARTY MENU DISMISSAL BUFFER " + string(partyMenuDismissBuffer) + " CHARA SWITCH BUFFER " + string(charaSwitchBuffer)
//STATS[2] = "BUMPER CHOICE FLAG " + string(bumperChoiceFlag)
//STATS[3] = "FOCUSHEAL FLAG " + string(focusHealFlag)
//STATS[4] = synchroAmplitude 
//STATS[5] = synchroAmplitude2
//STATS[6] = synchroIterSpeed 
//STATS[7] = synchroIter2Speed
//STATS[8] = synchroBaseScale
//STATS[9] = synchroPercent
//if MYTARGET = undefined {
//	targetPointX = x
//	targetPointY = y
//}
//
//if MYTARGET != undefined {
//	targetPointY = MYTARGET.y
//	if x > MYTARGET.x {
//		targetPointX = MYTARGET.x + ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
//	} else {
//		targetPointX = MYTARGET.x - ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
//	}	
//	targetDistanceX = targetPointX - x
//	targetDistanceY = targetPointY - y
//	//RELEASE HARD TARGET IF IN PROXIMITY TO ENEMIES BUT NOT IN PROXIMITY TO PREVIOUS TARGET
//	//IF STILL IN RANGE OF ENEMIES BUT NOT YOUR TARGETED ONE THEN RELEASE TARGET TOGGLE
//	if distance_to_object(obj_actionEnemyParent) < enemyProximity && distance_to_object(MYTARGET) > enemyProximity 
//	{ 
//		 MYTARGET = undefined 
//		 lockOnToggle = 0
//		 scr_playSFX(sfx_LOCKOFF, 2000, false)
//		 with obj_cameraZoomer { flag = -1 }
//	}
//	if distance_to_object(obj_actionEnemyParent) > enemyProximity && distance_to_object(MYTARGET) > enemyProximity 
//	{
//		MYTARGET = undefined 
//		lockOnToggle = 0
//		scr_playSFX(sfx_LOCKOFF, 2000, false)
//		with obj_cameraZoomer { flag = -1 }	
//	}
//}

//if global._buttAHold { if chargeValue < maxChargeValue { chargeValue += 1 } } else { chargeValue = 0 }

if global._bumperL
{
	
    bumperChoiceFlag = 1
	sacrificeMenuDismissBuffer = 0
	if _powerSacrifice 
	{ 
		while sacrificeBuffer = 0  { scr_actionSacrifice("POWER", sacrificeAmount) sacrificeBuffer = 1 }
		swordScale += 0.6
		sacrificeBuffer = 0
	}
	if _lifeSacrifice 
	{ 
		while sacrificeBuffer = 0  { scr_actionSacrifice("LIFE", sacrificeAmount) sacrificeBuffer = 1 }
		heartScale += 0.6
		sacrificeBuffer = 0
	}
	if _defenseSacrifice 
	{ 
		while sacrificeBuffer = 0  { scr_actionSacrifice("DEFENSE", sacrificeAmount) sacrificeBuffer = 1 }
		shieldScale += 0.6
		sacrificeBuffer = 0
	}
	if _lucidSacrifice 
	{ 
		while sacrificeBuffer = 0  { scr_actionSacrifice("LUCID", sacrificeAmount) sacrificeBuffer = 1 }
		flameScale += 0.6
		sacrificeBuffer = 0
	}
}
if global._bumperR
{
	bumperChoiceFlag = 2
	partyMenuDismissBuffer = 0
	if _chooseMember0 
	{ 
	//	if memberIndex != 0 {
			while charaSwitchBuffer = 0  { obj_cameraZoomer.flag = 0 scr_playSFX(sfx_powerMoveBacking, 200, false) alarm[6] += obj_cameraZoomer.retractionTime charaSwitchBuffer = 1 }
			//swordScale += 0.6
			charaSwitchBuffer = 0
	//	}
	}
	//if _chooseMember1 && actionPartyMembers[1] != undefined && array_length(actionPartyMembers) >= 2
	//{ 
	//	if memberIndex != 1 {
	//		while charaSwitchBuffer = 0  { scr_actionCharaSwap(1) charaSwitchBuffer = 1 }
	//		//heartScale += 0.6
	//		charaSwitchBuffer = 0
	//	}
	//}
	//if _chooseMember2 && actionPartyMembers[2] != undefined && array_length(actionPartyMembers) >= 3 
	//{ 
	//	if memberIndex != 2 {
	//		while charaSwitchBuffer = 0  { scr_actionCharaSwap(2) charaSwitchBuffer = 1 }
	//		//shieldScale += 0.6
	//		charaSwitchBuffer = 0
	//	}
	//}
	//if _chooseMember3 && actionPartyMembers[3] != undefined && array_length(actionPartyMembers) >= 4 
	//{ 
	//	if memberIndex != 3 {
	//		while charaSwitchBuffer = 0  { scr_actionCharaSwap(3) charaSwitchBuffer = 1 }
	//		charaSwitchBuffer = 0
	//	}
	//}
}

//if _focusHeal && !OCCUPIED or canCancel = 1 { starFlag = 1 focusHealFlag = 1 } else { if starFlag = 1 { starFlag = 0 }focusHealFlag = 0 }
//switch(focusHealFlag)
//{
//	case 0:
//		
//	break;
//	
//	case 1:
//		if global.currentActor.CURRENTLIFE + 0.1 < global.currentActor.MAXLIFE { global.currentActor.CURRENTLIFE += 0.1} else { global.currentActor.CURRENTLIFE = global.currentActor.MAXLIFE }
//		if global.currentActor.CURRENTLIFE >= global.currentActor.MAXLIFE 
//		{
//			if global.currentActor.CURRENTOVERHEAL + 0.1 < global.currentActor.MAXOVERHEAL { global.currentActor.CURRENTOVERHEAL += 0.1 } else { global.currentActor.CURRENTOVERHEAL = global.currentActor.MAXOVERHEAL}
//		}
//	break;
//}

switch(bumperChoiceFlag)
{	
	case 1:
		if keyboard_check_released(global._bumperL) 
		{ 
			while sacrificeMenuDismissBuffer = 0 
			{ scr_playSFX(sfx_menuDismiss, 500, false) sacrificeMenuDismissBuffer = 1 }
			dpadAddBuffer = 0 dpadAddValue = 0 sacrificeBuffer = 0  
			if partyMenuDismissBuffer != 1 { partyMenuDismissBuffer = 1 }
		}
	break;
	
	case 2:
	if keyboard_check_released(global._bumperR) 
	{ 
		while partyMenuDismissBuffer = 0
		{ scr_playSFX(sfx_menuDismiss, 500, false) partyMenuDismissBuffer = 1 }
		dpadAddBuffer = 0 dpadAddValue = 0 charaSwitchBuffer = 0
		if sacrificeMenuDismissBuffer != 1 { sacrificeMenuDismissBuffer = 1 }
	}
	break;
}



//if global._shoulderL { 
//	if TARGETINDEX < ds_list_size(enemiesInProximity) 
//	{ 
//		TARGETINDEX++	
//	}	else {
//		TARGETINDEX = 0
//	}	
//}




//sprite_index = currentSprite
//vertAddVal = lerp(vertAddVal, 0, speedLossRate)
//horizAddVal = lerp(horizAddVal, 0, speedLossRate)
//horizRollSpeed = lerp(horizRollSpeed, 0, rollLossRate)
//vertRollSpeed = lerp(vertRollSpeed, 0, rollLossRate)
//impactScale = lerp(impactScale, 4, 0.3)
//impactAlpha = lerp(impactAlpha, 0, 0.05)
//speed = lerp(speed, 0, 0.3)
//yspd = (yspd) + vertAddVal
//xspd = (xspd) + horizAddVal
//finalXAddValue = (xspd + horizRollSpeed + horizAddVal)
//finalYAddValue = (yspd + vertRollSpeed + vertAddVal)
//x = x + finalXAddValue
//y = y + finalYAddValue

floatIter += floatIterSpeed 


//if jumpAmt > 0 { jumpAmt = jumpAmt - (1 * weight) }

switch(onGround)
{
	case 0:
		
	break;
	
	case 1:
		
	break;
}


//if velocity > -10 
//{
//	onGround = 0	
//}

//if _jump {
//	if flag = 0 or canCancel { image_index = 0 flag = 4 } 
//}
//if !_jump {
//	velocity = -10	
//}
//if !_jump {
	//while peakBuffer = 0 { peakBuffer = jumpAmt peakBuffer = 1}
//	if peakAmt < 0 { peakAmt ++}
//	y = y + peakAmt
//	if jumpAmt < 0 { jumpAmt ++ }
//}


#region BASE MOVEMENT
//switch(global.usingGamepad)
//{
//	case 0:
//		if !_up && !_down 
//		{
//			
//		}	
//	break;
//	
//	case 1:
//
//	var haxis = gamepad_axis_value(0, gp_axislh);
//	var vaxis = gamepad_axis_value(0, gp_axislv);	
//	
//	switch(OCCUPIED)
//	{
//		case 0:
//		//GOING DOWNWARDS
//		if vaxis > global.deadZoneAmt { global.currentActor.y += vaxis * global.currentActor.moveSpd } 
//		//GOING UPWARDS
//		if vaxis < -global.deadZoneAmt{ global.currentActor.y -= -(vaxis * global.currentActor.moveSpd) }
//		//GOING RIGHT
//		if haxis > global.deadZoneAmt { global.currentActor.x += (haxis * global.currentActor.moveSpd) global.currentActor.facingDirection = RIGHT }
//		//GOING LEFT
//		if haxis < -global.deadZoneAmt{ global.currentActor.x -= -(haxis * global.currentActor.moveSpd) global.currentActor.facingDirection = LEFT }
//		break;
//		
//		case 1:
//		
//		break;
//	}
//	if vaxis > -global.deadZoneAmt && vaxis < global.deadZoneAmt { global.currentActor.movingVertically = 0 } else { global.currentActor.movingVertically = 1 }
//	if haxis > -global.deadZoneAmt && haxis < global.deadZoneAmt { global.currentActor.movingHorizontally = 0 } else { global.currentActor.movingHorizontally = 1 }
//	if global.currentActor.movingHorizontally = 0 && global.currentActor.movingVertically = 0 { global.currentActor.stationary = 1 } else { global.currentActor.stationary = 0 }  
//	break;
//}
//if !_up && !_down && !_left && !_right 
//{
//	lastKey = -1
//	xspd = 0
//	yspd = 0
//}	
//if _up
//{
//	lastKey = 0
//
//	switch(flag)
//	{
//		case 0:
//			if !place_meeting(x, y - (yspd + runSpd), obj_wall) && !place_meeting(x, y - (yspd + runSpd), obj_actionEnemyParent) { y -= (moveSpd + runSpd) }
//		break;
//	}
//}
//
//if _down
//{
//	lastKey = 2
//	switch(flag)
//	{
//		case 0:
//			if !place_meeting(x, y + (yspd + runSpd), obj_wall) && !place_meeting(x, y + (yspd + runSpd), obj_actionEnemyParent) { y += (moveSpd) + runSpd }			
//		break;
//	}
//}
//
//if _left
//{
//	lastKey = 3
//	facingDirection = LEFT
//	switch(flag)
//	{
//		case 0:
//			if !place_meeting(x - (xspd + runSpd), y, obj_wall) && !place_meeting(x - (xspd + runSpd), y, obj_actionEnemyParent) { x -= (moveSpd) + runSpd }	
//		break;
//	}
//}
//
//if _right
//{
//	facingDirection = RIGHT
//	lastKey = 1
//	switch(flag)
//	{
//		case 0:
//			if !place_meeting(x + 1, y, obj_wall) && !place_meeting(x + 1, y, obj_actionEnemyParent) { x += (moveSpd) + runSpd }	
//		break;
//	}
//}

//if _roll
//{
//	if flag = 0 or canCancel = 1 {
//			image_index = 0
//			switch(global.usingGamepad)
//			{
//				case 0:
//					switch(facingDirection)
//					{
//						case UP:	vertRollSpeed += -rollAmt	break;
//						case DOWN:	vertRollSpeed += rollAmt	break;
//						case LEFT:	break;
//						case RIGHT: break;
//					}
//				break;
//				
//				case 1:
//				var dir = point_direction(0, 0, haxis, vaxis);
//				var haxis = gamepad_axis_value(0, gp_axislh);
//				var vaxis = gamepad_axis_value(0, gp_axislv);
//				if global._downDpad { vertRollSpeed += rollAmt }
//				if global._upDpad { vertRollSpeed += -rollAmt }
//				if global._rightDpad { horizRollSpeed += rollAmt }
//				if global._leftDpad { horizRollSpeed += -rollAmt }
//				
//				if haxis > global.deadZoneAmt { flag = 2 horizRollSpeed += rollAmt } 
//				if haxis < -global.deadZoneAmt{ flag = 2 horizRollSpeed += -rollAmt} 
//					//GUARDING
//					{
//						switch(facingDirection)
//						{
//						case RIGHT:
//						if haxis < global.deadZoneAmt && haxis > -global.deadZoneAmt
//						{ 
//							flag = 3 
//							alarm[0] += 5 	
//							myGuard = instance_create_layer(x + sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, 
//							"Instances", obj_actionBlock)
//						}
//						break;
//					
//						case LEFT:
//						if haxis < global.deadZoneAmt && haxis > -global.deadZoneAmt
//						{ 
//							flag = 3 
//							alarm[0] += 5 		
//							myGuard = instance_create_layer(x - sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2,
//							"Instances", obj_actionBlock)
//						}
//							break;
//						}
//					}
//				break;
//		}	
//	}
//}
#endregion


//if _attack {
//	
//	if flag = 0 or flag = 4 or canCancel = 1 && moveIndex != moveLimit {
//		if chargeValue  < 5 
//		{
//			image_index = 0
//				switch(onGround)
//				{	
//					case 0:
//					flag = 5
//					break;
//			
//					case 1:
//					flag = 1
//					break;
//				}
//		}
//		
//	}	
//}


//}




