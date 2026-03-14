if(PLAYER_GROUNDED) {
	velocity.x = 0;
	if(place_meeting(x - 5, y, o_Player) || place_meeting(x + 5, y, o_Player)) {
		if(o_Player.state != "mach2" && o_Player.state != "mach1") return;
		PlaySound(sfx_bump);
		//CreateEffect({sprite_index : sprite_effect_bump}); This is Pre-ETB! There are no effects yet.
		o_Player.setState("bump");
		o_Player.velocity.y = -6;
		velocity.x = 3 * o_Player.xscale;
		velocity.y = -3;
		y--;
	}
	
		
}
else if(place_meeting(x,y - (sprite_height / 2), o_Le_Water)) {
	velocity.y = -3;
	velocity.x = 0;
	sprite_index = sprite_level_barrelF;
	mask_index = -1;
}
if(place_meeting(x, bbox_top - 2, o_Player) && usable) {
	var plr = instance_place(x, bbox_top - 2, o_Player)
	plr.setState("barrel");
	if(place_meeting(x,y, o_Le_Water)) {
		plr.tempVar[0] = 3;
		plr.x = x;
		plr.y = y;
	}
	instance_destroy();
	
}
CollideAndMove(0.4, 20, false);