if(place_meeting(x+1,y,o_PlayerParent) || place_meeting(x-1,y,o_PlayerParent)) {
	onXBreak();
	if(is_array(reqStatesX)) {
		for(var i = 0 ; i < array_length(reqStatesX);i++) {
			if(GetPlayer().state == reqStatesX[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(GetPlayer().state == reqStatesX) instance_destroy();
}
if(place_meeting(x,y-1, o_PlayerParent)) { //Top
	onTopBreak();
	if(is_array(reqStatesTop)) {
		for(var i = 0 ; i < array_length(reqStatesTop);i++) {
			if(GetPlayer().state == reqStatesTop[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(GetPlayer().state == reqStatesTop) instance_destroy();
}
if(place_meeting(x,y+1, o_PlayerParent)) { //Bottom
	onBottomBreak();
	if(is_array(reqStatesBottom)) {
		for(var i = 0 ; i < array_length(reqStatesBottom);i++) {
			if(GetPlayer().state == reqStatesBottom[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(GetPlayer().state == reqStatesBottom) instance_destroy();
}
