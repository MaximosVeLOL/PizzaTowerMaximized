if(place_meeting(x+1,y,obj_player) || place_meeting(x-1,y,obj_player)) {
	if(is_array(reqStatesX)) {
		for(var i = 0 ; i < array_length(reqStatesX);i++) {
			if(obj_player.state == reqStatesX[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(obj_player.state == reqStatesX) instance_destroy();
}
if(place_meeting(x,y-1, obj_player)) { //Top
	if(is_array(reqStatesTop)) {
		for(var i = 0 ; i < array_length(reqStatesTop);i++) {
			if(obj_player.state == reqStatesTop[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(obj_player.state == reqStatesTop) instance_destroy();
}
if(place_meeting(x,y+1, obj_player)) { //Bottom
	if(is_array(reqStatesBottom)) {
		for(var i = 0 ; i < array_length(reqStatesBottom);i++) {
			if(obj_player.state == reqStatesBottom[i]) {
				instance_destroy();
				break;
			}
		}
	}
	else if(obj_player.state == reqStatesBottom) instance_destroy();
}
