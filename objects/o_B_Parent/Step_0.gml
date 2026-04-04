var plr = noone;
ForEachPlayer(function(p, plr) {
	if(distance_to_object(plr) > 48) return false;

	if(place_meeting(x+1,y,plr) || place_meeting(x-1,y,plr)) {
		onXBreak(plr);
		if(is_array(reqStatesX)) {
			for(var i = 0 ; i < array_length(reqStatesX);i++) {
				if(plr.state == reqStatesX[i]) {
					instance_destroy();
					return true;
				}
			}
		}
		else if(plr.state == reqStatesX) instance_destroy();
	}
	if(place_meeting(x,y-1, plr)) { //Top
		onTopBreak(plr);
		if(is_array(reqStatesTop)) {
			for(var i = 0 ; i < array_length(reqStatesTop);i++) {
				if(plr.state == reqStatesTop[i]) {
					instance_destroy();
					return true;
				}
			}
		}
		else if(plr.state == reqStatesTop) instance_destroy();
	}
	if(place_meeting(x,y+1, plr)) { //Bottom
		onBottomBreak(plr);
		if(is_array(reqStatesBottom)) {
			for(var i = 0 ; i < array_length(reqStatesBottom);i++) {
				if(plr.state == reqStatesBottom[i]) {
					instance_destroy();
					return true;
				}
			}
		}
		else if(plr.state == reqStatesBottom) instance_destroy();
	}

}

);