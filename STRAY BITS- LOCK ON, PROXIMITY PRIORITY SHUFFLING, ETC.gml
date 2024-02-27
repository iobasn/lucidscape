//stray bits
//LOCK ON, focus healing, shuffling enemy lock on priority based on proximity, etc

if distance_to_object(obj_actionEnemyParent) < obj_actionHandler.enemyProximity 
{ 
	inEncounter = 1
} else	{
	if lockOnToggle = 1 { scr_playSFX(sfx_LOCKOFF, 3400, false) } lockOnToggle = 0 TARGETSELECTBUFFER = 0
    MYTARGET = undefined inEncounter = 0 highlightedEnemy = undefined ds_list_clear(enemiesInProximity)
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

//makes you face your opponent if locked on
//does NOT impede movement, simply makes you face them
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

#region FOCUS HEAL
//star flag is in regards to a cosmetic star object that swirls around the player when focus healing
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

