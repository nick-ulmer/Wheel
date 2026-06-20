//if spin_timer <= 0 return; // GUARD CLAUSE; 
//spin_timer --;
if spin_speed <= 0 return; // GUARD CLAUSE; 
spin_speed -= spin_friction;

current_probability += spin_speed/100;

show_debug_message(current_probability);
show_debug_message(choice_index);


var _probs = get_ability_probabilities();
if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't spin wheel if no enabled abilities! 

var _mapped = ((current_probability mod 1) + 1) mod 1;
var _cumulative = 0;
for (var _i = 0; _i < array_length(_probs); _i++) {
    _cumulative += _probs[_i];
    if (_mapped <= _cumulative) {
        choice_index = _i;
        show_debug_message("Rolled: " + string(current_probability) + " | Chose: " + abilities[_i].name + " (index " + string(_i) + ")");
        break;
    }
}