if (place_meeting(x, y, obj_player)) {
	gm.game_win();
	obj_player.hp = 0;
}