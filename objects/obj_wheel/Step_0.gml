if spin_speed <= 0 {
	if (!ability_activated) {
		var _abilities = get_enabled_abilities();
		_abilities[choice_index].activated();
		ability_activated = true;
		show_debug_message("ability activated!: " + _abilities[choice_index].name);
	}
	if CONSTANT_SPIN_MODE current_probability += spin_speed_max/100;
	return;	
} // GUARD CLAUSE; 


spin_speed -= spin_friction;

current_probability += spin_speed/100;

var _probs = get_ability_probabilities();
if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't spin wheel if no enabled abilities! 

var _mapped = ((current_probability mod 1) + 1) mod 1;
var _cumulative = 0;
for (var _i = 0; _i < array_length(_probs); _i++) {
    _cumulative += _probs[_i];
    if (_mapped <= _cumulative) {
        choice_index = _i;
        show_debug_message("Rolled: " + string(current_probability) + " | Chose: " + global.abilities[_i].name + " (index " + string(_i) + ")");
        break;
    }
}