
main_menu = function() {
	var _size = getUIRelScale(4);
	var _btn_w = getUIRelScale(1);
	var _btn_h = getUIRelScale(0)*0.75;
	var _panel = new UIPanel("MainMenu_Panel", 0, 0, _size, _size, spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(0.75).setTitle("Main Menu").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _play_button = _panel.add(new UIButton("Play_Button", 0, -_btn_h/1.5, _btn_w, _btn_h, "Play", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_play_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("MainMenu_Panel").destroy();
			level_select();
		});
	
	var _shop_button = _panel.add(new UIButton("_shop_button", 0, _btn_h/1.5, _btn_w, _btn_h, "Shop", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_shop_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("MainMenu_Panel").destroy();
			room_goto(rm_shop);
		});
}

lvlButton = function(_text, _room, _x, _y, _w, _h, _rel = UI_RELATIVE_TO.TOP_CENTER) {
	var _lvl = new UIButton(_text, _x, _y, _w, _h, _text, spr_button, _rel);
	_lvl
		.setCallback(UI_EVENT.LEFT_RELEASE, method({_room},function() {
			ui_get("LevelSelect_Panel").destroy();
			room_goto(_room);
		}))
		.setSpriteDisabled(spr_button_disabled).setTextFormatDisabled("[c_grey]");
		
	return _lvl
}

level_select = function() {
	var _size = getUIRelScale(4);
	var _btn_w = getUIRelScale(1);
	var _btn_h = getUIRelScale(0)*0.75;
	var _panel = new UIPanel("LevelSelect_Panel", 0, 0, getUIRelScale(2), getUIRelScale(7), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Level Select").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});

	var _j = 0;
	for (var _i = 0; _i < array_length(global.levels); _i++) {
		var _lvl = global.levels[_i];
		if (_lvl.room == rm_game_completed) continue;
		
		var _btn = _panel.add(lvlButton(_lvl.name, _lvl.room, 0, 50+_i*80, _btn_w, _btn_h, UI_RELATIVE_TO.TOP_CENTER));
		if (_lvl.completed) {
			_btn.setText(_lvl.name + " - " + TimerText(_lvl.min_time));
		}
		
		if (_i >= 1 && !global.levels[_i-1].completed) {
			_btn.setEnabled(false);
		}
		
		_j = _i
	}

	var _back_button = new UIButton("Back_Button", 0, -20, _btn_w, _btn_h, "Back", spr_button, UI_RELATIVE_TO.BOTTOM_CENTER);
	_back_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("LevelSelect_Panel").destroy();
			main_menu();
		});
	_panel.add(_back_button);
}

main_menu();