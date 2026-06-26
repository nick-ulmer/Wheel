function Ability(_name, _cost, _text = "", _activated = function() {}) constructor {
	self.name =_name;
	self.cost = _cost;
	self.text = _text;
	self.activated = _activated;
	
	// Attributes that save and load
	self.weight = 1;
	self.enabled = true;
	self.bought = false;
}

global.abilities = [
	new Ability("High Gravity", 10, "High Gravity - Fall faster than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateHigh;
		}}
	}),
	new Ability("Low Gravity", 50, "Low Gravity - Fall slower than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateLow;
		}}
	}),
	new Ability("Speed Boost", 40, "Speed Boost - Roll faster than normal", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			speed_multiplier = 2;
		}}
	}),
	new Ability("Explode", 20, "Explode - Self explanatory (or maybe not...)", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			damage(1, 0);
		}}
	}),
	new Ability("Slippery", 20, "Slippery - Slippy slippy slippy", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			friction_multiplier = 0.1;
		}}
	}),
	new Ability("Increased Handling", 55, "Handling - Better control", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			friction_multiplier = 5;
			air_handling_multiplier = 4;
		}}
	}), 
	new Ability("Invincibility", 100, "Handling - Better control", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			invincibility_frames = invincibility_frames_max * 10; // 10 seconds of invincibility
		}}
	}), 
	new Ability("Health Boost", 75, "Handling - Better control", function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;} // set alarm for 5 seconds
		if (instance_exists(obj_player)) { with (obj_player) {
			hp ++;
		}}
	})
]

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