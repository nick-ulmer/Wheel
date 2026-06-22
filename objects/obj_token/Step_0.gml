if place_meeting(x, y, obj_player) {
	value = 0;
	switch (image_index) {
		case 0: value = 1; break;
		case 1: value = 10; break;
		case 2: value = 25;	break; 
		case 3: value = 50; break; 
		default: value = 1; break; 
	}
	gm.add_tokens(value);
	instance_destroy(self);
}