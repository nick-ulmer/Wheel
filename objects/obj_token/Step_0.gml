// @description Check player collision and do spinning
if place_meeting(x, y, obj_player) {
	value = 0;
	switch (image_index) {
		case 0: value = 1; break;
		case 1: value = 10; break;
		case 2: value = 25;break; 
		case 3: value = 50; break; 
		default: value = 1; break; 
	}
	global.add_tokens(value);
	instance_destroy(self);
	
	var _val = floor(random(1)*4);
	show_debug_message(_val)
	switch (_val){
		case 0: audio_play_sound(token1_snd,1,false);break;
		case 1: audio_play_sound(token2_snd,1,false);break;
		case 2: audio_play_sound(token3_snd,1,false);break; 
		case 3: audio_play_sound(token4_snd,1,false);break; 
	}
	
	return
}

timer --
if (timer <= 0) {
	spinning = !spinning;
	timer = max_timer;
}


if (spinning) {
	timer = max_timer;
	if (growing) {
		image_xscale += growth_rate;
	} else {
		image_xscale -= growth_rate;
	}
	
	if (image_xscale <= 0) {
		growing = true;
	} else if image_xscale >= original_image_xscale {
		growing = false;
		spinning = false;
	}
}