/// @description Draw wheel
draw_circle(x, y, 100, true);

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
draw_vertex(x, y);
for (var _a = _slice_start; _a <= _slice_end; _a++) {
    draw_vertex(x + cos(degtorad(_a)) * 100, y - sin(degtorad(_a)) * 100);
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
    draw_line(x, y, x + cos(_rad) * 100, y - sin(_rad) * 100);
    draw_set_color(c_yellow);
    _angle += _slice;
}

// Draw needle
var _needle_angle = degtorad(current_probability * 360);
draw_set_color(c_red);
draw_line(x, y, x + cos(_needle_angle) * 100, y - sin(_needle_angle) * 100);
draw_set_color(c_yellow);