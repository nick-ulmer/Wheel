/// @description Reset effects

if (instance_exists(obj_player)) {
	with (obj_player) {
		speed_multiplier = 1;
		gravRate = obj_player.gravRateNormal;
		friction_multiplier = 1;
	}
}


show_debug_message("ability disabled!");