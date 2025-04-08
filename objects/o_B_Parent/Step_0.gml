if(place_meeting(bbox_left - 1, y, obj_player) || place_meeting(bbox_right + 1, y, obj_player)) {
	var isAcceptable = false;
	if(is_array(reqStatesX)) {
		for(var i = 0 ; i < array_length(reqStatesX);i++) {
			if(obj_player.state == reqStatesX[i]) {
				isAcceptable = true;
				break;
			}
		}
	}
	else isAcceptable = (obj_player.state == reqStatesX);
	if(isAcceptable) {
		instance_destroy();
	}
}
if(place_meeting(x, bbox_top - 1, obj_player) || place_meeting(x, bbox_bottom + 1, obj_player)) {
	var isAcceptable = false;
	if(is_array(reqStatesX)) {
		for(var i = 0 ; i < array_length(reqStatesY);i++) {
			if(obj_player.state == reqStatesY[i]) {
				isAcceptable = true;
				break;
			}
		}
	}
	else isAcceptable = (obj_player.state == reqStatesY);
	if(isAcceptable) {
		instance_destroy();
	}
}