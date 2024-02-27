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
			//camera_set_view_size(view_camera[0], sizeX, sizeY)
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
			//camera_set_view_pos(view_camera[0], posX, posY)
			//camera_set_view_size(view_camera[0], sizeX, sizeY)
		break;
	
		case 0:
			//FORM CHANGE AND POWER MOVE ZOOM
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

//if camException = false {
	
//}

//CAMPOSX = camera_get_view_x(view_camera[0])
//CAMPOSY = camera_get_view_y(view_camera[0])

//this is cahnges the zoom based on scolling but you can set it how ever you like
//zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.5, 2);

//Get current size
//var view_w = camera_get_view_width(view_camera[0]);
//var view_h = camera_get_view_height(view_camera[0]);


//var w = room_width*zoom_level;
//var h = room_height*zoom_level;

//center the view in the middle of the room
//var xx = (room_width - w) / 2;
//var yy = (room_height - h) / 2;

//update view coords
//view_xport[0] = xx;
//view_yport[0] = yy;

//Get new sizes by interpolating current and target zoomed size
//var new_w = lerp(view_w, zoom_level * default_zoom_width, rate);
//var new_h = lerp(view_h, zoom_level * default_zoom_height, rate);

//Apply the new size
//camera_set_view_size(view_camera[0], new_w, new_h);

//var vpos_x = camera_get_view_x(view_camera[0]);
//var vpos_y = camera_get_view_y(view_camera[0]);

//change coordinates of camera so zoom is centered
//var new_x = lerp(vpos_x,vpos_x+(view_w - zoom_level * default_zoom_width)/2, rate);
//var new_y = lerp(vpos_y,vpos_y+(view_h - zoom_level * default_zoom_height)/2, rate);

//view_xport[0] = lerp(view_xport[0], obj_dummyenemy3.x, 0.1);
//view_yport[0] = lerp(view_xport[0], obj_dummyenemy3.y, 0.1);

//view_xview[0] = xx;
//view_yview[0] = yy;

//view_set_xport(view)

