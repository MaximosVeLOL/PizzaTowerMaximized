if(!instance_exists(o_Player)) {
	Log("The Player is dead!");
	return;
}
if(instance_exists(o_DEBUG_Console) && o_DEBUG_Console.settings.renderDebugText) {
	draw_set_font(-1);
	var toDraw = [
		"State: " + o_Player.state,
		"TempVar: " + string(o_Player.tempVar[0]) + ", " + string(o_Player.tempVar[1]) + ", " + string(o_Player.tempVar[2]),
		"Velocity: " + string(o_Player.velocity.x) + ", " + string(o_Player.velocity.y),
		"MoveSpeed: " + string(o_Player.movespeed),
		"Player Pos: " + string(o_Player.x) + ", " + string(o_Player.y),
		"FPS: " + string(fps_real) + " : " + string(fps),
		"ShakeMag: " + string(shake.mag),
		"ShakeAcc: " + string(shake.acc),
		"Camera Pos: " + string(camera_get_view_x(view_camera[0])) + ", " + string(camera_get_view_y(view_camera[0])),
		//"Selfo_GameManager.level.score: " + string(o_Player_Machine.selfo_GameManager.level.score),
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
	if(global.settings.gameplay.goonerMode) {
		draw_sprite(sprite_hud_goonmarkgoon, 0, 0, 0);
	}
	switch(global.settings.player.moveSet) {
		case Moveset.PreETB:
			//Key is global across all players, so we don't need to update for each player!
			draw_sprite(sprite_hud_inventory, 0, 480, 40);
			if(GetPlayer(0).inventory.key) draw_sprite(sprite_level_key, -1, 480, 40);
		break;
		
		case Moveset.ETB: //OLD
			var sprite = sprite_error;
			ForEachPlayer(function(i, plr) {
				switch(plr.state) {
		
					case "mach1":
						sprite = sprite_hud_pep_mach1;
					break;
		
					case "machfreefall":
					case "mach2":
						sprite = sprite_hud_pep_mach2;
					break;
		
					case "mach3":
						//Dont use asset_get_index to save time
						sprite = (global.settings.player.ETB_useOldMach3 ? sprite_hud_pep_mach3 : sprite_hud_pep_mach4);
					break;
		
					case "mach4":
						sprite = sprite_hud_pep_mach4;
					break;
					
					case "freefall":
						if(plr.tempVar[0] != 2)
							break;
					case "hurt":
						sprite = sprite_hud_pep_hurt;
					break;
		
		
					default:
						sprite = sprite_hud_pep_idle;
					break;
				}
				var renderPos = (global.settings.multiplayer.enabled ? (global.settings.multiplayer.hudType == 0 ? new Vector(100 + (i * 160), 0) : new Vector(view_xport[i] + 100, view_yport[i] - 15)) : new Vector(120, 0));
				draw_sprite(sprite, -1, renderPos.x, renderPos.y + 80);
				if(string_count("mach", plr.state) > 0) {
					var mach =  plr.tempVar[0];
					if(mach >= 7) sprite = 1;
					if(mach >= 35) sprite = 2;
					if(mach >= 50) sprite = 3;
					if(mach >= 75) sprite = 4;
					if(mach >= 100) {
						draw_sprite(sprite_hud_speedbar_max, -1, renderPos.x, renderPos.y + 120);
					}
					else draw_sprite(sprite_hud_speedbar, sprite, renderPos.x, renderPos.y + 120);
				}
				else draw_sprite(sprite_hud_speedbar, 0, renderPos.x, renderPos.y + 120);

				//if(obj_player.inventory.gun) draw_sprite(sprite_test, -1, 240, 30);
				//draw_sprite(sprite_hud_inventory, -1, 240, 30);
			});
			if(global.settings.multiplayer.enabled && global.settings.multiplayer.cameraType != 2 && o_MultiplayerHandler.playerCount > 1) {
				if(GetPlayer(0).inventory.key) draw_sprite(sprite_level_key, -1, 480, 30);
				draw_sprite(sprite_hud_inventory, -1, 480, 30);
				draw_set_halign(fa_middle);
				draw_text(480, 270, string(o_GameManager.level.score));
				if(o_GameManager.level.lap > 0) {
					draw_set_font(ComicSans);
					draw_set_color(c_lime);
					draw_text(480, 100, "Return to the treasure room\nto get 200 extra points!");
				}
			}
			else {
				if (o_Player.inventory.key) draw_sprite(sprite_level_key, -1, 180, 30);
				draw_sprite(sprite_hud_inventory, -1, 180, 30);
				draw_text(180, 80, string(o_GameManager.level.score));
				if(o_GameManager.level.lap > 0) {
					draw_set_font(ComicSans);
					draw_set_color(c_lime);
					draw_set_halign(fa_middle);
					draw_text(480, 30, "Return to the treasure room\nto get 200 extra points!");
				}
			}
		break;
	}
}
//if(global.settings.multiplayer.enabled && global.settings.multiplayer.hudType == 2)
/*
var c = [c_blue, c_lime, c_red, c_aqua];

for(var i = 0 ; i < o_MultiplayerHandler.playerCount;i++) {
	draw_set_color(c[i]);
	draw_rectangle(view_xport[i] + 10, view_yport[i] + 10, view_xport[i] + view_wport[i] - 10, view_yport[i] + view_hport[i] - 10, true);
}
*/
GUI_RESET;