if(!paused) o_GameManager.level.time -= TIME_BASE;
if(o_GameManager.level.time <= 0) {
	paused = true;
	Log("Time Up!");
	//game_restart();
	//room_goto(Room_Empty);
	instance_create_depth(0,0,0,o_UI_GameOver);
	//o_PlayerParent.x = 0;
	//o_PlayerParent.y = 0;
}