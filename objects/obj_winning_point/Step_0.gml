if (!touched && place_meeting(x, y, obj_player)) {
	gm.game_win();
	obj_player.hp = 0;
	
	//getLevelByRoom(room).completed = true;
	setLevelCompleted(room);
	global.goto_shop = true;
	global.next_level_index = getLevelIndexByRoom(room) + 1;
	var _x = gm.level_time - gm.game_timer;
	
	
	touched = true;
}