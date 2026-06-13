if(!global.settings.audio.muteAll) o_MusicManager.pauseMusic();
tempSurf = surface_create(960, 540);
surface_copy(tempSurf, 0, 0, application_surface);
intro = 0;
//0 - in, 1 - nothing, 2 - leave
y = 540;
tileY = 0;
bgColor = make_color_rgb(121, 103, 151);
option = 0;
sprites = [sprite_hud_pause_resume, sprite_hud_pause_retry, sprite_hud_pause_options, sprite_hud_pause_exit];
image_speed = 0.35; //Can't change GUI speed!

instance_deactivate_all(true);
instance_activate_object(o_GameManager);
o_GameManager.level.update = false;
//Save time to hold the stuff
stats = {
	time : GetAsTime(o_GameManager.level.time),
	name : GetLevelInfo(o_GameManager.level.index).levelName,
};
//exist = true;