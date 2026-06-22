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
		_panel.setResizable(true).setImageAlpha(0.75).setTitle("Ability Wheel - Press \"E\" to Spin").setTitleFormat("[c_black][fa_top]");
	
}