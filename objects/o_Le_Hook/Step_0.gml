if(!hooked) return;

o_Player.x = x + (sprite_width / 2);
o_Player.y = y + 40;
if(GetInput("jump", 1)) {
	instance_destroy();
	if(o_Player.tempVar[0] >= 35) {
		o_Player.setState("machfreefall", false);
	}
	else o_Player.setState("jump");
	o_Player.velocity.y = 1;
	instance_create_depth(x,y,0,o_P_Parent, {sprite_index : self.sprite_index});
}
if(place_meeting(x, y, o_Le_HookEnd)) {
	o_Player.setState("mach3");
	o_Player.tempVar[0] = 100;
	hooked = false;
}
CollideAndMove(0);