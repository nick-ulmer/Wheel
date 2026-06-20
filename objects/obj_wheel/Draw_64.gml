var _cw = 200;
var _ch = 200;

if (!surface_exists(wheel_surf)) {
    wheel_surf = surface_create(_cw, _ch);
}

gpu_push_state();
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one);

surface_set_target(wheel_surf);

draw_set_colour(c_black);
draw_set_alpha(1);
draw_rectangle(0, 0, _cw, _ch, false);

draw_circle(20, 20, 10, true);
wheel_panel();

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
surface_reset_target();
gpu_pop_state();