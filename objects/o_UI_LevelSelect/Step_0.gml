info = GetLevelInfo(targetRoom);
var moveX = GetInput("right", 1) - GetInput("left", 1);
if(moveX == 0) moveX = GetInput("down", 1) - GetInput("up", 1);
targetRoom += moveX;
if(targetRoom < LevelIndex.ETB_Ancient) targetRoom = LevelIndex.Last - 1;
if(targetRoom >= LevelIndex.Last) targetRoom = 0;
if(GetInput("jump", 1)) {
	room_instance_add(info.targetRoom, 0, 0, o_Camera);
	o_GameManager.startLevel(targetRoom);
	o_GameManager.level.demo = true;
	
	//instance_create_depth(room_width / 2, room_height / 2, 0, o_Player);
}
if(GetInput("dash", 1)) {
	instance_destroy();
	PlaySound(sound_menuchange);
	GUI_RESET;
	instance_activate_object(o_UI_MainMenu);
}