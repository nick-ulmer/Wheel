max_timer = 60 * 1; // seconds of waiting til next spinning
timer = max_timer;

spinning = false;
growing = false;

original_image_xscale = image_xscale;
growth_rate = original_image_xscale / 15;
