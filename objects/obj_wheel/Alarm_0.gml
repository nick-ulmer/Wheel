/// @description Reset effects

if (instance_exists(obj_player)) {
	obj_player.speed_multiplier = 1;
	obj_player.gravRate = obj_player.gravRateNormal;
}


show_debug_message("ability disabled!");