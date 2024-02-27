//the step function of the general battle handler
//input for the command menu and character currently being controlled is picked up here

haxis = gamepad_axis_value(0, gp_axislh);
vaxis = gamepad_axis_value(0, gp_axislv);

if global._shoulderL 
{ 
	for(var i = array_length(mate) - 1; i > 0; i--)
	{
		var temp = mate[i - 1]
		mate[i - 1] = mate[i]
		mate[i] = temp	
	}
	if CONTROL_INDEX != 0 { CONTROL_INDEX-- } else { CONTROL_INDEX = array_length(mate) - 1 }

	scr_setCameraTarget(global.CURRENTLY_CONTROLLED_CHARA)
}
if global._shoulderR
{
	
	for(var i = 0; i < array_length(mate) - 1; i++)
	{
		var temp = mate[i + 1]
		mate[i + 1] = mate[i]
		mate[i] = temp	
	}
	
	if CONTROL_INDEX != array_length(mate) - 1 { CONTROL_INDEX++ } else { CONTROL_INDEX = 0 }
	
	scr_setCameraTarget(global.CURRENTLY_CONTROLLED_CHARA)	
}
global.CURRENTLY_CONTROLLED_CHARA = mate[0]
scr_setCameraTarget(mate[0])
floatIter += floatIterSpeed
#region INPUT
_left = keyboard_check(vk_left) 
_right = keyboard_check(vk_right) 
_up = keyboard_check(vk_up) or global._upDpadTap
_down = keyboard_check(vk_down) or global._downDpadTap
_confirm = keyboard_check_pressed(ord("X")) or global._buttA
_roll = keyboard_check_pressed(ord("Z")) or global._buttX
_jump = keyboard_check_pressed(ord("C")) or global._buttB 
_lockOn = keyboard_check_pressed(ord("V")) or global._shoulderR
_powerSacrifice = global._upDpadTap
_lifeSacrifice = global._downDpadTap
_lucidSacrifice = global._leftDpadTap
_defenseSacrifice = global._rightDpadTap
_focusHeal = global._shoulderL
#endregion 

itemIconOffset = lerp(itemIconOffset, 0, 0.7)
if _up or _down { scr_playSFX(sfx_actionMenuFlip, 1020, false) menuStarX = scr_GETVIEWX() + 0 itemIconOffset = -32}
starRotationAddition = (15 * (-actionMenuIndex + 1)) 
menuStarRotation2 = lerp(menuStarRotation2, menuStarRotation + starRotationAddition, 0.1)


if _up 
{
	if 	actionMenuIndex != 0 { actionMenuIndex-- } else { actionMenuIndex = array_length(MENU) - 1 }
	finalStarRotation += 15
}
if _down 
{
	if 	actionMenuIndex != array_length(MENU) - 1 { actionMenuIndex++ } else { actionMenuIndex = 0 }
	finalStarRotation -= 15
}

if _jump {
	with global.CURRENTLY_CONTROLLED_CHARA
	{
		if flag = 0 or canCancel { image_index = 0 flag = 4 } 
	}
}

//directly subtract hp or mp from currently controlled chara 4 debug purposes
if keyboard_check(ord("U")) { with global.CURRENTLY_CONTROLLED_CHARA { CURRENTLIFE -= 1 CURRENTMP -= 1 } }
if keyboard_check(ord("I")) { with global.CURRENTLY_CONTROLLED_CHARA { CURRENTLIFE += 1 CURRENTMP += 1 } }


if _confirm {
	var afterImage = instance_create_layer(menuStarX, menuStarY, "Instances", obj_afterImage)
	afterImage.anchorX = scr_GETVIEWX() + menuStarX
	afterImage.anchorY = scr_GETVIEWY() + menuStarY
	afterImage.behavior	= "EXPANDING"
	afterImage.spd			= 5
	afterImage.alph			= 0.5
	afterImage.sprite_index = spr_UISTAR
	afterImage.image_blend	= MENU[actionMenuIndex].COLOR 
	
	switch(flag)
	{
		case 1:
			switch(MENU[actionMenuIndex])
			{
				case global.MENU_OPTIONS_LIST.BASH:
				#region ATTACKING
				with global.CURRENTLY_CONTROLLED_CHARA {
					if flag = 0 or flag = 4 or canCancel = 1 && moveIndex != moveLimit {
						switch(onGround)
							{	
								case 0: flag = 5 break;
								case 1: flag = 1 break;
							}
					}	
					if flag = 1
					{
						switch(canCancel)
						{
							case 1:
							if moveIndex != array_length(GROUND_COMBO) { MOVE_INSTANCE_SPAWNBUFFER = 0 }
							break;
						}
					}
				}
				#endregion
				break;
				
				case global.MENU_OPTIONS_LIST.STUFFS:
				scr_playSFX(sfx_actionMenuSelect, 1000, false)
				break;
				
				case global.MENU_OPTIONS_LIST.ART:
				scr_playSFX(sfx_actionMenuSelect, 1000, false)
				break;
				
				case global.MENU_OPTIONS_LIST.SACK:
				scr_playSFX(sfx_actionMenuSelect, 1000, false)
				break;
			}	
		break;
	}
}


with global.CURRENTLY_CONTROLLED_CHARA
{
	//SETS AUDIO POSITION TO ALWAYS BE AT THE CHARACTER BEING CONTROLLED
	audio_listener_position(x, y, 0)
	switch(stationary)
	{
		case 0: direction = point_direction(0, 0, other.haxis, other.vaxis); break;
		case 1: break;
	}	
	
	switch(facingDirection)
	{
		case RIGHT: image_xscale =  1 break; case LEFT:  image_xscale = -1 break;
	}
	#region MOVEMENT
	switch(global.usingGamepad)
	{
		case 0:  break;
	
		case 1:
			switch(OCCUPIED)
			{
				case 0:
				//GOING DOWNWARDS
				if other.vaxis > global.deadZoneAmt 
				{ 
					if !place_meeting(x, y + other.vaxis * MYMOVEMENTSPEED, obj_wall)
					{
						y += other.vaxis   * MYMOVEMENTSPEED 
					}
					
				} 
				//GOING UPWARDS
				if other.vaxis < -global.deadZoneAmt
				{ 
					if !place_meeting(x, y - -(other.vaxis * MYMOVEMENTSPEED), obj_wall)
					{
						y -= -(other.vaxis * MYMOVEMENTSPEED)
					}
				}
				//GOING RIGHT
				if other.haxis > global.deadZoneAmt 
				{ 
					if !place_meeting(x + (other.vaxis * MYMOVEMENTSPEED), y, obj_wall)
					{
						x += (other.haxis * MYMOVEMENTSPEED) facingDirection = RIGHT
					}
				}
				//GOING LEFT										    
				if other.haxis < -global.deadZoneAmt
				{ 
					if !place_meeting(x + -(other.vaxis * MYMOVEMENTSPEED), y, obj_wall)
					{
						x -= -(other.haxis * MYMOVEMENTSPEED) facingDirection = LEFT
					}
				}
				break;
		
				case 1: break;
			}
			if other.vaxis > -global.deadZoneAmt && other.vaxis < global.deadZoneAmt { movingVertically = 0 }     else { movingVertically = 1 }
			if other.haxis > -global.deadZoneAmt && other.haxis < global.deadZoneAmt { movingHorizontally = 0	} else { movingHorizontally = 1 }
			if movingHorizontally = 0 && movingVertically = 0 { stationary = 1 currentSprite = idleSprite } else { stationary = 0 } 
		break;
	}
#endregion
	
	
}
