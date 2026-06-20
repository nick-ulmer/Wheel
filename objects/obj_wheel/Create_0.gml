/// @description 

current_probability = 0;
choice_index = 0;

// obj_wheel Create Event
abilities = [
	new Ability("High Gravity", 1),
	new Ability("Low Gravity", 1),
	new Ability("Speed Boost", 1),
	new Ability("Explode", 1),
	new Ability("Slippery", 1)
];

wheel_surf = -1;
size = 200; // width/height of surface space

build_ability_panel = function() {
    if (ui_exists("Panel_Abilities")) {
        ui_get("Panel_Abilities").destroy();
        show_debug_message("Panel rebuilt");
    }
	
	if (!surface_exists(wheel_surf)) {
	    wheel_surf = surface_create(200, 200);
	}

    var _panel = new UIPanel("Panel_Abilities", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_LEFT);
	_panel.setResizable(true).setImageAlpha(0.75).setTitle("Ability Wheel - Press \"E\" to Spin").setTitleFormat("[c_black][fa_top]");
	
	// Check Mark Buttons
	var _b = [10, 40, 100, 30];
	var _i = 0;
	// var _j is UNUSED PLACEHOLDER
	for (var _j = 0; _i < array_length(abilities); _i++) {
		var _button = _panel.add(new UICheckbox(abilities[_i].name, _b[0], _b[1]+40*_i, abilities[_i].name, grey_boxCheckmark, grey_box, abilities[_i].enabled, UI_RELATIVE_TO.TOP_LEFT));
		_button
			.setTextFormatFalse("[c_black][fa_left]")
			.setTextFormatTrue("[c_black][fa_left]")
			.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {
		        var _checked = ui_get(obj_wheel.abilities[_i].name).getValue();
		        show_debug_message("Checkbox " + string(_i) + " is: " + string(_checked));
				obj_wheel.abilities[_i].enabled = _checked;
				obj_wheel.choice_index = 0;
		    }));
	}
	_i++;
	
	// THE WHEEL!!!
    var _wheel_group = new UIGroup("Group_Wheel", 0, 0, 200, 200, undefined, UI_RELATIVE_TO.BOTTOM_CENTER);
	var _canvas = new UICanvas("Wheel_Canvas", 0, 0, size, size, wheel_surf, UI_RELATIVE_TO.BOTTOM_CENTER)
	_wheel_group.add(_canvas);
	_panel.add(_wheel_group);
	
	
	_panel.setMinHeight(200 + _i*40).setMinWidth(250);
}

// DRAWS the wheel within the context of a surface
wheel_panel = function() {
	var _x = 100;
	var _y = 100;
	draw_circle(_x, _y, 100, true);

	// Draw filled slice for chosen ability
	var _probs = get_ability_probabilities();
	if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't draw if no enabled abilities
	
	var _cumulative = 0;
	for (var _i = 0; _i < choice_index; _i++) {
	    _cumulative += _probs[_i];
	}
	var _slice_start = _cumulative * 360;
	var _slice_end = _slice_start + (_probs[choice_index] * 360);

	draw_set_color(c_orange);
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(_x, _y);
	for (var _a = _slice_start; _a <= _slice_end; _a++) {
	    draw_vertex(_x + cos(degtorad(_a)) * 100, _y - sin(degtorad(_a)) * 100);
	}
	draw_primitive_end();
	draw_set_color(c_yellow);

	// Draw dividing lines
	var _count = array_length(_probs);
	var _angle = 0;
	for (var _i = 0; _i < _count; _i++) {
	    var _slice = _probs[_i] * 360;
	    var _rad = degtorad(_angle);
	    draw_set_color(c_black);
	    draw_line(_x, _y, _x + cos(_rad) * 100, _y - sin(_rad) * 100);
	    draw_set_color(c_yellow);
	    _angle += _slice;
	}

	// Draw needle
	var _needle_angle = degtorad(current_probability * 360);
	draw_set_color(c_red);
	draw_line(_x, _y, _x + cos(_needle_angle) * 100, _y - sin(_needle_angle) * 100);
	draw_set_color(c_yellow);
}

build_ability_panel();

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
	
	for (var _i = 0; _i < array_length(abilities); _i++) {
		if abilities[_i].enabled {
			array_push(_abilities, abilities[_i]);
		}
	}
	
	return _abilities;
}