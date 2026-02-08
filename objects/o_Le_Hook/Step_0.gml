if(!hooked) return;

plr.x = x + (sprite_width / 2);
plr.y = y + 40;
if(GetInput("jump", 1)) {
	//instance_destroy();
	if(plr.tempVar[0] >= 35) {
		plr.setState("machfreefall", false);
	}
	else plr.setState("jump");
	plr.velocity.y = 1;
	instance_create_depth(x,y,0,o_P_Parent, {sprite_index : self.sprite_index});
	x = xstart;
	y = ystart;
}
if(place_meeting(x, y, o_Le_HookEnd)) {
	plr.setState("mach3");
	plr.tempVar[0] = 100;
	hooked = false;
	hspeed = 0;
	vspeed = 0;
}