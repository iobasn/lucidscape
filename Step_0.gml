event_inherited()
#region INPUT
_left = keyboard_check(vk_left) 
_right = keyboard_check(vk_right) 
_up = keyboard_check(vk_up)
_down = keyboard_check(vk_down)
_attack = keyboard_check_pressed(ord("X")) or global._buttA
_roll = keyboard_check_pressed(ord("Z")) or global._buttX
_jump = keyboard_check_pressed(ord("C")) or global._buttB 
_lockOn = keyboard_check_pressed(ord("V")) or global._shoulderR
_powerSacrifice = global._upDpadTap
_lifeSacrifice = global._downDpadTap
_lucidSacrifice = global._leftDpadTap
_defenseSacrifice = global._rightDpadTap
_focusHeal = global._shoulderL
#endregion 

shadowPercent = (velocity*maximumVelocity)/100
distanceFromGround = maximumVelocity - velocity
distanceFromGroundPercent = (distanceFromGround*maxDistanceFromGround)/100

shadowOffset = distanceFromGround
#region STATS
//STATS[0] = "flag = " + string(flag)
//STATS[1] = "highlightedEnemy = " + string(highlightedEnemy)
//STATS[2] = "SHADOWOFFSET = " + string(shadowOffset)
//STATS[3] = "HORIZONTAL ROLL SPEED = " + string(horizRollSpeed)
//STATS[4] = "X SPEED VALUE = " + string(xspd)
//STATS[5] = "Y SPEED VALUE = " + string(yspd)
//STATS[6] = "FINAL X ADD VALUE = " + string(finalXAddValue)
//STATS[7] = "FINAL Y ADD VALUE = " + string(finalYAddValue)
//STATS[8] = "ENEMY INDEX = " + string(enemyIndex)
//STATS[9] = "LOCK ON TOGGLE = " + string(lockOnToggle)
//STATS[10] = "OCCUPIED = " + string(OCCUPIED)
//STATS[11] = "VELOCITY = " + string(velocity)
//STATS[12] = "STATIONARY? " + string(stationary)
#endregion 




vertAddVal = lerp(vertAddVal, 0, speedLossRate)
horizAddVal = lerp(horizAddVal, 0, speedLossRate)
horizRollSpeed = lerp(horizRollSpeed, 0, rollLossRate)
vertRollSpeed = lerp(vertRollSpeed, 0, rollLossRate)
impactScale = lerp(impactScale, 4, 0.3)
impactAlpha = lerp(impactAlpha, 0, 0.05)
targetReticleScale = lerp(targetReticleScale, 1, 0.3)
targetReticleRot = lerp(targetReticleRot, 0, 0.3)

//yspd += vertAddVal
//xspd += horizAddVal
finalXAddValue = (xspd + horizRollSpeed + horizAddVal)
finalYAddValue = (yspd + vertRollSpeed + vertAddVal)
floatIter += floatIterSpeed 
x += finalXAddValue
y += finalYAddValue
//sprite_index = currentSprite
speed = lerp(speed, 0, 0.3)



///COPIED OVER var haxis = gamepad_axis_value(0, gp_axislh);
///COPIED OVER var vaxis = gamepad_axis_value(0, gp_axislv);
///switch(stationary)
///{
///	case 0: direction = point_direction(0, 0, haxis, vaxis); break;
///	case 1: break;
///}




if distance_to_object(obj_actionEnemyParent) < obj_actionHandler.enemyProximity 
{ 
	inEncounter = 1
} else	{
	if lockOnToggle = 1 { scr_playSFX(sfx_LOCKOFF, 3400, false) } lockOnToggle = 0 TARGETSELECTBUFFER = 0
    MYTARGET = undefined inEncounter = 0 highlightedEnemy = undefined ds_list_clear(enemiesInProximity)
} 

//if instance_exists(obj_actionEnemyParent)
//	{
//		var dist = distance_to_object(obj_actionEnemyParent)
//		other.leaderDistance = dist
//	}
//}

if MYTARGET != undefined {
	//starX = lerp(starX, MYTARGET.x - (sprite_get_width(MYTARGET.sprite_index)), starLerpRate)
	//starY = lerp(starY, MYTARGET.y - (sprite_get_height(MYTARGET.sprite_index) + 5), starLerpRate)
	//distanceFromTarget = distance_to_object(MYTARGET)
	totalDistance = (distanceFromTarget/obj_actionHandler.enemyProximity) * 100
	
	targetPointY = MYTARGET.y
	if x > MYTARGET.x {
		targetPointX = MYTARGET.x + ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
	} else {
		targetPointX = MYTARGET.x - ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
		}	
	targetDistanceX = targetPointX - x
	targetDistanceY = targetPointY - y
}

//LOCKING ON
if _lockOn {
switch(inEncounter)
	{
		case 0: break;
		case 1:
		switch(lockOnToggle)
		{
			case 0:
				//IF CLOSE ENOUGH TO ENEMIES THEN YOU CAN LOCK ON
				if distance_to_object(obj_actionEnemyParent) < obj_actionHandler.enemyProximity 
				{ 
					if ds_list_size(enemiesInProximity) > 1 { lockOnToggle = 1 scr_playSFX(sfx_LOCKON, 3000, false) }
					if ds_list_size(enemiesInProximity) = 1 { if obj_actionEnemyParent.canTargetMe = 1 { lockOnToggle = 1 scr_playSFX(sfx_LOCKON, 3000, false) } } 
				}
			break;
			
			case 1:
				lockOnToggle = 0
				scr_playSFX(sfx_LOCKOFF, 3000, false)
			break;
		}
	
		break;
	}
}

#region LOCKON
switch(lockOnToggle)
{
	case 0:
		while cameraModeBuffer1 = 0 {
			with obj_cameraZoomer
			{
				flag = -1
				
			}
			cameraModeBuffer1 = 1
			cameraModeBuffer2 = 0
		}
		#region SHUFFLE ENEMY POSITIONS IN LIST DEPENDING ON THEIR DISTANCE FROM YOU. CLOSEST WILL BE AT THE TOP ALWAYS.
		for(var i = 0; i < ds_list_size(enemiesInProximity); i++)
		{
			if enemiesInProximity[|i].deathFlag = 1 { ds_list_delete(enemiesInProximity, i) }
			if i > 0
			{
				if enemiesInProximity[|i].myDistance < enemiesInProximity[|i - 1].myDistance
				{
					var temp = enemiesInProximity[|i + 1]
					enemiesInProximity[|i - 1] = enemiesInProximity[|i]
					enemiesInProximity[|i] = temp 
				}
			}
			if i < ds_list_size(enemiesInProximity) - 1
			{
				if enemiesInProximity[|i + 1].myDistance < enemiesInProximity[|i].myDistance
				{
					var temp = enemiesInProximity[|i]
					enemiesInProximity[|i] = enemiesInProximity[|i + 1]
					enemiesInProximity[|i + 1] = temp 
				}
			}
		}
		#endregion
		highlightedEnemy = enemiesInProximity[|0 + enemyIndex]
		enemyIndex = 0
	break
	
	case 1:
		while cameraModeBuffer2 = 0 {
			with obj_cameraZoomer
			{
				flag = 30	
			}
			cameraModeBuffer1 = 0
			cameraModeBuffer2 = 1
		}
		if !global._bumperL && !global._bumperR
		{	
			if global._rightDpadTap
			{ 
				if enemyIndex < ds_list_size(enemiesInProximity) - 1 { scr_playSFX(sfx_targetSwitch, 3000, false) targetReticleRot = 180 enemyIndex ++ MYTARGET = enemiesInProximity[|enemyIndex] } 
				else {scr_playSFX(sfx_targetSwitch, 3000, false) targetReticleRot = 180 enemyIndex = 0 MYTARGET = enemiesInProximity[|0] }
			}
			if global._leftDpadTap 
			{ 
				if enemyIndex != 0 {scr_playSFX(sfx_targetSwitch, 3000, false) targetReticleRot = -180 enemyIndex -- MYTARGET = enemiesInProximity[|enemyIndex] } 
				else {scr_playSFX(sfx_targetSwitch, 3000, false) targetReticleRot = -180 enemyIndex = ds_list_size(enemiesInProximity) - 1 MYTARGET = enemiesInProximity[|ds_list_size(enemiesInProximity) - 1] }
			}
		}
		if ds_list_size(enemiesInProximity) > 1 
		{
			if enemyIndex != ds_list_size(enemiesInProximity) - 1 {
				if MYTARGET != undefined {
					if MYTARGET.deathFlag = 1 { MYTARGET = enemiesInProximity[|enemyIndex + 1] }
				}
			} 
		} else {
				if MYTARGET != undefined 
				{
					if MYTARGET.deathFlag = 1 { lockOnToggle = 0 TARGETSELECTBUFFER = 0 MYTARGET = undefined inEncounter = 0 highlightedEnemy = undefined ds_list_clear(enemiesInProximity)}	
				}
			}
		highlightedEnemy = enemiesInProximity[|enemyIndex]
	break;
}
#endregion

if CURRENTOVERHEAL > 0
{
	while overhealDrainBuffer = 0 { alarm[3] += 2 overhealDrainBuffer = 1 }
}	

if MYTARGET = undefined {
	targetPointX = x
	targetPointY = y
}

if MYTARGET != undefined {
	if x < MYTARGET.x { facingDirection = RIGHT }
	if x > MYTARGET.x { facingDirection = LEFT  }
	targetPointY = MYTARGET.y
	if x > MYTARGET.x {
		targetPointX = MYTARGET.x + ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
	} else {
		targetPointX = MYTARGET.x - ((sprite_get_width(MYTARGET.sprite_index)/2) + targetHorizontalDistanceBuffer)
	}	
	targetDistanceX = targetPointX - x
	targetDistanceY = targetPointY - y
	//RELEASE HARD TARGET IF IN PROXIMITY TO ENEMIES BUT NOT IN PROXIMITY TO PREVIOUS TARGET
	//IF STILL IN RANGE OF ENEMIES BUT NOT YOUR TARGETED ONE THEN RELEASE TARGET TOGGLE
	if distance_to_object(obj_actionEnemyParent) < obj_actionHandler.enemyProximity && distance_to_object(MYTARGET) > obj_actionHandler.enemyProximity
	{ 
		 MYTARGET = undefined 
		 lockOnToggle = 0
		 enemyIndex = 0
	 scr_playSFX(sfx_LOCKOFF, 2000, false)
	with obj_cameraZoomer { flag = -1 }
	}
	if distance_to_object(obj_actionEnemyParent) > obj_actionHandler.enemyProximity && distance_to_object(MYTARGET) > obj_actionHandler.enemyProximity
	{
		MYTARGET = undefined 
		lockOnToggle = 0
		scr_playSFX(sfx_LOCKOFF, 2000, false)
		with obj_cameraZoomer { flag = -1 }	
	}
}

//if global._buttAHold { if chargeValue < maxChargeValue { chargeValue += 1 } } else { chargeValue = 0 }


//if !global._bumperL { while menuDismissBuffer = 0 { scr_playSFX(sfx_menuDismiss, 500, false) menuDismissBuffer = 1 } dpadAddBuffer = 0 dpadAddValue = 0 sacrificeBuffer = 0 }



//if jumpAmt > 0 { jumpAmt = jumpAmt - (1 * weight) }

//if velocity > -10 
//{
//	onGround = 0	
//}


#region FOCUS HEAL
if _focusHeal && !OCCUPIED or canCancel = 1 { starFlag = 1 focusHealFlag = 1 } else { if starFlag = 1 { starFlag = 0 }focusHealFlag = 0 }
switch(focusHealFlag)
{
	case 0:
		
	break;
	
	case 1:
		if CURRENTLIFE + 0.1 < MAXLIFE { CURRENTLIFE += 0.1} else { CURRENTLIFE = MAXLIFE }
		if CURRENTLIFE >= MAXLIFE 
		{
			if CURRENTOVERHEAL + 0.1 < MAXOVERHEAL { CURRENTOVERHEAL += 0.1 } else { CURRENTOVERHEAL = MAXOVERHEAL}
		}
	break;
}
#endregion

//#region MOVEMENT
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
//		if vaxis > global.deadZoneAmt { y += vaxis   * moveSpd } 
//		//GOING UPWARDS
//		if vaxis < -global.deadZoneAmt{ y -= -(vaxis * moveSpd) }
//		//GOING RIGHT
//		if haxis > global.deadZoneAmt { x += (haxis  * moveSpd) facingDirection = RIGHT }
//		//GOING LEFT										    
//		if haxis < -global.deadZoneAmt{ x -= -(haxis * moveSpd) facingDirection = LEFT }
//		break;
//		
//		case 1:
//		
//		break;
//	}
//	if vaxis > -global.deadZoneAmt && vaxis < global.deadZoneAmt { movingVertically = 0 } else { movingVertically = 1 }
//	if haxis > -global.deadZoneAmt && haxis < global.deadZoneAmt { movingHorizontally = 0 } else { movingHorizontally = 1 }
//	if movingHorizontally = 0 && movingVertically = 0 { stationary = 1 currentSprite = idleSprite } else { stationary = 0 } 
//	
//	break;
//}
//#endregion

if _roll
{
	if flag = 0 or canCancel = 1 {
			image_index = 0
			moveIndex = 0
			switch(global.usingGamepad)
			{
				case 0:
					switch(facingDirection)
					{
						case UP:	vertRollSpeed += -rollAmt	break;
						case DOWN:	vertRollSpeed += rollAmt	break;
						case LEFT:	break;
						case RIGHT: break;
					}
				break;
				
				case 1:
			
					//GUARDING
					{
						switch(stationary)
						{
							case 0:
							
							if global._downDpad { vertRollSpeed += rollAmt }
							if global._upDpad { vertRollSpeed += -rollAmt }
							if global._rightDpad { horizRollSpeed += rollAmt }
							if global._leftDpad { horizRollSpeed += -rollAmt }
				
							var haxis = gamepad_axis_value(0, gp_axislh);
							var vaxis = gamepad_axis_value(0, gp_axislv);
							var dir = point_direction(0, 0, haxis, vaxis);
							flag = 2 speed +=  rollAmt 
							flag = 2 speed -= -rollAmt
							break;
							
							case 1:
								switch(facingDirection)
								{
								case RIGHT: { flag = 3 alarm[0] += 5 myGuard = instance_create_layer(x + sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionBlock) } break;
								case LEFT:  { flag = 3 alarm[0] += 5 myGuard = instance_create_layer(x - sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionBlock) } break;
								}
							break;
						}
					}
				break;
		}	
	}
}

if _jump {
	if flag = 0 or canCancel { image_index = 0 flag = 4 } 
}

if _attack {
	
	if flag = 0 or flag = 4 or canCancel = 1 && moveIndex != moveLimit {
		if chargeValue  < 5 
		{
			image_index = 0
				switch(onGround)
				{	
					case 0:
					flag = 5
					break;
			
					case 1:
					flag = 1
					break;
				}
		}	
	}	
}




switch(flag)
{
	
	#region RUNNING AROUND AND SHIT
	case -5:
		if movingHorizontally = 0 && movingVertically = 0 { stationary = 1 } else { stationary = 0 }  
		currentSprite = spr_worm
		if stationary != 0 { image_speed = 0 } else { image_speed = 0.5 if !audio_is_playing(sfx_worming) audio_play_sound(sfx_worming, 2000, false)}
		switch(facingDirection)
		{
			case LEFT:
				image_xscale = -1
				
			break;
			
			case RIGHT:
				image_xscale = 1
			break;
		}
		
	break;
	case 0:
	var haxis = gamepad_axis_value(0, gp_axislh);
	var vaxis = gamepad_axis_value(0, gp_axislv);	
	
	switch(stationary)
	{	
		//YOU ARE NOT STATIONARY
		case 0:
		switch(global.usingGamepad)
		{
			case 0:
			
			break;
			
			case 1:
			//SET WALK AND RUN SPRITES BASED ON STICK AXIS VALUES
			if haxis > global.deadZoneAmt && haxis < runThreshold  { currentSprite = walkingSprite }
			if vaxis > global.deadZoneAmt && vaxis < runThreshold  { currentSprite = walkingSprite }
			if haxis < global.deadZoneAmt && haxis > -runThreshold { currentSprite = walkingSprite }
			if vaxis < global.deadZoneAmt && vaxis > -runThreshold { currentSprite = walkingSprite }
			
			if haxis > global.deadZoneAmt && haxis > runThreshold  { currentSprite = runningSprite }
			if vaxis > global.deadZoneAmt && vaxis > runThreshold  { currentSprite = runningSprite }
			if haxis < global.deadZoneAmt && haxis < -runThreshold { currentSprite = runningSprite }
			if vaxis < global.deadZoneAmt && vaxis < -runThreshold { currentSprite = runningSprite }
			//if haxis && vaxis < 0.20 { currentSprite = walkingSprite }
			//cycleRate = (sign(vaxis) + sign(haxis))/2
			break;
		}
		
		break;
		
		//YOU ARE STATIONARY 
		case 1:
		cycleRate = baseCycleRate
		currentSprite = idleSprite
		break;
	}
	OCCUPIED = 0
	//groundChecker.flag = 0
	
	canCancel = 0
	velocityFlag = 0
	spriteFlag = 0
	moveIndex = 0
	if image_number = 1 { image_index = 0 } else { image_speed = cycleRate }
	
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
	if _attack
	{
		switch(canCancel)
		{
			case 1: if moveIndex != moveLimit { scr_actionMoveReset() } break;
		}
	}
	//if combo[moveIndex].yLurch != 0 { onGround = 0 }
	//ANIMATION CANCELLING
	if moveIndex != moveLimit {	if image_index >= combo[moveIndex].targetFrame { canCancel = 1 } }
																									//if image_index >= combo[moveIndex].targetFrame { canCancel = 1 OCCUPIED = 0} else { canCancel = 0 OCCUPIED = 1 }
	image_speed = cycleRate
	spriteFlag = 1
	currentSprite = combo[moveIndex].sprite;
			switch(image_index)
				{	
					case combo[moveIndex].targetFrame:
					while velocityFlag = 0 {
							
						switch(facingDirection)
						{
							case LEFT:
							if MYTARGET = undefined {
								horizAddVal -= combo[moveIndex].xLurch
							}
							if MYTARGET != undefined {
								horizAddVal += targetDistanceX/2
								vertAddVal  += targetDistanceY/2
							}
							var hitbox = instance_create_layer(x - sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionHitbox)
							hitbox.damage = MYPOWER
							//hitbox.image_xscale = combo[moveIndex].hitScale
							//hitbox.image_yscale = combo[moveIndex].hitScale
							hitbox.parent = self
							break;
		
							case RIGHT:
							if MYTARGET = undefined {
								horizAddVal += combo[moveIndex].xLurch
							}
							if MYTARGET != undefined {
								horizAddVal += targetDistanceX/2
								vertAddVal  += targetDistanceY/2
							}
							var hitbox = instance_create_layer(x + sprite_get_width(sprite_index), y - sprite_get_height(sprite_index)/2, "Instances", obj_actionHitbox)
							hitbox.damage = MYPOWER
							//hitbox.image_xscale = combo[moveIndex].hitScale
							//hitbox.image_yscale = combo[moveIndex].hitScale
							hitbox.parent = self
							break;
						}
					velocityFlag = 1
				}
		break;
	}

	switch(spriteFlag)
	{
		case 1:
		switch(onGround)
		{
			case 0:
			
			break;
			
			case 1:
			if image_index = image_number - 1
			{
				flag = 0
			}
			break;
		}
		
		break;
	}
	break;
	#endregion
	
	#region ROLLING
	case 2:
	cycleRate = baseCycleRate
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
	image_speed = cycleRate
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
	currentSprite = spr_frameManJump
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
				if velocity < maximumVelocity { velocity += myGravity } 
				if velocity >= maximumVelocity { velocity = maximumVelocity fallFlag = 0 flag = 0  onGround = 1 }	
			}
		break;
	}
	switch(spriteFlag)
	{
		case 1: if image_index = image_number - 1 { image_speed = 0 } else { image_speed = cycleRate } break;
	}
	break;
	
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

