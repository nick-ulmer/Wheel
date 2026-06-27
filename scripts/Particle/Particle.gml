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
part_type_shape(_p, pt_shape_cloud);
part_type_size(_p, 0.4, 0.8, -0.05, 0);
part_type_color2(_p, c_ltgray, c_dkgray);
part_type_alpha2(_p, 0.7, 0.3);
part_type_speed(_p, 0.5, 1.5, -0.1, 0);
part_type_direction(_p, 160, 200, 0, 0);
part_type_gravity(_p, 0.1, 270);
part_type_life(_p, 10, 20);

global.fx_slip = part_type_create();
_p = global.fx_slip;
part_type_shape(_p, pt_shape_cloud);
part_type_size(_p, 0.4, 0.8, -0.05, 0);
part_type_color2(_p, c_aqua, c_dkgray);
part_type_alpha2(_p, 0.7, 0.3);
part_type_speed(_p, 0.5, 1.5, -0.1, 0);
part_type_direction(_p, 160, 200, 0, 0);
part_type_gravity(_p, 0.1, 270);
part_type_life(_p, 10, 20);

global.fx_explode = part_type_create();
_p = global.fx_explode;
part_type_shape(_p, pt_shape_explosion);
part_type_size(_p, 0.5, 1.5, -0.05, 0);
part_type_color3(_p, c_yellow, c_orange, c_red);
part_type_alpha2(_p, 1, 0);
part_type_speed(_p, 2, 6, -0.2, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0.2, 270);
part_type_life(_p, 15, 30);

global.fx_health = part_type_create();
_p = global.fx_health;
part_type_sprite(_p, spr_health, false, false, false);
part_type_size(_p, 3, 5, 0, 0);
part_type_color2(_p, c_red, c_red);
part_type_alpha2(_p, 1, 0);
part_type_speed(_p, 0.5, 2, -0.05, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0.3, 90);
part_type_life(_p, 20, 40);

global.fx_invincible = part_type_create();
_p = global.fx_invincible;
part_type_shape(_p, pt_shape_star);
part_type_size(_p, 0.5, 1, 0, 0);
part_type_color2(_p, c_blue, c_aqua);
part_type_alpha2(_p, 1, 0);
part_type_speed(_p, 0.5, 2, -0.05, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0.3, 90);
part_type_life(_p, 20, 40);

global.fx_grav_up = part_type_create();
_p = global.fx_grav_up;
part_type_sprite(_p, spr_gravity_up, false, false, false);
part_type_size(_p, 3, 4, -0.05, 0);
part_type_color2(_p, c_red, c_red);
part_type_alpha2(_p, 0.7, 0.3);
part_type_speed(_p, 0.5, 1.5, -0.1, 0);
part_type_direction(_p, 160, 200, 0, 0);
part_type_gravity(_p, 0.1, 270);
part_type_life(_p, 10, 20);

global.fx_grav_down = part_type_create();
_p = global.fx_grav_down;
part_type_sprite(_p, spr_gravity_down, false, false, false);
part_type_size(_p, 3, 4, -0.05, 0);
part_type_color2(_p, c_aqua, c_aqua);
part_type_alpha2(_p, 0.7, 0.3);
part_type_speed(_p, 0.5, 1.5, -0.1, 0);
part_type_direction(_p, 160, 200, 0, 0);
part_type_gravity(_p, 0.1, 270);
part_type_life(_p, 10, 20);

global.fx_speed_up = part_type_create();
_p = global.fx_speed_up;
part_type_shape(_p, pt_shape_star);
part_type_size(_p, 0.4, 0.8, -0.05, 0);
part_type_color2(_p, c_yellow, c_yellow);
part_type_alpha2(_p, 0.7, 0.3);
part_type_speed(_p, 0.5, 1.5, -0.1, 0);
part_type_direction(_p, 160, 200, 0, 0);
part_type_gravity(_p, 0.1, 270);
part_type_life(_p, 10, 20);
