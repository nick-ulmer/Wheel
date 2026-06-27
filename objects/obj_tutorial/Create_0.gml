touched = false;

text_basic = [
	"WASD to move. SPACE to jump!",
	"Press \"E\" to spin the wheel for a temporary ability",
	"Grab coins to buy more abilities in the shop"
];
t_basic = function() {
	var _t = "tutorial"
	if ui_exists(_t) {ui_get(_t).destroy();}
	
	var _panel = new UIPanel(_t, 0, 0, getUIRelScale(7), getUIRelScale(2), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(1).setTitle("The Basics").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});

	for (var _i = 0; _i < array_length(text_basic); _i++) {
		var _txt = _panel.add(new UIText(string(_i)+"_txt", 0, _i*25 + 50, text_basic[_i], UI_RELATIVE_TO.TOP_CENTER));
		_txt.setTextFormat("[scale,1.25]");
	}

	var _close_button = _panel.add(new UIButton("_close", 0, -50, 100, 50, "CLOSE", spr_btn_small, UI_RELATIVE_TO.BOTTOM_CENTER));
	_close_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("tutorial").destroy();
		});
}

text_checkpoints = [
	"Touch the slot machine to get a checkpoint.",
	"You'll respawn here if you die.",
	"Watch out for the spikes ahead!"
];
t_checkpoint = function() {
	var _t = "tutorial"
	if ui_exists(_t) {ui_get(_t).destroy();}
	
	var _panel = new UIPanel(_t, 0, 0, getUIRelScale(7), getUIRelScale(2), spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(1).setTitle("Checkpoints").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});

	for (var _i = 0; _i < array_length(text_checkpoints); _i++) {
		var _txt = _panel.add(new UIText(string(_i)+"_txt", 0, _i*25 + 50, text_checkpoints[_i], UI_RELATIVE_TO.TOP_CENTER));
		_txt.setTextFormat("[scale,1.25]");
	}

	var _close_button = _panel.add(new UIButton("_close", 0, -50, 100, 50, "CLOSE", spr_btn_small, UI_RELATIVE_TO.BOTTOM_CENTER));
	_close_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("tutorial").destroy();
		});
	
}


tutorial_menu = t_basic;