
if(keyboard_check_pressed(vk_anykey)) {
	if(pressed) {
		instance_destroy();
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(music_mainmenu);
		instance_activate_object(o_UI_MainMenu);
	}
	pressed = true;
}
if(y <= -930) {
	pressed = true;
}
else y -= 0.3;