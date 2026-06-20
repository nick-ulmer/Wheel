/// @description 

current_probability = 0;
choice_index = 0;


// obj_wheel Create Event
abilities = [new Ability("Fireball", 1)]; // test ability

wheel_surf = -1;
size = 200;

build_ability_panel = function() {
    if (ui_exists("Panel_Abilities")) {
        ui_get("Panel_Abilities").destroy();
        show_debug_message("Panel rebuilt");
    }
	
	if (!surface_exists(wheel_surf)) {
	    wheel_surf = surface_create(200, 200);
	}

    var _panel = new UIPanel("Panel_Abilities", 0, 0, 500, 500, grey_panel, UI_RELATIVE_TO.MIDDLE_LEFT);

    // Add/Remove row -------------------------------------------------------------------
    var _add_group = new UIGroup("Group_AddAbility", 0, 40, 480, 50, undefined);

    var _textbox = new UITextBox("TextBox_AbilityName", 0, 0, 200, 20, red_button00);
    _textbox.setPlaceholderText("Name...").setTextFormat("[c_white]");
    _add_group.add(_textbox);

    var _btn_add = new UIButton("Btn_AddAbility", 220, 0, 80, 40, "Add", blue_button00);
    _btn_add.setCallback(UI_EVENT.LEFT_RELEASE, function() {
        var _name = ui_get("TextBox_AbilityName").getText();
        show_debug_message("Add clicked. Text read: " + string(_name));
        if (_name != "") {
            array_push(obj_wheel.abilities, new Ability(_name, 1));
            show_debug_message("Ability added: " + _name + " | Total: " + string(array_length(obj_wheel.abilities)));
            obj_wheel.build_ability_panel();
        } else {
            show_debug_message("Add clicked but name was empty");
        }
    });
    _add_group.add(_btn_add);

    var _btn_remove = new UIButton("Btn_RemoveAbility", 300, 0, 100, 40, "Remove", blue_button00);
    _btn_remove.setCallback(UI_EVENT.LEFT_RELEASE, function() {
        var _name = ui_get("TextBox_AbilityName").getText();
        show_debug_message("Remove clicked. Text read: " + string(_name));
        var _found = false;
        for (var i = array_length(obj_wheel.abilities) - 1; i >= 0; i--) {
            if (obj_wheel.abilities[i].name == _name) {
                array_delete(obj_wheel.abilities, i, 1);
                show_debug_message("Ability removed: " + _name + "; Remaining: " + string(array_length(obj_wheel.abilities)));
                _found = true;
                break;
            }
        }
        if (!_found) show_debug_message("Remove: no ability found with name: " + string(_name));
        obj_wheel.build_ability_panel();
    });
    _add_group.add(_btn_remove);
    _panel.add(_add_group);

    // One group per ability -------------------------------------------------------------------
    var _row_h = 50;
    show_debug_message("Building rows for " + string(array_length(abilities)) + " abilities");
	
	var _end_y = 0;
    for (var i = 0; i < array_length(abilities); i++) {
        var _ability = abilities[i];
        var _i = i;
        var _y = 100 + i * _row_h;

        show_debug_message("Row " + string(i) + ": " + _ability.name + " weight=" + string(_ability.weight));

        var _group = new UIGroup(string($"Group_Ability_{i}"), 0, _y, 480, _row_h, undefined);

        var _name_txt = new UIText(string($"Text_Name_{i}"), 0, 0, _ability.name);
		_name_txt.setTextFormat("[c_black][fa_left]");
        _group.add(_name_txt);

        var _btn_dec = new UIButton(string($"Btn_Dec_{i}"), 150, 0, 40, 40, "-", blue_button00);
        _btn_dec.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {
            var _old = obj_wheel.abilities[_i].weight;
            obj_wheel.abilities[_i].weight = max(1, obj_wheel.abilities[_i].weight - 1);
            show_debug_message("Dec clicked [" + string(_i) + "]: " + string(_old) + " -> " + string(obj_wheel.abilities[_i].weight));
            obj_wheel.build_ability_panel();
        }));
        _group.add(_btn_dec);

        var _weight_txt = new UIText(string($"Text_Weight_{i}"), 200, 0, string(_ability.weight));
		_weight_txt.setTextFormat("[c_black][fa_left]");
        _group.add(_weight_txt);

        var _btn_inc = new UIButton(string($"Btn_Inc_{i}"), 250, 0, 40, 40, "+", blue_button00);
        _btn_inc.setCallback(UI_EVENT.LEFT_RELEASE, method({_i}, function() {
            obj_wheel.abilities[_i].weight += 1;
            show_debug_message("Inc clicked [" + string(_i) + "]: new weight=" + string(obj_wheel.abilities[_i].weight));
            obj_wheel.build_ability_panel();
        }));
        _group.add(_btn_inc);

        _panel.add(_group);
		_end_y = _y
    }
	
    var _wheel_group = new UIGroup("Group_Wheel", 0, 0, 200, 200, undefined, UI_RELATIVE_TO.BOTTOM_CENTER);
	var _canvas = new UICanvas("Wheel_Canvas", 0, 0, size, size, wheel_surf, UI_RELATIVE_TO.BOTTOM_CENTER)
	_wheel_group.add(_canvas);
	_panel.add(_wheel_group);
	
}

wheel_panel = function() {
	var _x = 100;
	var _y = 100;
	draw_circle(_x, _y, 100, true);

	// Draw filled slice for chosen ability
	var _probs = get_ability_probabilities();
	var _cumulative = 0;
	for (var i = 0; i < choice_index; i++) {
	    _cumulative += _probs[i];
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
	for (var i = 0; i < _count; i++) {
	    var _slice = _probs[i] * 360;
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


function get_ability_probabilities() {
    var _abilities = self.abilities;
    var _count = array_length(_abilities);
    var _result = [];
    
    // Sum
    var _total = 0;
    for (var i = 0; i < _count; i++) {
        _total += _abilities[i].weight;
    }
    
    // Probability array
    for (var i = 0; i < _count; i++) {
        array_push(_result, _abilities[i].weight / _total);
    }
    
    return _result;
}