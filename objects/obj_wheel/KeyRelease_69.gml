/// @description Spin the Wheel
if spin_speed > 0 return;

ability_activated = false;
show_debug_message("wheel spun!");

var _probs = get_ability_probabilities();
if (array_length(_probs) == 0) return; // GUARD CLAUSE: Don't spin wheel if no enabled abilities! 


current_probability = random(1);

spin_speed = spin_speed_max;
