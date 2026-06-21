/// @description Initialize & Functions

// Alterable physics! 
speed_multiplier = 1;
//gravRate = 0.8 by default. 

//image_speed = 0;
image_index = 0;

// Ledges on the ground
ledge = 4;
didLedge = false; // Was a ledge initiated on the previous script step? 
minStep = 1; // smallest size of ledge

// Base Movement
x_move = 0; // horizontal movement input after calculation
y_move = 0; // vertical movement input after calculation
spd = 8; // horizontal movement input

// Jump
jspd = 10; // The jumping velocity
jumpTimeMax = 10;
jumpTime = jumpTimeMax; // Time after initiating jump to hold jump button to go higher. 

jumpTimerMax = 500; //
jumpTimer = jumpTimerMax; // Time when spacebar can be held before a jump can be queued

jump_keyPressed = false;

spaceTimer = 0; // time before jump can't start if in air
spaceTimerMax = 0; 
space_key_pressed = false;

// Gravity
gravRateNormal = .8; // Normal gravity rate
gravRateHigh = 1.2; // High gravity rate
gravRateLow = .4; // Low gravity rate
gravRate = gravRateNormal; // Rate of gravity input increase. CAN BE IN-GAME CHANGED
gravMax = 30; // Maximum amount of falling speed
gravMove = 0; // Gravity input
gravEnable = true;

function control_check() {
	// Movement
	w_key = keyboard_check(ord("W"));
	a_key = keyboard_check(ord("A"));
	s_key = keyboard_check(ord("S"));
	d_key = keyboard_check(ord("D"));

	space_key = keyboard_check(vk_space);
	shift_key = keyboard_check(vk_shift);
	
	
	h_move = (d_key+(-a_key))*(1-.5*shift_key);
	v_move = (w_key+(-s_key));
}
control_check();

xs = []; ys = [];
enum force {
	move, // Voluntary movement from entity
	jump, // 
	grav, // Gravitational force to entity
total,num}
var _i = 0;
repeat(force.num) {xs[_i] = 0; ys[_i] = 0; _i++}
show_debug_message(xs);


function grav(_gravRate, _gravMax = 60) {
	if !scr_solid(x,y+1) {
		if (ys[force.grav] < _gravMax) ys[force.grav] += _gravRate;
	} else {
		//gravMove = 0;
		ys[force.grav] = 0;
	}
}

function add_forces() {
	xs[force.total] = 0; ys[force.total] = 0; 
	for (var _i=0; _i<array_length(xs)-1; _i++) {xs[force.total]+=xs[_i]}
	for (var _i=0; _i<array_length(ys)-1; _i++) {ys[force.total]+=ys[_i]}
	// Must be rounded or teleportation will happen with ledges for some reason
	xspd = round(xs[force.total]);
	yspd = round(ys[force.total]);
	//xspd=round(xspd); yspd=round(yspd);
}

function collision_check() {
	/// Collision/Interaction Horizontal
	var i = 0; // Ledge go up
	var j = 0;
	var k = 0; // Ledge go down

	add_forces();
	
	// If a ledge was just encountered: move up a step without changing physics
	if (didLedge && abs(xspd) > ledge) {didLedge=false;}

	// Horizontal Collisions
	if (scr_solid(x+xspd,y)) {
		// Change the speed according to the height of the ledge. 
	    xspd = ledge*sign(xspd);
		
		// First, get close to the wall, horizontally
	    while !(scr_solid(x+sign(xspd),y)) {x+=sign(xspd);}
		
		// Find the height of a step upto a max (ledge)    
	    while ((scr_solid(x+xspd, y+i) && scr_solid(x+xspd, y-i)) && (i<= ledge)) {i+=minStep;}
		
		// If there's a collision UPWARDS and is NOT maxed out.
	    if (scr_solid(x+xspd,y-i) && i!=ledge+minStep) { 
	        if (!scr_solid(x,y+1)) {/*x_move = 0;*/xspd = sign(xspd);} // If NOT on ground, reset speed.
	        y += i;
	        if scr_solid(x,y+1) yspd=0; // If on ground, no more vertical movement
	        didLedge = true;
	    } else if (scr_solid(x+xspd,y+i) && i!=ledge+minStep) { // DOWNWARDS
	        if (!scr_solid(x,y+1)) {xspd = sign(xspd);}
	        y += -i;
	        if scr_solid(x,y+1) yspd=0; // If on ground, no more vertical movement
	        didLedge = true;
	    } else if (scr_solid(x+xspd,y)) { // Ledge too tall. Just a wall
	        xspd = 0;
	    }
	}
	
	// Vertical Collisions: Floors or ceilings accounting for diagonal collisions
	if scr_solid(x+xspd,y+yspd) {
	    while !(scr_solid(x+xspd,y+sign(yspd))) {
	        y+=sign(yspd);
	    }

	    yspd = 0;
	    //jumpTime = 0; // Pointless? 
	}

	// Check Below Step: Move down a step without changing other physics
	// Not sure if it works for ceilings too. 
	if (abs(xspd) <= ledge && scr_solid(x,y+1) && !scr_solid(x+xspd,y+1)) {
	    while(!scr_solid(x+xspd, y+k+1)&&(k<=ledge)) {
	        k+=minStep;   
	    }
	    if (k!=ledge+minStep) {
	        y += k;
	        didLedge=true;
	    }
	}
}


function update_position() {
	x += xspd; x=round(x);
	y += yspd; y=round(y);
}