a_bought = []; // Holds list of unlocked abiilties via index of global.abilities
a_shop = []; // Holds list of LOCKED abiilties via index of global.abilities

main = function() {
	var _panel = new UIPanel("Shop_Panel", -120, 0, getUIRelScale(7), getUIRelScale(5), spr_ui, UI_RELATIVE_TO.MIDDLE_RIGHT);
	_panel.setResizable(false).setImageAlpha(0.75).setTitle("The Shop").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _main_menu_button = _panel.add(new UIButton("_main_menu_button", 0, -50, 100, 50, "Main Menu", spr_btn_small, UI_RELATIVE_TO.BOTTOM_CENTER));
	_main_menu_button
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Shop_Panel").destroy();
			room_goto(rm_main_menu);
		});
	
	if (global.goto_shop) {
		_main_menu_button.setDimensions(-55);
		var _next_lvl = _panel.add(new UIButton("_next_lvl", 55, -50, 100, 50, "Next Level", spr_btn_small_green, UI_RELATIVE_TO.BOTTOM_CENTER));
		_next_lvl
			.setCallback(UI_EVENT.LEFT_RELEASE, function() {
				ui_get("Shop_Panel").destroy();
				room_goto(global.levels[global.next_level_index].room);
			});
		global.goto_shop = false;
	}
	
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
	
	var _a_off = 50;
	_panel.add(new UIText("shop", -100, _a_off, "Shop", UI_RELATIVE_TO.TOP_CENTER))
	_panel.add(new UIText("bought", 100, _a_off, "Bought", UI_RELATIVE_TO.TOP_CENTER))
		
	
	for (var _i = 0; _i < array_length(a_shop); _i++) {
		var _text = global.abilities[a_shop[_i]].name + " - " + string(global.abilities[a_shop[_i]].cost);
		var _a = _panel.add(new UIButton("shop_"+string(_i), -100, _i*30+_a_off+20, 200, 25, _text, spr_btn_small, UI_RELATIVE_TO.TOP_CENTER))
		_a.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {
			obj_shop.ability_buy_info(obj_shop.a_shop[_i]);
			instance_destroy(obj_wheel);
			ui_get("Shop_Panel").destroy();
		}))
	}
	for (var _i = 0; _i < array_length(a_bought); _i++) {
		var _a = _panel.add(new UIText("bought_"+string(_i), 100, _i*30+_a_off+20, "- "+global.abilities[a_bought[_i]].name, UI_RELATIVE_TO.TOP_CENTER))
		_a.setTextFormat("[fa_top]").setTextFormatMouseover("[fa_top]").setTextFormatClick("[fa_top]");
		//var _a = _panel.add(new UIButton("bought_"+string(_i), 100, _i*30+30, 200, 25, global.abilities[a_bought[_i]].name, blue_button00, UI_RELATIVE_TO.TOP_CENTER))
	}
	
	var _money = _panel.add(new UIText("Money_Counter", 0, -30, "Tokens: " + string(global.tokens),UI_RELATIVE_TO.BOTTOM_CENTER))
	_money.setTextFormat("[fa_center][fa_middle]");
	
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
	var _panel = new UIPanel("Buy_Panel", 0, 0, 500, 500, spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle(global.abilities[_ability_index].name).setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _text = _panel.add(new UIText("Ability_Text", 0, -50, global.abilities[_ability_index].text, UI_RELATIVE_TO.MIDDLE_CENTER));
	show_debug_message(global.abilities[_ability_index].text);
	var _back = _panel.add(new UIButton("go_back", 0, -50, 100, 50, "Go Back", spr_btn_small, UI_RELATIVE_TO.BOTTOM_CENTER));
	_back.setCallback(UI_EVENT.LEFT_RELEASE, function() {
		obj_shop.main();
		instance_create_layer(0, 0, "Instances", obj_wheel);
		ui_get("Buy_Panel").destroy();
	})
	
	
	var _buy = _panel.add(new UIButton("ability_buy", 0, -110, 100, 50, "Buy It!!!", spr_btn_small, UI_RELATIVE_TO.BOTTOM_CENTER));
	_buy.setCallback(UI_EVENT.LEFT_RELEASE, method({_ability_index}, function() {
		
		instance_create_layer(0, 0, "Instances", obj_wheel);
		obj_wheel.buy_ability(_ability_index);
		save_abilities();
		obj_shop.main();
		ui_get("Buy_Panel").destroy();
	})).setSpriteDisabled(spr_btn_small_disabled);
	if (global.tokens < global.abilities[_ability_index].cost) {
		_buy.setEnabled(false);//.setSprite(blue_button13);
	}
	
	
	var _money = _panel.add(new UIText("Money_Counter", 0, -30, "Tokens: " + string(global.tokens),UI_RELATIVE_TO.BOTTOM_CENTER))
	_money.setTextFormat("[fa_center][fa_middle]");
	
}

main();