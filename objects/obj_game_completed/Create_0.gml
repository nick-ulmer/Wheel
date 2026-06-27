
main_menu = function() {
	var _size = getUIRelScale(3);
	var _btn_w = getUIRelScale(1.5);
	var _btn_h = getUIRelScale(0)*0.75;
	var _panel = new UIPanel("Completed_Panel", 0, 0, _size, _size, spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(0.75).setTitle("Game Over").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _done_text = _panel.add(new UIButton("Done", 0, 0, _btn_w, _btn_h, "Game Over: You win!", spr_button_disabled, UI_RELATIVE_TO.MIDDLE_CENTER));
	_done_text
		.setEnabled(false)
		.setTextFormat("[c_white]", true);
		
	var _main_menu = _panel.add(new UIButton("Done", 0, _btn_h+10, _btn_w, _btn_h, "Back to Main Menu", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_main_menu
		.setTextFormat("[c_white]", true)
		.setCallback(UI_EVENT.LEFT_RELEASE, function() {
			ui_get("Completed_Panel").destroy();
			room_goto(rm_main_menu);
		});
}
main_menu();