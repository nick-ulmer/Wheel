function Ability(_name, _weight, _text = "", _activated = function() {}) constructor {
	self.name =_name;
	self.text = _text;
	self.cost = 50;
	self.activated = _activated;
	
	// Attributes that save and load
	self.weight = _weight;
	self.enabled = true;
	self.bought = false;
}

global.abilities = [
	new Ability("High Gravity", 1, "High Gravity - Fall faster than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateHigh;
		}}
	}),
	new Ability("Low Gravity", 1, "Low Gravity - Fall slower than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateLow;
		}}
	}),
	new Ability("Speed Boost", 1, "Speed Boost - Roll faster than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			speed_multiplier = 2;
		}}
	}),
	new Ability("Explode", 1, "Explode - Self explanatory (or maybe not...)", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			damage(1, 0);
		}}
	}),
	new Ability("Slippery", 1, "Slippery - Slippy slippy slippy", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			friction_multiplier = 0.1;
		}}
	}),
	new Ability("Increased Handling", 1, "Handling - Better control", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			friction_multiplier = 0.1;
		}}
	})
]
show_debug_message(global.abilities[0].text);
global.abilities[0].bought = true;
global.abilities[0].cost = 20;
global.abilities[1].bought = true;
global.abilities[1].cost = 75;

function save_abilities() {
    var _data = {};
    for (var i = 0; i < array_length(global.abilities); i++) {
        var _a = global.abilities[i];
        _data[$ _a.name] = {
            weight:  _a.weight,
            enabled: _a.enabled,
            bought:  _a.bought
        };
    }
    var _json = json_stringify(_data);
    var _file = file_text_open_write("abilities.sav");
    file_text_write_string(_file, _json);
    file_text_close(_file);
    show_debug_message("Abilities saved");
}

function load_abilities() {
    if (!file_exists("abilities.sav")) {
        show_debug_message("No save file found, using defaults");
		global.save_abilities();
        return;
    }
    var _file = file_text_open_read("abilities.sav");
    var _json = file_text_read_string(_file);
    file_text_close(_file);
    
    var _data = json_parse(_json);
    for (var i = 0; i < array_length(global.abilities); i++) {
        var _a = global.abilities[i];
        if (struct_exists(_data, _a.name)) {
            var _saved = _data[$ _a.name];
            _a.weight  = _saved.weight;
            _a.enabled = _saved.enabled;
            _a.bought  = _saved.bought;
        }
    }
    show_debug_message("Abilities loaded");
}
load_abilities();