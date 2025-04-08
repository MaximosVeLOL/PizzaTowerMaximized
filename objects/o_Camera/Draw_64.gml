if(!instance_exists(obj_player)) return;
if(GetDebugSettings().renderDebugText) {
	draw_set_font(-1);
	var toDraw = [
		"State: " + obj_player.state,
		"TempVar: " + string(obj_player.tempVar[0]) + ", " + string(obj_player.tempVar[1]) + ", " + string(obj_player.tempVar[2]),
		"Velocity: " + string(obj_player.velocity[0]) + ", " + string(obj_player.velocity[1]),
		"MoveSpeed: " + string(obj_player.movespeed),
		"Player Pos: " + string(obj_player.x) + ", " + string(obj_player.y),
		//"Move Input: " + string(keyboard_check(global.settings.keyBinds.right) - keyboard_check(global.settings.keyBinds.left)) + ", " + string(keyboard_check(global.settings.keyBinds.down) - keyboard_check(global.settings.keyBinds.up))
	];
	for(var i = 0 ; i < array_length(toDraw);i++) {
		draw_text(20, 500 - (i * 20), toDraw[i]);
	}
	draw_set_font(o_GameManager.font);
}
if(hudVisible) {
	var sprite = sprite_error;
	switch(obj_player.state) {
		
		case "mach1":
			sprite = sprite_hud_pep_mach1;
		break;
		
		case "mach2":
			sprite = sprite_hud_pep_mach2;
		break;
		
		case "mach3":
			sprite = sprite_hud_pep_mach3;
		break;
		
		case "mach4":
			sprite = sprite_hud_pep_mach4;
		break;
		
		case "hurt":
			sprite = sprite_hud_pep_hurt;
		break;
		
		
		default:
			sprite = sprite_hud_pep_idle;
		break;
	}
	draw_sprite(sprite, -1, 120, 80);
	if(string_count("mach", obj_player.state) > 0) {
		var mach = obj_player.tempVar[0];
		if(mach >= 7) sprite = 1;
		if(mach >= 35) sprite = 2;
		if(mach >= 50) sprite = 3;
		if(mach >= 75) sprite = 4;
		if(mach >= 100) {
			draw_sprite(sprite_hud_speedbar_max, -1, 120, 120);
		}
		else draw_sprite(sprite_hud_speedbar, sprite, 120,120);
	}
	else draw_sprite(sprite_hud_speedbar, 0, 120,120);
	
}
draw_text(180, 80, string(score));