
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
        	o_MusicManager.playNewSong(music_demoroom);
        	o_GameManager.mode = "game";
			CreatePlayer(256, 658);
        }
    }
}