if(distance_to_object(o_Player) > 48) return;

if(place_meeting(x+1,y,o_Player) || place_meeting(x-1,y,o_Player)) {
	onXBreak();
	if(is_array(reqStatesX)) {
		for(var i = 0 ; i < array_length(reqStatesX);i++) {
			if(o_Player.state == reqStatesX[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(o_Player.state == reqStatesX) instance_destroy();
}
if(place_meeting(x,y-1, o_Player)) { //Top
	onTopBreak();
	if(is_array(reqStatesTop)) {
		for(var i = 0 ; i < array_length(reqStatesTop);i++) {
			if(o_Player.state == reqStatesTop[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(o_Player.state == reqStatesTop) instance_destroy();
}
if(place_meeting(x,y+1, o_Player)) { //Bottom
	onBottomBreak();
	if(is_array(reqStatesBottom)) {
		for(var i = 0 ; i < array_length(reqStatesBottom);i++) {
			if(o_Player.state == reqStatesBottom[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(o_Player.state == reqStatesBottom) instance_destroy();
}
