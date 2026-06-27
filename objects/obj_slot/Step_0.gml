if (!touched && place_meeting(x, y, obj_player)) {	
	global.checkpoint_x = obj_player.x;
	global.checkpoint_y = obj_player.y;

	touched = true;
}