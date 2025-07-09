if(!instance_exists(o_PlayerParent)) return;
ForEachPlayer(function(player, index) {
	var _pos = [ clamp(player.x - 480, 0, room_width - 960), clamp(player.y - 270, 0, room_height - 540) ];
	if(shakeMag != 0) {
		shakeMag -= 0.1;
		if(shakeMag <= 0) shakeMag = 0; 
		_pos[0] += random_range(-shakeMag, shakeMag);
	}
	camera_set_view_pos(view_camera[index], _pos[0], _pos[1]);
});
/* Wavy background stuff
if(string_count(room_get_name(room), "Secret" ) > 0) {
	shader_set(Shader_Distort);
	var s = shader_get_uniform(Shader_Distort, "time");
	shader_set_uniform_f(s, get_timer() / 1000000)
	
}