if(!instance_exists(o_PlayerParent)) {
	Log("The Player is dead!");
	return;
}
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderDebugText) {
	draw_set_font(-1);
	var toDraw = [
		"State: " + o_PlayerParent.state,
		"TempVar: " + string(o_PlayerParent.tempVar[0]) + ", " + string(o_PlayerParent.tempVar[1]) + ", " + string(o_PlayerParent.tempVar[2]),
		"Velocity: " + string(o_PlayerParent.velocity[0]) + ", " + string(o_PlayerParent.velocity[1]),
		"MoveSpeed: " + string(o_PlayerParent.movespeed),
		"Player Pos: " + string(o_PlayerParent.x) + ", " + string(o_PlayerParent.y),
		"FPS: " + string(fps_real) + " : " + string(fps),
		"ShakeMag: " + string(shake.mag),
		"ShakeAcc: " + string(shake.acc),
		
		//"SelfScore: " + string(o_Player_Machine.selfScore),
		//"Time: " + string(o_Player_Machine.time),
		//"BestInputs: " + string(global.bestInputs),
		//"Inputs: " + string(o_Player_Machine.inputs),
		//"Move Input: " + string(keyboard_check(global.settings.keyBinds.right) - keyboard_check(global.settings.keyBinds.left)) + ", " + string(keyboard_check(global.settings.keyBinds.down) - keyboard_check(global.settings.keyBinds.up))
	];
	for(var i = 0 ; i < array_length(toDraw);i++) {
		draw_text(20, 520 - (i * 20), toDraw[i]);
	}
	
}
draw_set_font(global.misc.font);
if(hudVisible) {
	if(global.settings.gameplaySettings.goonerMode) {
		draw_sprite(sprite_hud_goonmarkgoon, 0, 0, 0);
	}
	switch(global.settings.playerSettings.moveSet) {
		case Moveset.PreETB:
			draw_sprite(sprite_hud_inventory, 0, 480, 40);
			if(o_PlayerParent.inventory.key) draw_sprite(sprite_level_key, -1, 480, 40);
		break;
		
		case Moveset.ETB: //OLD
			var sprite = sprite_error;
			for(var i = 0 ; i < instance_number(o_PlayerParent);i++) {
				var X_ADD = (i * 200);
				switch(instance_find(o_PlayerParent, i).state) {
		
					case "mach1":
						sprite = sprite_hud_pep_mach1;
					break;
		
					case "mach2":
						sprite = sprite_hud_pep_mach2;
					break;
		
					case "mach3":
						sprite = global.settings.playerSettings.useOldMach3 ? sprite_hud_pep_mach3 : sprite_hud_pep_mach4;
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
				draw_sprite(sprite, -1, 120 + X_ADD, 80);
				if(string_count("mach", instance_find(o_PlayerParent, i).state) > 0) {
					var mach =  instance_find(o_PlayerParent, i).tempVar[0];
					if(mach >= 7) sprite = 1;
					if(mach >= 35) sprite = 2;
					if(mach >= 50) sprite = 3;
					if(mach >= 75) sprite = 4;
					if(mach >= 100) {
						draw_sprite(sprite_hud_speedbar_max, -1, 120 + X_ADD, 120);
					}
					else draw_sprite(sprite_hud_speedbar, sprite, 120 + X_ADD,120);
				}
				else draw_sprite(sprite_hud_speedbar, 0, 120 + X_ADD,120);
	
	
			    if (instance_find(o_PlayerParent, i).inventory.key) draw_sprite(sprite_level_key, -1, 180 + X_ADD, 30)
			    draw_sprite(sprite_hud_inventory, -1, 180 + X_ADD, 30)
				//if(obj_player.inventory.gun) draw_sprite(sprite_test, -1, 240, 30);
				//draw_sprite(sprite_hud_inventory, -1, 240, 30);
			}
			draw_text(180, 80, string(score));
		break;
	}
}
GUI_RESET;