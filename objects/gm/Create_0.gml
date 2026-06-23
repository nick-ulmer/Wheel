/// @description Initialize
tokens = 0;

add_tokens = function(_value = 1) {
	tokens += _value;
	show_debug_message(string(_value) + " tokens added for a total of " + string(tokens));
}

game_paused = false;

build_pause_menu = function() {
	if (ui_exists("Pause_Menu")) {
        ui_get("Pause_Menu").destroy();
        show_debug_message("Pause Menu Rebuilt");
    }
	
	var _panel = new UIPanel("Pause_Menu", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
		_panel.setResizable(true).setImageAlpha(0.75).setTitle("Pause Menu").setTitleFormat("[c_black][fa_top]");
	
	var _main_menu = new UIButton("Goto_MainMenu_Button", 0, 50, 100, 50, "Exit to Main Menu", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_main_menu
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Pause_Menu").destroy();
			ui_get("Panel_Abilities").destroy();
			room_goto(rm_main_menu);
		});
	_panel.add(_main_menu);
}