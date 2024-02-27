//if the object you wish to target with the camera exists
if instance_exists(target) {
	impactX = target.x
	impactY = target.y
	switch(flag)
	{
		case -2:
			sizeX = lerp(sizeX, 640, 0.5);
			sizeY = lerp(sizeY, 360, 0.5);
			posX = 0 + random(camShakeVal)
			posY = 0 - 180 + random(camShakeVal)
			impactScaleX = lerp(impactScaleX, 2, 0.7);
			impactScaleY = lerp(impactScaleY, 2, 0.7)
			impactAlpha = lerp(impactAlpha, 0, 0.7);
			camera_set_view_pos(view_camera[0], posX, posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			if camShakeVal > 0 {
				camShakeVal -= 1;
			}
			camera_set_view_pos(view_camera[0], posX, posY)
		break;
	
	
		case -1:
			horizontalDistance = 0
		    	verticalDistance = 0
			sizeX = lerp(sizeX, 640, 0.5);
			sizeY = lerp(sizeY, 360, 0.5);
			posX = lerp(posX, target.x - 320 + random(camShakeVal), lerpRate)
			posY = lerp(posY, target.y - 180 + random(camShakeVal), lerpRate)
			impactScaleX = lerp(impactScaleX, 2, 0.7);
			impactScaleY = lerp(impactScaleY, 2, 0.7)
			impactAlpha = lerp(impactAlpha, 0, 0.6);
			camera_set_view_pos(view_camera[0], posX, posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			camera_set_view_border(view_camera[0], 64, 64)
			if camShakeVal > 0 {
				camShakeVal -= 1;
			}
		break;
	
		case 0:
			//form change and power zoom
			while powerBuffer = 0 { alarm[2] += retractionTime powerBuffer = 1}
			impactX = target.x 
			impactY = target.y - 15
			sizeX = lerp(sizeX, 320, 0.6);
			sizeY = lerp(sizeY, 180, 0.6);
			posX = 160
			posY = 102
			camera_set_view_pos(view_camera[0], target.x - posX, target.y - posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			impactScaleX = lerp(impactScaleX, 1.2, 0.5);
			impactScaleY = lerp(impactScaleY, 1.2, 0.5)
			impactAlpha = lerp(impactAlpha, 1, 0.5);
		break;
	
		case 1:
			sizeX = lerp(sizeX, 640, 0.5);
			sizeY = lerp(sizeY, 360, 0.5);
			posX = target.x - 320 + random(camShakeVal)
			posY = target.y - 180 + random(camShakeVal)
			impactScaleX = lerp(impactScaleX, 2, 0.7);
			impactScaleY = lerp(impactScaleY, 2, 0.7)
			impactAlpha = lerp(impactAlpha, 0, 0.7);
			camera_set_view_pos(view_camera[0], posX, posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			camera_set_view_border(view_camera[0], 64, 64)
			if camShakeVal > 0 {
				camShakeVal -= 1;
			}
		break;
	
		case 20:
			posX = lerp(posX, target.x - 140, 0.1)
			posY = lerp(posY, target.y - 180, 0.1)
			camera_set_view_pos(view_camera[0], posX, posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			camera_set_view_border(view_camera[0], 64, 64)
		break;
		
		case 30:
			//camera logic if you're locked on
			//places the camera squarely halfway between you and your target
			if obj_actionProtag.MYTARGET != undefined {
			horizontalDistance = obj_actionProtag.MYTARGET.x - obj_actionProtag.x
			verticalDistance = obj_actionProtag.MYTARGET.y - obj_actionProtag.y
			}
			sizeX = lerp(sizeX, 640, 0.5);
			sizeY = lerp(sizeY, 360, 0.5);
			posX = lerp(posX, (target.x - 320) + (horizontalDistance/2) + random(camShakeVal), lerpRate)
			posY = lerp(posY, (target.y - 180) + (verticalDistance/2) +random(camShakeVal), lerpRate)
			impactScaleX = lerp(impactScaleX, 2, 0.7);
			impactScaleY = lerp(impactScaleY, 2, 0.7)
			impactAlpha = lerp(impactAlpha, 0, 0.6);
			camera_set_view_pos(view_camera[0], posX, posY)
			camera_set_view_size(view_camera[0], sizeX, sizeY)
			camera_set_view_border(view_camera[0], 64, 64)
			if camShakeVal > 0 {
				camShakeVal -= 1;
			}
		break;
	
	
	}
} else {
	switch(flag)
	{
		case 25:
			camera_set_view_pos(view_camera[0], 0 + random(camShakeVal), 0 + random(camShakeVal))
			sizeX = lerp(sizeX, 640, 0.6);
			sizeY = lerp(sizeY, 360, 0.6);
			camera_set_view_size(view_camera[0], sizeX, sizeY)
		break;
	}
}
camShakeVal = lerp(camShakeVal, 0, 0.1)
