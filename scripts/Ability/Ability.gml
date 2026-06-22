function Ability(_name, _weight, _activated = function() {}) constructor {
	self.name =_name;
	self.weight = _weight;
	self.enabled = true;
	self.activated = _activated;
}

global.abilities = [
	new Ability("High Gravity", 1, function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;}
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateHigh;
		}}
	}),
	new Ability("Low Gravity", 1, function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;}
		if (instance_exists(obj_player)) { with (obj_player) {
			gravRate = gravRateLow;
		}}
	}),
	new Ability("Speed Boost", 1, function() {
		with (obj_wheel) {alarm[0] = game_get_speed(gamespeed_fps) * 5;}
		if (instance_exists(obj_player)) { with (obj_player) {
			speed_multiplier = 2;
		}}
	}),
	new Ability("Explode", 1),
	new Ability("Slippery", 1)
]