if(!instance_exists(o_Player)) {
	LogError("There is no player to capture!");
	return;
}

if(global.settings.multiplayerSettings.enabled) {
	var cur = noone;
	//if(global.settings.multiplayerSettings.hudType != 2) {
		ForEachPlayer(function(i, cur) {
			pos.x = clamp(cur.x - (view_wport[i] / 2), 0, room_width - view_wport[i]);
			pos.y = clamp(cur.y - (view_hport[i] / 2), 0, room_height - view_hport[i]);
			if(shake.mag > 0) {
				shake.mag -= shake.acc; 
				//if(shake.mag < 0) shake.mag = 0; M_OPTI - This is useless, because we don't apply the shake mag when its never above 0!
				pos.x += random_range(-shake.mag, shake.mag);
				pos.y += random_range(-shake.mag, shake.mag);
			}
			camera_set_view_pos(view_camera[i], pos.x, pos.y);
		
		});
	/*}
	else {
		var SAFE_SPACE = 40;
		var MIN = new Vector(10000, 10000);
		var MAX = new Vector(-1000, -1000);
		ForEachPlayer(function(i, plr) {
			if(plr.x < MIN.x)
				MIN.x = plr.x;
			if(plr.x > MAX.x)
				MAX.x = plr.x;
			if(plr.y < MIN.y)
				MIN.y = plr.y;
			if(plr.y > MAX.y)
				MAX.y = plr.y;
		});
		
		var A = new Vector((MIN.x + MAX.x ) / 2, (MIN.y + MAX.y) / 2);
		pos.x = clamp(A - 480, 0, room_width - 960);
		
	}*/
}
else {

		pos.x = clamp(o_Player.x - 480, 0, room_width - 960);
		pos.y = clamp(o_Player.y - 270, 0, room_height - 540);
		if(shake.mag > 0) {
			shake.mag -= shake.acc; 
			//if(shake.mag < 0) shake.mag = 0; M_OPTI - This is useless, because we don't apply the shake mag when its never above 0!
			pos.x += random_range(-shake.mag, shake.mag);
			pos.y += random_range(-shake.mag, shake.mag);
		}
		camera_set_view_pos(view_camera[0], pos.x, pos.y);
}
/* Whoops
if(string_count("Secret", room_get_name(room) ) > 0) {
	shader_set(Shader_Distort);
	var s = shader_get_uniform(Shader_Distort, "time");
	shader_set_uniform_f(s, get_timer() / 1000000)
	
}