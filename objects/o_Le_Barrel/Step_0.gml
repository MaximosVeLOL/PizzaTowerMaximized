
var plr = noone;
if(!visible) return;
if(PLAYER_GROUNDED) {
	velocity.x = 0;
	if(place_meeting(x - 5, y, o_Player) || place_meeting(x + 5, y, o_Player)) {
		
		plr = instance_place(x - 5, y, o_Player);
		if(plr == noone) plr = instance_place(x + 5, y, o_Player);
		if(plr.state != "mach1" && plr.state != "mach2" && plr.state != "mach3") return;
		PlaySound(sfx_bump);
		//CreateEffect({sprite_index : sprite_effect_bump}); This is Pre-ETB! There are no effects yet.
		plr.setState("hump");
		PlaySound(sfx_bump);
		//plr.velocity.y = -6;
		velocity.x = 3 * o_Player.xscale;
		velocity.y = -3;
		y--;
	}
	
		
}
else if(place_meeting(x,y - (sprite_height / 2), o_Le_Water)) {
	instance_create(x,y, o_Le_BarrelFloat, {parent : self});
	Deactivate();
}

if(place_meeting(x, bbox_top - 2, o_Player) && usable) {
	plr = instance_place(x, bbox_top - 2, o_Player);
	plr.setState("barrel");
	Deactivate();
}

CollideAndMove(0.4, 20, false);