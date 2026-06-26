/// @description Initialize

/*var _minutes = 0; // Minutes
switch(room) {
	case rm_lvl_0: _minutes = 3; break;
	case rm_lvl_1: _minutes = 1; break;
	case rm_lvl_2: _minutes = 2; break;
	case rm_lvl_3: _minutes = 3; break;
	//case rm_lvl_4: _minutes = 3; break;
	case rm_lvl_5: _minutes = 5; break;
}*/

var _minutes = getLevelByRoom(room).max_timer_mins;
game_timer = game_get_speed(gamespeed_fps) * 60 * _minutes; // active timer that gets ticked down
level_time = game_timer; // records the time in the level. 



game_paused = false;

build_pause_menu = function() {
	if (ui_exists("Pause_Menu")) {
        ui_get("Pause_Menu").destroy();
        show_debug_message("Pause Menu Rebuilt");
    }
	
	var _panel = new UIPanel("Pause_Menu", 0, 0, getUIRelScale(2), getUIRelScale(2), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
		_panel.setResizable(true).setTitle("Pause Menu").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _main_menu = _panel.add(new UIButton("Goto_MainMenu_Button2", 0, -50, 150, 75, "Main Menu", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_main_menu
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Pause_Menu").destroy();
			ui_get("Panel_Abilities").destroy();
			room_goto(rm_main_menu);
		});
		
	var _restart_level = _panel.add(new UIButton("RestartLevel_Button", 0, 50, 150, 75, "Restart Level", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_restart_level
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Pause_Menu").destroy();
			ui_get("Panel_Abilities").destroy();
			room_restart();
		});
}

game_over = function() {
	
	var _panel = new UIPanel("Game_Over", 0, 0, getUIRelScale(2), getUIRelScale(2), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
		_panel.setResizable(true).setTitle("You lose!").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	 
	var _main_menu = _panel.add(new UIButton("Goto_MainMenu_Button2", 0, -50, 150, 75, "Main Menu", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_main_menu
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Game_Over").destroy();
			ui_get("Panel_Abilities").destroy();
			room_goto(rm_main_menu);
		});
		
	var _restart_level = _panel.add(new UIButton("RestartLevel_Button", 0, 50, 150, 75, "Restart Level", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_restart_level
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Game_Over").destroy();
			ui_get("Panel_Abilities").destroy();
			room_restart();
			//room_goto(rm_main_menu);
		});
}

game_win = function() {
	var _panel = new UIPanel("Game_Win", 0, 0, getUIRelScale(2), getUIRelScale(3), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
		_panel.setResizable(true).setTitle("You lose!").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	 
	var _main_menu = _panel.add(new UIButton("Goto_MainMenu_Button2", 0, -90, 200, 75, "Main Menu", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_main_menu
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Game_Win").destroy();
			ui_get("Panel_Abilities").destroy();
			room_goto(rm_main_menu);
		});
		
	var _restart_level = _panel.add(new UIButton("RestartLevel_Button", 0, 0, 200, 75, "Restart Level", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_restart_level
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Game_Win").destroy();
			ui_get("Panel_Abilities").destroy();
			room_restart();
			//room_goto(rm_main_menu);
		});
		
	var _next_level = _panel.add(new UIButton("Goto_NextLevel_Button2", 0, 90, 200, 75, "Next Level", spr_button_green, UI_RELATIVE_TO.MIDDLE_CENTER));
	_next_level
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Game_Win").destroy();
			ui_get("Panel_Abilities").destroy();
			room_goto(rm_shop);
		});
		
}