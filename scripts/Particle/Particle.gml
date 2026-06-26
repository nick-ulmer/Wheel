global.fx_sys = part_system_create();

global.fx_hurt = part_type_create();
var _p = global.fx_hurt;
part_type_shape(_p, pt_shape_cloud);
part_type_size(_p, 0.1, 0.5, 0, 0);
part_type_color2(_p, c_red, c_orange);
part_type_alpha2(_p, 1, 0);
part_type_speed(_p, 2, 5, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_life(_p, 20, 40);

global.fx_run = part_type_create();
_p = global.fx_run;
part_type_shape(_p, pt_shape_circle);
part_type_size(_p, 0.1, 0.5, 0, 0);
part_type_color2(_p, c_yellow, c_orange);
part_type_alpha2(_p, 1, 0);
part_type_speed(_p, 1, 3, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_life(_p, 20, 40);