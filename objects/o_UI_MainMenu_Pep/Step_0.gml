if(!active) return;
timer++;
if(timer == 0) {
    //sprite_index = spr_player_idle;
}
else if(timer < 35) {
    hspeed = hspeed < 8 ? hspeed + 0.5 : 8;
    sprite_index = spr_player_mach1;
	image_speed = 0.35;
}
else if(timer < 100) {
    hspeed = 10;
	image_speed = 1;
    sprite_index = spr_player_mach2;
}
else {
    hspeed = 14;
    if(effect == 0) {
		effect = 6;
		instance_create_depth(x,y,0,o_P_Mach3Effect);
	}
    effect--;
    sprite_index = spr_player_mach3;
}
if(x > room_width + 300 && !instance_exists(o_UI_Fade)) {
    with(instance_create_depth(0,0,0,o_UI_Fade)) {
        onFade = function() {
			//instance_create_depth(0,0,0,o_Player);
			//LoadTextureGroup("TextureG_Level");
			if(LoadSettings()) ApplySettings();
			if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.OnlyTheNeccessary) {
				//if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.UselessRemover) instance_create_depth(0,0,0,o_MultiplayerSystem);
        		o_GameManager.mode = "game";
				o_GameManager.goToHub();
			}
			else {
				room_goto(Room_DemoRoom);
				instance_create_depth(200, 200, 0, o_Player);
			}
			//instance_destroy(o_UI_Fade);
        }
    }
}