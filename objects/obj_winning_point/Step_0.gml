if (!touched && place_meeting(x, y, obj_player)) {
	audio_play_sound(level_snd,1,false);
	gm.game_win();
	obj_player.hp = 0;
	
	//getLevelByRoom(room).completed = true;
	setLevelCompleted(room);
	global.goto_shop = true;
	global.next_level_index = getLevelIndexByRoom(room) + 1;
	var _x = gm.level_time - gm.game_timer;
	
	
	save_tokens();
	touched = true;
}