/// @description Perform Checks & Do Physics
if (hp <= 0) { return; } // Guard Clause; 
// Probably replace guard clause with instance destroy then return
// And create a new dead player object probably 

// Remove invincibility frame if above 0
if (invincibility_frames > 0) { invincibility_frames --; flash_timer ++; }

if (knockback_timer > 0) {
	knockback_timer --;
} else {
	xs[force.damaged] -= sign(xs[force.damaged]) * 0.5;
	ys[force.damaged] -= sign(ys[force.damaged]) * 0.5;
	if (abs(xs[force.damaged]) <= 1) xs[force.damaged] = 0;
	if (abs(ys[force.damaged]) <= 1) ys[force.damaged] = 0;
}

control_check();

spd = h_move*8 * speed_multiplier;
if xs[force.move] > spd {
    xs[force.move] -= .1*friction_multiplier + ((scr_solid(x,y+1))*.5)+(xs[force.move] > 0 && spd < 0)*.4;
    if xs[force.move] < spd xs[force.move] = spd;
} else if xs[force.move] < spd {
    xs[force.move] += .1*friction_multiplier + ((scr_solid(x,y+1))*.5)+(xs[force.move] < 0 && spd > 0)*.4;
    if xs[force.move] > spd xs[force.move] = spd;
}

// Jump Code
if scr_solid(x,y-1) { // Check for ceiling
	ys[force.move] = 0; 
	jumpTime = 0;
	jumpTimer = 0;
}
if scr_solid(x,y+1) { // on ground
	ys[force.move] = 0;
	ys[force.grav] = 0;
	ypwr = 0;
	jumpTime = jumpTimeMax;
	jumpTimer = jumpTimerMax;
	if (space_key && !space_key_pressed) {
	    y-=1;
		gravEnable = false;
	    space_key_pressed = true;
		ys[force.move] = -jspd; // Hold for one tick. 
	}
} else { // in air
	if jumpTimer > 0 && space_key && !space_key_pressed {
	    y-=1;
	    space_key_pressed = true;
	    jumpTime=jumpTimeMax;
	}
	jumpTimer -= 1;
	if (space_key && jumpTime > 0) {
	    jumpTime -= 1;
	    jumpTimer = 0;
	    ys[force.move] = -jspd;
	} else {
	    jumpTime = 0;
	}
	//if space_key spaceTimer += 1 else spaceTimer = 0; // MIGRATED TO JUMP CHECK
	if ys[force.move] < 0 ys[force.move] += 1; // Gradually decrease the vertical. Gravity starts when it hits 0. 
}
// end of ground check code

if !scr_solid(x,y+1) {
	if space_key spaceTimer += 1 
	else spaceTimer = 0;
}

if space_key && !space_key_pressed && spaceTimer > spaceTimerMax {space_key_pressed = true;} 
else if (!space_key) {space_key_pressed = false;}


if !scr_solid(x,y+1) {
    if space_key && jumpTime > 0 gravEnable = false;
    if ys[force.move] == 0 gravEnable = true;
}


// Player Gravity
if scr_solid(x,y+1) || gravEnable == false {
    ys[force.grav] = 0;
} else if jumpTime != jumpTimeMax {
    if ys[force.grav] < gravMax && gravEnable ys[force.grav] += gravRate;
}


collision_check();
update_position();