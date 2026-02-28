for(var i = 0 ; i < instance_number(o_Player);i++) {
	var plr = instance_find(o_Player, i);
	if(plr.state == "barrel") continue
	if(plr.bbox_right < bbox_left || plr.bbox_left > bbox_right) {
		if(pushDir != 0 && plr.state == "slip") plr.setState("normal");
		continue;
	}
	if(!someoneOnTop) {
		if(plr.bbox_bottom <= bbox_top) {
			plr.isUnderwater = false;
			if( plr.state == "mach2" || plr.state == "mach3") {
				if(child == noone)
					child = instance_create_depth(x, y, 0, o_C_Wall, {image_xscale : self.image_xscale, image_yscale : self.image_yscale});
			}
			else {
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
				plr.velocity.y = 0;
				plr.isUnderwater = true;
			}

		}
	}
	else {
		if(plr.bbox_top >= bbox_top + 1) {
			if(pushDir != 0 && (plr.state != "slip" && plr.movespeed != pushDir * 3)) {
				plr.setState("slip");
				plr.xscale = -pushDir;
				plr.movespeed = pushDir * 3;
			}
		}
	}

}