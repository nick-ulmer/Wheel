/// @description 

current_probability = 0;
choice_index = 0;


// obj_wheel Create Event
abilities = [new Ability("Fireball", 1)]; // test ability

build_ability_panel = function() {
    if (ui_exists("Panel_Abilities")) {
        ui_get("Panel_Abilities").destroy();
        show_debug_message("Panel rebuilt");
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
    }
	
    var _add_group = new UIGroup("Group_Wheel", 0, 40, 480, 50, undefined);
}

wheel_panel = function() {
	
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