/*
for(var i = 0 ; i < instance_number(o_Player);i++) {
	var plr = GetPlayer(i);
	//BUG - This causes the child to not get destroyed, and the player gets stuck in the child. (Ayo?)
	//if(plr.state == PlayerState.Barrel) {
	//	continue;
	//}
	if(plr.bbox_right < bbox_left || plr.bbox_left > bbox_right) {
		if(pushDir != 0 && plr.state == PlayerState.Slip) plr.setState(PlayerState.Normal);
		continue;
	}
	if(!someoneOnTop) {
		if(plr.bbox_bottom <= bbox_top) {
			plr.isUnderwater = false;
			plr.depth = -10;
			if( plr.state == PlayerState.Mach2 || plr.state == PlayerState.Mach3 || plr.state == PlayerState.MachFreefall) {
				if(child == noone)
					child = instance_create_depth(x, y, 0, o_C_Wall, {image_xscale : self.image_xscale, image_yscale : self.image_yscale});
			}
			else {
				if(child == noone)
					return;
				instance_destroy(child);
				child = noone;
			}
		}
		else {
			if(child != noone) {
				instance_destroy(child);
				child = noone;
			}
			if(plr.velocity.y >= 0 && !plr.isUnderwater) {
				if(plr.state != PlayerState.Freefall && plr.state != PlayerState.Barrel) plr.velocity.y = 0;
				plr.isUnderwater = true;
				plr.depth = -1;
			}

		}
	}
	else {
		if(plr.bbox_top >= bbox_top && plr.bbox_bottom < bbox_bottom) {
			if(pushDir != 0 && plr.state != PlayerState.Slip) {
				plr.setState(PlayerState.Slip);
				plr.xscale = -pushDir;
				plr.movespeed = pushDir * 15;
			}
		}
	}

}
*/
ForEachPlayer(function(i, plr) {
	//If the player is within the bounding box of the water
	if(plr.bbox_right <= bbox_left || plr.bbox_left >= bbox_right || plr.y > bbox_bottom) {
		if(!someoneOnTop && child != noone) {
			destroyIt = true;
		}
		return;
	}
	if(plr.bbox_bottom > bbox_top) {
		if(!someoneOnTop) {//We are the top piece
			if(!plr.isUnderwater && plr.state != PlayerState.Barrel) {
				if(plr.state != PlayerState.Freefall && plr.velocity.y > 0.5) {
					plr.velocity.y = 0;
					CreateEffect({x : plr.x, y : plr.y, sprite_index : sprite_effect_landcloud});
					PlaySound(sound_splash, true);
				}
				plr.isUnderwater = true;
				plr.depth = 10;
			}
		}
		else if(pushDir != 0) {
			plr.xscale = -pushDir;
			//if(plr.state == PlayerState.Barrel) instance_create(plr.x, plr.y, o_Le_BarrelFloat);
			if(plr.state != PlayerState.Slip) plr.setState(PlayerState.Slip);
			plr.movespeed = 15 * pushDir; //The player moves backwards, so negate it so we move forward, and look backwards
			
		}
	}
	else if(plr.bbox_bottom >= bbox_top - 150) {
		if(!someoneOnTop) {
			plr.isUnderwater = false;
			plr.depth = -10;
			//if((plr.state == PlayerState.Mach1 || plr.state == PlayerState.Mach2 || plr.state == PlayerState.Mach3 || plr.state == PlayerState.MachFreefall || plr.state == PlayerState.MachSlide && plr.movespeed >= 10)) {
			if(PlayerIsMachState(plr.state, plr.movespeed)) {
				if(child == noone) {
					child = instance_create(x, y, o_C_Wall, {image_xscale : self.image_xscale});
					destroyIt = false;
				}
			}
			else {
				if(child != noone) {

					destroyIt = true;
				}
			}
		}
	}
});
if(destroyIt) {
	instance_destroy(child);
	child = noone;
}