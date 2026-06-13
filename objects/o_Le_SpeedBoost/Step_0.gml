ForEachPlayer(function(plr, i) {
    with(plr) {
        if(bbox_right >= other.bbox_left && bbox_left <= other.bbox_right && bbox_bottom >= other.bbox_top && bbox_top <= other.bbox_bottom) {
			xscale = other.image_xscale;
			if(state != PlayerState.Mach3 && !other.collided) {
				setState(PlayerState.Mach3);
				tempVar[1] = 1;
				tempVar[0] = 100;
				other.collided = true;
			}
			else if(!other.collided) movespeed += 4;
		}
		else other.collided = false;
    }
});