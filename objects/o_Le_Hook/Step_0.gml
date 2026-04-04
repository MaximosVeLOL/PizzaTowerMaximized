if(!hooked) return;

plr.x = x + (sprite_width / 2);
plr.y = y + 40;
if(GetInput("jump", 1) || place_meeting(x, y, o_Le_HookEnd)) {
	if(plrGoFast) {
		plr.setState("mach3");
		plr.tempVar[0] = 100;
	}
	else {
		plr.setState("jump");
		plr.movespeed = 10;
	}
	hooked = false;
	plr.velocity.y = 0;
	hspeed = 0;
	vspeed = 0;
	var inst = instance_create_depth(x,y,0,o_P_Parent, {sprite_index : self.sprite_index});
	inst.velocity.x = hspeed;
	inst.velocity.y = vspeed;
	x = xstart;
	y = ystart;
}