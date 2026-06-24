
main = function() {
	var _panel = new UIPanel("MainMenu_Panel", 0, 0, 1000, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("The Shop").setTitleFormat("[c_black][fa_top]");

	var _play_button = new UIButton("Play_Button", 0, 50, 100, 50, "Play", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_play_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			//ui_get("MainMenu_Panel").destroy();
			//level_select();
		});
	_panel.add(_play_button);
	
	var _s = 64;
	var _m = 16;
	var _coinTL = _panel.add(new UISprite("_coinTL", _m, _m, spr_tokens, _s, _s, 0, UI_RELATIVE_TO.TOP_LEFT));
	_coinTL.animationPause()
	var _coinTR = _panel.add(new UISprite("_coinTR", -_m, _m, spr_tokens, _s, _s, 1, UI_RELATIVE_TO.TOP_RIGHT));
	_coinTR.animationPause()
	var _coinBL = _panel.add(new UISprite("_coinBL", _m, -_m, spr_tokens, _s, _s, 2, UI_RELATIVE_TO.BOTTOM_LEFT));
	_coinBL.animationPause()
	var _coinBR = _panel.add(new UISprite("_coinBR", -_m, -_m, spr_tokens, _s, _s, 3, UI_RELATIVE_TO.BOTTOM_RIGHT));
	_coinBR.animationPause()
}

main();