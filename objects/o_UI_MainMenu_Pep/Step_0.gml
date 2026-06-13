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
			if(LoadSettings())
				ApplySettings();
			//if(global.settings.gameplay.fpsSave != FPSSaveMode.UselessRemover) instance_create_depth(0,0,0,o_MultiplayerSystem);
        	texturegroup_unload("tgMainMenu");
			//Unload developer group here because the settings are applied here
			if(!global.settings.gameplay.debugEnabled)
				texturegroup_unload("tgDeveloper");
			audio_stop_sound(music_mainmenu);
			//o_GameManager.mode = "game";
			o_GameManager.goToHub(false);
			
			//while(texturegroup_get_status("tgLevelCommon") != texturegroup_status_loaded){}
			//Log(string(texturegroup_get_status("tgLevelCommon")));
			//instance_destroy(o_UI_Fade);
        }
    }
}