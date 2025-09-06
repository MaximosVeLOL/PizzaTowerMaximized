if(!hooked) return;

o_PlayerParent.x = x + (sprite_width / 2);
o_PlayerParent.y = y + 40;
if(GetInput("jump", 1)) {
	instance_destroy();
	if(o_PlayerParent.tempVar[0] >= 35) {
		o_PlayerParent.setState("machfreefall", false);
	}
	else o_PlayerParent.setState("jump");
	instance_create_depth(x,y,0,o_P_Parent, {sprite_index : self.sprite_index});
}