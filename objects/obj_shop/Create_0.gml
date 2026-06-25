a_bought = []; // Holds list of unlocked abiilties via index of global.abilities
a_shop = []; // Holds list of LOCKED abiilties via index of global.abilities

update_ability_array = function() {
	
}

main = function() {
	var _panel = new UIPanel("Shop_Panel", 0, 0, 1000, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("The Shop").setTitleFormat("[c_black][fa_top]");

	/*var _play_button = new UIButton("Play_Button", 0, 50, 100, 50, "Play", blue_button00, UI_RELATIVE_TO.TOP_CENTER);
	_play_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			//ui_get("MainMenu_Panel").destroy();
			//level_select();
		});
	_panel.add(_play_button);*/
	
	// RESET
	a_bought = [];
	a_shop = [];
	
	for (var _i = 0; _i < array_length(global.abilities); _i++) {
		if (global.abilities[_i].bought) {
			array_push(a_bought, _i)
			
		} else {
			array_push(a_shop, _i)
		}
	}
	
	_panel.add(new UIText("shop", -100, 30, "Shop", UI_RELATIVE_TO.TOP_CENTER))
	_panel.add(new UIText("bought", 100, 30, "Bought", UI_RELATIVE_TO.TOP_CENTER))
		
	
	for (var _i = 0; _i < array_length(a_shop); _i++) {
		var _text = global.abilities[a_shop[_i]].name + " - " + string(global.abilities[a_shop[_i]].cost);
		var _a = _panel.add(new UIButton("shop_"+string(_i), -100, _i*30+50, 200, 25, _text, blue_button00, UI_RELATIVE_TO.TOP_CENTER))
		_a.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {
			obj_shop.ability_buy_info(obj_shop.a_shop[_i]);
			ui_get("Shop_Panel").destroy();
		}))
	}
	for (var _i = 0; _i < array_length(a_bought); _i++) {
		var _a = _panel.add(new UIText("bought_"+string(_i), 100, _i*30+50, "- "+global.abilities[a_bought[_i]].name, UI_RELATIVE_TO.TOP_CENTER))
		_a.setTextFormat("[fa_top]").setTextFormatMouseover("[fa_top]").setTextFormatClick("[fa_top]");
		//var _a = _panel.add(new UIButton("bought_"+string(_i), 100, _i*30+30, 200, 25, global.abilities[a_bought[_i]].name, blue_button00, UI_RELATIVE_TO.TOP_CENTER))
	}
	
	#region Sprites
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
	#endregion
}

ability_buy_info = function(_ability_index) {
	var _panel = new UIPanel("Buy_Panel", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle(global.abilities[_ability_index].name).setTitleFormat("[c_black][fa_top]");
	
	var _text = _panel.add(new UIText("Ability_Text", 0, -50, global.abilities[_ability_index].text, UI_RELATIVE_TO.MIDDLE_CENTER));
	show_debug_message(global.abilities[_ability_index].text);
	var _back = _panel.add(new UIButton("go_back", 0, -50, 100, 50, "Go Back", blue_button00, UI_RELATIVE_TO.BOTTOM_CENTER));
	_back.setCallback(UI_EVENT.LEFT_RELEASE, function() {
		obj_shop.main();
		ui_get("Buy_Panel").destroy();
	})
	
	var _buy = _panel.add(new UIButton("ability_buy", 0, -110, 100, 50, "Buy It!!!", blue_button00, UI_RELATIVE_TO.BOTTOM_CENTER));
	_buy.setCallback(UI_EVENT.LEFT_RELEASE, method({_ability_index}, function() {
		obj_wheel.buy_ability(_ability_index);
		save_abilities();
		obj_shop.main();
		ui_get("Buy_Panel").destroy();
	}))
	
}

main();