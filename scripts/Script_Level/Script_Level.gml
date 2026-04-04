enum LevelIndex {
	None = -1,
	ETB_Ancient,
	PreETB_Level1,
	PreETB_Level2,
	Last,
};
function ResetLevel(levelIndex) {
	//var originalRoom = room;
	var rooms = [];
	switch(levelIndex) {
		case LevelIndex.None:
			throw("We are not in a level or we are not given a level!");
		break;
		
		
		case LevelIndex.ETB_Ancient: //ETB Ancient
			rooms = [
				ETBRoom_Tutorial1,
				ETBRoom_T1,
				ETBRoom_T2,
				ETBRoom_T3,
				ETBRoom_T4,
				ETBRoom_T4_Branch,
				ETBRoom_T5,
				ETBRoom_T6,
				ETBRoom_T6_Branch,
				ETBRoom_TTreasure,
				ETBRoom_TSecret1,
				ETBRoom_TSecret2,
			];
		break;
		
		case LevelIndex.PreETB_Level1:
			rooms = [
				ETBRoom_Level1_1,
				ETBRoom_Level1_2,
				ETBRoom_Level1_3,
				ETBRoom_Level1_4,
				ETBRoom_Level1_5,
				ETBRoom_Level1_6,
				ETBRoom_Level1_Secret1,
				ETBRoom_Level1_Secret2,
			];
		break;
		
		case LevelIndex.PreETB_Level2:
			rooms = [
				ETBRoom_Level2_1,
				ETBRoom_Level2_2,
				ETBRoom_Level2_3,
				ETBRoom_Level2_4,
				ETBRoom_Level2_5,
				ETBRoom_Level2_6,
				ETBRoom_Level2_7,
				ETBRoom_Level2_8,
				ETBRoom_Level2_9,
				ETBRoom_Level2_10,
				ETBRoom_Level2_Treasure,
			];
		break;
	}
	/*
	for(var i = 0 ; i < array_length(rooms);i++) {
		room_goto(rooms[i]);
		show_message("ROOM IND: " + string(room) + "\nIND: " + string(i));
		room_restart();
	}
	room_goto(originalRoom);
	
	This doesn't work, for some reason.
	THIS HAPPENS BECAUSE ROOM_GOTO EXECUTES AT THE END OF A SCRIPT AKA END OF CODE
	*/
	instance_create_depth(x, y, 0, o_LevelEnd, {roomData : rooms})
}
function SaveLevelInfo() {
	if(o_GameManager.level.demo || o_GameManager.level.index == LevelIndex.None) return;
	var out = buffer_create(0, buffer_grow, 1);
	buffer_write(out, buffer_u8, clamp(floor(global.misc.score / 500), 1, 6) - 1);
	buffer_write(out, buffer_u8, o_GameManager.level.index);
	buffer_write(out, buffer_u32, global.misc.score);
	buffer_write(out, buffer_u8, o_GameManager.level.pizzakin.shroom);
	buffer_write(out, buffer_u8, o_GameManager.level.pizzakin.cheese);
	buffer_write(out, buffer_u8, o_GameManager.level.pizzakin.tomato);
	buffer_write(out, buffer_u8, o_GameManager.level.pizzakin.sausage);
	buffer_write(out, buffer_u8, o_GameManager.level.pizzakin.pineapple);
	buffer_save(out, BASE_DIRECTORY + "/Save" + string(global.settings.saveFileIndex) + "/lvl" + string(o_GameManager.level.index) + ".info");
	buffer_delete(out);
}

function GetLevelInfo(levelIndex) {
	var levelInfo = {
		targetRoom : -1,
		newSong : -1,
		loopData : [-1, -1],
		levelName : "INVALID LEVEL",
		newTime : -1,
		newPos : new Vector(),
		index : -1,
	}
	switch(levelIndex) {
		case LevelIndex.ETB_Ancient:
			levelInfo.targetRoom = ETBRoom_Tutorial1;
			levelInfo.newSong = music_pizza;
			levelInfo.newPos = new Vector(723, 401);

			levelInfo.levelName = "ETB'S ANCIENT";
			levelInfo.newTime = 340;
		break;
		
		case LevelIndex.PreETB_Level1:
			levelInfo.targetRoom = ETBRoom_Level1_1;
			levelInfo.newSong = music_pizza;
			levelInfo.newPos = new Vector(224, 465);
			levelInfo.levelName = "PRE-ETB'S LEVEL 1";
			levelInfo.newTime = 130;
		break;
		
		case LevelIndex.PreETB_Level2:
			levelInfo.targetRoom = ETBRoom_Level2_1;
			levelInfo.newSong = music_water;
			levelInfo.newPos = new Vector(224, 200);
			levelInfo.levelName = "PRE-ETB'S LEVEL 2";
			levelInfo.newTime = 130;
		break;
	}
	levelInfo.index = levelIndex;
	return levelInfo;
}