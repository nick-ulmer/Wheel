/// @description Spin the Wheel

//show_debug_message(abilities);

if spin_speed > 0 return;
//if spin_timer > 0 return;

var _probs = get_ability_probabilities();
if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't spin wheel if no enabled abilities! 


current_probability = random(1);

spin_speed = spin_speed_max;
