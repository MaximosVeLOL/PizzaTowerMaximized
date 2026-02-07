var moveX = GetInput("down", 1) - GetInput("up", 1);

if(moveX != 0) {
	levelIndex = clamp(levelIndex + moveX, 0, LevelIndex.Last - 1);
	levelData = GetLevelInfo(levelIndex);
}
if(GetInput("jump", 1)) {
	with(levelData) {
		room_goto(targetRoom);
		instance_create_depth(0,0,0,o_Camera);
		instance_create_depth(newPos.x, newPos.y, 0, o_Player);
		if(instance_exists(o_MusicManager)) {
			o_MusicManager.playNewSong(newSong, loopData);
		}
		o_GameManager.mode = "game";
		o_GameManager.level.time = newTime;
	}
}