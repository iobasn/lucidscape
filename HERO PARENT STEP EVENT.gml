haxis = gamepad_axis_value(0, gp_axislh);
vaxis = gamepad_axis_value(0, gp_axislv);
#region PORTRAIT COLOR CONTROL
portraitAddVal = lerp(portraitAddVal, 0, 0.3)

//these color values are used when drawing the battle portraits
//when a character is hurt, green and blue are subtracted from so 
//the portrait becomes more red. green and blue then swiftly lerp back
//to 255 so the portrait returns to normal. the end result is exactly
//how kingdom hearts does it when the player takes damage

redValue = lerp(redValue, 255, 0.2)
greenValue = lerp(greenValue, 255, 0.2)
blueValue = lerp(blueValue, 255, 0.2)
portraitColor = make_color_rgb(redValue, greenValue, blueValue)
#endregion

//sprite being set to variable currentSprite

sprite_index = currentSprite

//get coordinates and parameters of the camera
camX = camera_get_view_x(view_camera[0])
camY = camera_get_view_y(view_camera[0])
camWidth = camera_get_view_width(view_camera[0])
camHeight= camera_get_view_height(view_camera[0])

//get how far you are from the leading member
//totally couldve just used the built in distance_from_object function but uhhhh
//:)
distanceFromLeaderX = (global.CURRENTLY_CONTROLLED_CHARA.x + x)
distanceFromLeaderY = (global.CURRENTLY_CONTROLLED_CHARA.y + y)

indicatorBuffer  = 15 

//get distance from camera 
distanceFromCamX = x - camX 
distanceFromCamY = y - camY

//SLOOOOOOOPE logic
//probably not doing it right but i'll be damned if it doesnt work literally perfectly
//if you read actually read this cavemanon i am way more than open to critique please god 
//i like to know what im actually doing!!! not floundering!!!!

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

//checks whether the member is within the boundaries of the camera or not 
if x > (camX + camWidth) or x < camX { offscreen = 1 }
if y > (camY + camHeight) or y < camY { offscreen = 1 }
if x < (camX + camWidth) && x > camX && y < (camY + camHeight) && y > camY { offscreen = 0 } 

if jumpValue > 0 { jumpValue -= (jumpValue) } 
y -= jumpValue

switch(flag)
{
	
	#region RUNNING AROUND AND SHIT
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
	//this is fucking horrible i think
	//BUT AGAIN IT WORKS?? KINDA?
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
	//BIG REWORK IN PROGRESS
	//MODULARITY IS WORTH IT 
	//AAA
	break;
	
	#endregion
}
