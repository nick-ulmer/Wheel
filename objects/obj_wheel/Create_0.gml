/// @description 
CONSTANT_SPIN_MODE = true;
wheel_alpha = 0.5;

if (room == rm_shop) {
	CONSTANT_SPIN_MODE = false;
}

min_entropy = 10;
entropy = 0; // Initialized at bottom of create script
spins_left = 10;

current_probability = 0;
choice_index = 0;

var _spin_seconds = 3;
if CONSTANT_SPIN_MODE _spin_seconds = 1;
spin_friction = 0.05;

spin_speed_max = spin_friction * _spin_seconds * game_get_speed(gamespeed_fps);
spin_speed = 0; // live variable
ability_activated = true; // Also live

wheel_red = #c30303;
wheel_black = #1c1c1c;
wheel_green = #06c313;

function update_entropy(_update_text = true) {
    var _probs = get_ability_probabilities();
	if (array_length(_probs) == 0) { entropy = 0; return; }
	
    var _entropy = 0;
    for (var i = 0; i < array_length(_probs); i++) {
        if (_probs[i] > 0) {
            _entropy += _probs[i] * log2(_probs[i]);
        }
    }
	entropy = -_entropy
	if _update_text {
		ui_get("Entropy_Text")
			.setText("Entropy: " + string(entropy))
	}
}

function reset_wheel() {
	obj_wheel.choice_index = 0;
	obj_wheel.spin_speed = 0;
	obj_wheel.current_probability = 0;
	update_entropy();
}

function set_ability_enable(_index, _is_enabled) {
	global.abilities[_index].enabled = _is_enabled;	
	global.abilities[_index].weight = 1;	
	ui_get(global.abilities[_index].name)
		.setTextTrue(global.abilities[_index].name + " " + string(global.abilities[_index].weight))
	reset_wheel();
}

function set_ability_weight(_index, _amount, _add = true) {
	var _val = _amount;
	if _add { _val = global.abilities[_index].weight + _amount; }
	_val = clamp(_val, 1, infinity);
	global.abilities[_index].weight = _val;
	reset_wheel();
	
	ui_get(global.abilities[_index].name)
		.setTextTrue(global.abilities[_index].name + " " + string(global.abilities[_index].weight))
}

function buy_ability(_index) {
	global.abilities[_index].bought = true;
	var _cost = global.abilities[_index].cost;
	add_tokens(-_cost);
}

// Returns an array of the probabilities given current ability weights. 
function get_ability_probabilities() {
    //var _abilities = self.abilities;
    var _abilities = self.get_enabled_abilities();
    var _count = array_length(_abilities);
    var _result = [];
    
    // Sum
    var _total = 0;
    for (var _i = 0; _i < _count; _i++) {
        _total += _abilities[_i].weight;
    }
    
    // Probability array
    for (var _i = 0; _i < _count; _i++) {
        array_push(_result, _abilities[_i].weight / _total);
    }
    
    return _result;
}

function get_enabled_abilities() {
	var _abilities = [];
	
	for (var _i = 0; _i < array_length(global.abilities); _i++) {
		if global.abilities[_i].enabled && global.abilities[_i].bought {
			array_push(_abilities, global.abilities[_i]);
		}
	}
	return _abilities;
}



wheel_surf = -1;
size = 256; // width/height of surface space
rad = size/2 - 13;

build_ability_panel = function() {
    if (ui_exists("Panel_Abilities")) {
        ui_get("Panel_Abilities").destroy();
        show_debug_message("Panel rebuilt");
    }
	
	/*if (!surface_exists(wheel_surf)) {
	    wheel_surf = surface_create(size, size);
	}*/

    var _panel = new UIPanel("Panel_Abilities", 50, 50, 300, 500, grey_panel, UI_RELATIVE_TO.TOP_LEFT);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Ability Wheel - Press \"E\" to Spin").setTitleFormat("[c_black][fa_top]");
	
	// Check Mark Buttons
	var _b = [10, 40, 100, 30];
	var _i = 0; // Used to placehold the vertical position on the panel.
	for (var _j = 0; _j < array_length(global.abilities); _j++) {
		if (!global.abilities[_j].bought) { show_debug_message(global.abilities[_j].name);continue; }
		var _add =		_panel.add(new UIButton(global.abilities[_i].name+"_add", _b[0], _b[1]+40*_i, _b[1], _b[1], "+", blue_button00));
		_add.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {obj_wheel.set_ability_weight(_i, 1)}));
		var _subtract = _panel.add(new UIButton(global.abilities[_i].name+"_subtract", _b[0]+50, _b[1]+40*_i, _b[1], _b[1], "-", blue_button00));
		_subtract.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {obj_wheel.set_ability_weight(_i, -1)}));
		
		var _button = _panel.add(new UICheckbox(global.abilities[_j].name, _b[0]+100, _b[1]+40*_i, "", grey_boxCheckmark, grey_box, global.abilities[_i].enabled, UI_RELATIVE_TO.TOP_LEFT));
		_button
			.setTextFormatFalse("[c_black][fa_left]")
			.setTextFormatTrue("[c_black][fa_left]")
			.setTextFalse(global.abilities[_j].name)
			.setTextTrue(global.abilities[_j].name + " " + string(global.abilities[_j].weight))
			.setCallback(UI_EVENT.LEFT_RELEASE, method({_j}, function() {
		        var _checked = ui_get(global.abilities[_j].name).getValue();
		        show_debug_message("Checkbox " + string(_j) + " is: " + string(_checked));
				obj_wheel.set_ability_enable(_j, _checked);
			}));
		_i++;
	}
	show_debug_message(string(_i));
	_i++;
	
	// THE WHEEL!!!
    /*var _wheel_group = new UIGroup("Group_Wheel", 0, 0, size, size, undefined, UI_RELATIVE_TO.BOTTOM_LEFT);
	var _canvas = new UICanvas("Wheel_Canvas", 0, 0, size, size, wheel_surf, UI_RELATIVE_TO.BOTTOM_LEFT)
	_wheel_group.add(_canvas);
	_panel.add(_wheel_group);*/
	
	// Entropy Text
	var _entropy_text = new UIText("Entropy_Text", 0, 0, "Entropy: " + string(entropy), UI_RELATIVE_TO.BOTTOM_RIGHT);
	_panel.add(_entropy_text).setTextFormat("[c_black][fa_right][fa_bottom]");
	
	var _min_entropy_text = new UIText("Min_Entropy_Text", 0, -20, "Minimum Entropy: " + string(min_entropy), UI_RELATIVE_TO.BOTTOM_RIGHT);
	_panel.add(_min_entropy_text).setTextFormat("[c_black][fa_right][fa_bottom]");
	
	var _save = _panel.add(new UIButton("Save_Button", 0, 0, 30, 30, "S", blue_button00, UI_RELATIVE_TO.BOTTOM_CENTER));
		_save.setCallback(UI_EVENT.LEFT_RELEASE, method({}, function() {save_abilities();}));
	
	var _load = _panel.add(new UIButton("Load_Button", 0, -30, 30, 30, "L", blue_button00, UI_RELATIVE_TO.BOTTOM_CENTER));
		_load.setCallback(UI_EVENT.LEFT_RELEASE, method({}, function() {load_abilities(); obj_wheel.reset_wheel(); obj_wheel.build_ability_panel();}));
	
	_panel.setMinHeight(200 + _i*40).setMinWidth(300);
}

// DRAWS the wheel within the context of a surface
the_wheel = function() {
	var _x = 128;
	var _y = 128;
	draw_sprite(spr_wheel, 0, _x, _y);
	
	var rot_offset = 0 - current_probability * 360;
	
	var _probs = get_ability_probabilities();
	if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't draw if no enabled abilities

	

	// Draw dividing lines
	var _count = array_length(_probs);
	var _angle = 0;
	for (var _i = 0; _i < _count; _i++) {
	    var _slice = _probs[_i] * 360;
	    var _rad = degtorad(_angle);
		
	    _angle += _slice;
		
		if (_i mod 2 == 0)
			draw_set_color(wheel_red);
		else
			draw_set_color(wheel_black);
		draw_slice(_x, _y, _angle-_slice + rot_offset, _angle + rot_offset);
		
		//var _mid_angle = _angle - _slice * 0.5 - rot_offset;
		draw_set_color(c_white);
		draw_set_halign(fa_left); draw_set_valign(fa_middle);
		draw_text_transformed(_x, _y, "  "+global.abilities[_i].name, 1, 1, ((_angle + _angle - _slice)/2) + rot_offset);
		draw_set_halign(fa_left); draw_set_valign(fa_top);
	}
	
	draw_set_color(wheel_green);
	draw_slice(_x, _y, 0 + rot_offset, _probs[0]*360 + rot_offset);
	
	if spin_speed > 0 {
		// Draw filled slice for chosen ability
		var _cumulative = 0;
		for (var _i = 0; _i < choice_index; _i++) {
		    _cumulative += _probs[_i];
		}
		draw_set_color(c_white);
		draw_slice(_x, _y, _cumulative*360 + rot_offset, _cumulative*360 + _probs[choice_index]*360 + rot_offset, 0.25);
		draw_set_color(c_white);
	}
	
	draw_set_color(c_white);
	draw_set_halign(fa_left); draw_set_valign(fa_middle);
	draw_text_transformed(_x, _y, "  "+global.abilities[0].name, 1, 1, ((_probs[0]*360)/2) + rot_offset);
	draw_set_halign(fa_left); draw_set_valign(fa_top);
	
	
	
	
	
	// Draw needle
	var _needle_angle = degtorad(current_probability * 360);
	draw_set_color(c_orange);
	//draw_line(_x, _y, _x + cos(_needle_angle) * rad, _y - sin(_needle_angle) * rad);
	
	draw_set_color(c_white);
	draw_sprite(spr_pointer, 0, _x, _y);
}

draw_slice = function(_x, _y, _slice_start, _slice_end, _alpha = 1) {
	draw_primitive_begin(pr_trianglefan);
	draw_vertex_color(_x, _y, draw_get_color(), _alpha);
	for (var _a = _slice_start; _a <= _slice_end; _a++) {
		draw_vertex_color(_x + cos(degtorad(_a)) * rad, _y - sin(degtorad(_a)) * rad, draw_get_color(), _alpha);
	}
	draw_primitive_end();
}

// Initialize Entropy
update_entropy(false);
if (room == rm_shop) { build_ability_panel(); }


