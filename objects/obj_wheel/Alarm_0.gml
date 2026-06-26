/// @description Reset effects

if (instance_exists(obj_player)) {
	with (obj_player) {
		knockback_multiplier = 1;
		speed_multiplier = 1;
		gravRate = obj_player.gravRateNormal;
		friction_multiplier = 1;
		air_handling_multiplier = 1;
	}
}


show_debug_message("ability disabled!");