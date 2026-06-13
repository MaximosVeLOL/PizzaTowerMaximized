//if(!exist) return;
	
tileY++;
x++;
if(keyboard_check_pressed(vk_escape)) {
	instance_activate_all();
	intro = 2;
}
if(intro == 2) return;

option += GetInput("right", 1) - GetInput("left", 1);
if(GetInput("jump", 1)) {
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
				room_goto(Room_MainMenu);
			}
			else o_GameManager.endLevel(false, true);
		break;
	}
}
