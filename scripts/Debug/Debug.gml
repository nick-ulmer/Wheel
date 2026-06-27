global.debug = false;
function Debug() {
	if (ui_exists("Debug_Panel")) {
        ui_get("Debug_Panel").destroy();
    }
	var _panel = new UIPanel("Debug_Panel", 0, 0, 300, 300, grey_panel, UI_RELATIVE_TO.TOP_RIGHT);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Debug_Panel").setTitleFormat("[c_black][fa_top]");
	
	var _token_add = _panel.add(new UIButton("_token_add", -20, 35, 25, 25, "+", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_token_add
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			global.add_tokens(25);
			save_tokens();
			show_debug_message("add tokens");
		});
	var _token_subtract = _panel.add(new UIButton("_token_subtract", 20, 35, 25, 25, "-", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_token_subtract
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			global.add_tokens(-25);
			save_tokens();
			show_debug_message("subtract tokens");
		});
	var _reset_tokens = _panel.add(new UIButton("_reset_tokens", 100, 35, 100, 25, "reset tokens", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_reset_tokens
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			global.tokens = 0;
			save_tokens();
			show_debug_message("tokens reset");
		});
		
	var _reset_abilities = _panel.add(new UIButton("_reset_abilities", 0, 65, 150, 25, "Reset Abilites", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_reset_abilities
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			for (var _i = 0; _i < array_length(global.abilities); _i++) {
				global.abilities[_i].bought = false;
			}
			show_debug_message("abilities reset. must buy again");
		});
		
	var _level_unlock = _panel.add(new UIButton("_level_unlock", 0, 95, 150, 25, "Unlock Levels", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_level_unlock
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			for (var _i = 0; _i < array_length(global.levels); _i++) {
				global.levels[_i].completed = true;
			}
			show_debug_message("All levels unlocked");
		});
		
	var _reset_levels = _panel.add(new UIButton("_reset_levels", 0, 125, 150, 25, "_reset_levels", blue_button00, UI_RELATIVE_TO.TOP_CENTER));
	_reset_levels
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			for (var _i = 0; _i < array_length(global.levels); _i++) {
				global.levels[_i].completed = false;
				global.levels[_i].min_time = 60 * 60 * 60 * 24;
			}
			show_debug_message("All levels LOCKED");
		});
}