/// @description Spin the Wheel

//show_debug_message(abilities);

var _probs = get_ability_probabilities();
current_probability = random(1);

var _cumulative = 0;
for (var i = 0; i < array_length(_probs); i++) {
    _cumulative += _probs[i];
    if (current_probability <= _cumulative) {
        choice_index = i;
        show_debug_message("Rolled: " + string(current_probability) + " | Chose: " + abilities[i].name + " (index " + string(i) + ")");
        break;
    }
}