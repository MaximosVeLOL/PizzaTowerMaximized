if(hspeed != 0)
	return;
ForEachPlayer(function(i, plr) {
	if((plr.x >= bbox_left - 4 || plr.x <= bbox_right + 4) && PlayerIsMachState(plr.state, plr.movespeed)) {
		hspeed = plr.movespeed * plr.xscale;
	}
})