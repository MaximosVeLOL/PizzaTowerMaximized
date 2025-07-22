
if(active)timer++;
if(timer == 0) {
    //sprite_index = spr_player_idle;
}
else if(timer < 35) {
    movespeed = movespeed < 8 ? movespeed + 0.5 : 8;
    sprite_index = spr_player_mach1;
}
else if(timer < 100) {
    movespeed = 10;
    sprite_index = spr_player_mach2;
}
else {
    movespeed = 14;
    if(effect == 0) {
		effect = 6;
		instance_create_depth(x,y,0,o_P_Mach3Effect);
	}
    effect--;
    sprite_index = spr_player_mach3;
}
hspeed = movespeed;
if(x > room_width + 300) {
    with(instance_create_depth(0,0,0,o_UI_Fade)) {
        onFade = function() {
            room_goto(Room_DemoRoom);
			if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.OnlyTheNeccessary) {
				if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(music_demoroom); //We don't have to use Get()!!! 11 1 111 1
				//Actually we need to 
				instance_create_depth(0,0,0,o_GameManager);
				if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.UselessRemover) instance_create_depth(0,0,0,o_MultiplayerSystem);
        		o_GameManager.mode = "game";
			}
			CreatePlayer(256, 658);
        }
    }
}