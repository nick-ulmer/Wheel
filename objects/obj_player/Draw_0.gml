/// @description draw_self();
image_speed = abs(h_move) / 1.5;

/*if (invincibility_frames > 0) {
	// Enable GPU fog, set color to white, and start/end distances to 0
    gpu_set_fog(true, c_white, 0, 0);
    
    // Draw the sprite
    draw_self();
    
    // Disable GPU fog so the rest of your game renders normally
    gpu_set_fog(false, c_white, 0, 0);
} else {
	draw_self();
}*/

draw_self();
if (invincibility_frames > 0 && flash_timer mod 20 < 10) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
    gpu_set_blendmode(bm_normal);
}
