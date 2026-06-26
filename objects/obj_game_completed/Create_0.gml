
main_menu = function() {
	var _size = getUIRelScale(3);
	var _btn_w = getUIRelScale(1);
	var _btn_h = getUIRelScale(0)*0.75;
	var _panel = new UIPanel("Completed_Panel", 0, 0, _size, _size, spr_ui, UI_RELATIVE_TO.MIDDLE_CENTER);
	_panel.setResizable(false).setImageAlpha(0.75).setTitle("Game Over").setTitleFormat("[c_white][fa_top]").setTitleOffset({x:0,y:15});
	
	var _play_button = _panel.add(new UIButton("Done", 0, 0, _btn_w, _btn_h, "Game Over: You win!", spr_button, UI_RELATIVE_TO.MIDDLE_CENTER));
	_play_button
		.setEnabled(false)
		.setTextFormat("[c_white]", true);
}
main_menu();