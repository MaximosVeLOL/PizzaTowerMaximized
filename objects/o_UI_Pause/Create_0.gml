with(o_MusicManager) pauseMusic();
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
if(o_GameManager.level.index > LevelIndex.None) {
	stats = {
		time : GetAsTime(o_GameManager.level.time),
		name : Level_GetInfo(o_GameManager.level.index).levelName,
	};
}
prevMouse = 0;
//exist = true;
executeOption = function() {
	switch(option) {
		case 1:
			o_GameManager.restartLevel();
		case 0:
			instance_activate_all();
			intro = 2;
			o_GameManager.level.update = true;
		break;
		
		case 2:
			instance_create(0, 0, o_UI_Settings);
			//exist = false;
			instance_deactivate_object(self);
		break;
		
		case 3:
			instance_activate_all();
			persistent = true;
			intro = 2;
			if(o_GameManager.level.index == LevelIndex.None) {
				instance_destroy(all);
				room_goto(Room_MainMenu);
			}
			else o_GameManager.endLevel(false, true);
		break;
	}
}