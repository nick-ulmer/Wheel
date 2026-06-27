var _cw = 256;
var _ch = 256;

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
//draw_rectangle(0, 0, _cw, _ch, false);

//draw_circle(20, 20, 10, true);
the_wheel();

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
surface_reset_target();
gpu_pop_state();
// =================================================

if (room == rm_shop) {
	// In shop!
	
	var _offset = 50;
	var _w = display_get_gui_width()
	var _h = display_get_gui_height()
	draw_surface(wheel_surf, _offset, _h-_ch - _offset);
	
	return;
}

// ==================================================

draw_set_alpha(wheel_alpha);

var _offset = 50;
var _w = display_get_gui_width()
var _h = display_get_gui_height()
draw_surface(wheel_surf, _offset, _h-_ch - _offset);

draw_set_color(c_yellow);
draw_set_halign(fa_center); draw_set_valign(fa_bottom);
draw_text(_offset+_cw/2, _h-_ch - _offset, "\"E\" to Spin")
draw_set_color(c_white);
draw_set_halign(fa_left); draw_set_valign(fa_top);

draw_set_alpha(1);