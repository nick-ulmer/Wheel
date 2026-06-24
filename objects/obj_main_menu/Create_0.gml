
main_menu = function() {
	var _panel = new UIPanel("MainMenu_Panel", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Main Menu").setTitleFormat("[c_black][fa_top]");

	var _play_button = new UIButton("Play_Button", 0, 50, 100, 50, "Play", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_play_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("MainMenu_Panel").destroy();
			level_select();
		});
	_panel.add(_play_button);
	
	var _shop_button = new UIButton("_shop_button", 0, 100, 100, 50, "Shop", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_shop_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("MainMenu_Panel").destroy();
			room_goto(rm_shop);
		});
	_panel.add(_shop_button);
}

level_select = function() {
	var _panel = new UIPanel("LevelSelect_Panel", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Level Select").setTitleFormat("[c_black][fa_top]");

	var _lvl0 = new UIButton("_lvl0", 0, 50, 100, 50, "rm_lvl_0", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_lvl0
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			room_goto(rm_lvl_0);
		});
	_panel.add(_lvl0);
	
	var _lvl5 = new UIButton("_lvl5", 0, 100, 100, 50, "rm_lvl_5", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_lvl5
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			room_goto(rm_lvl_5);
		});
	_panel.add(_lvl5);
	
	var _lvlTEST = new UIButton("_lvlTEST", 0, 150, 100, 50, "rm_lvlTEST", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_lvlTEST
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			room_goto(rm_lvlTEST);
		});
	_panel.add(_lvlTEST);
	
	var _wheel = new UIButton("_wheel", 0, 200, 100, 50, "rm_wheel", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_wheel
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			room_goto(rm_wheel);
		});
	_panel.add(_wheel);

	var _back_button = new UIButton("Back_Button", 0, -20, 100, 50, "Back", blue_button00, UI_RELATIVE_TO.BOTTOM_CENTER);
	_back_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			main_menu();
		});
	_panel.add(_back_button);
	
}

main_menu();