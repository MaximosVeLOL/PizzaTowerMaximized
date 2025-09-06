enum LevelIndex {
	None = -1,
	ETB_Ancient,
	PreETB_Level1,
	PreETB_Level2,
	Last,
};

function ResetLevel(levelIndex) {
	var originalRoom = room;
	var rooms = [];
	switch(levelIndex) {
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
		
		case 1:
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
	}
	for(var i = 0 ; i < array_length(rooms);i++) {
		room_goto(rooms[i]);
		show_message("ROOM IND: " + string(room) + "\nIND: " + string(i));
		room_restart();
	}
	room_goto(originalRoom);
}
function GetLevelInfo(levelIndex) {
	var levelInfo = {
		targetRoom : -1,
		newSong : -1,
		loopData : [-1, -1],
		levelName : "INVALID LEVEL",
		newTime : -1,
		newPos : [-1, -1],
		index : -1,
	}
	switch(levelIndex) {
		case LevelIndex.ETB_Ancient:
			levelInfo.targetRoom = ETBRoom_Tutorial1;
			levelInfo.newSong = music_pizza;
			levelInfo.newPos = [723, 401];
			levelInfo.loopData = [-1,-1];
			levelInfo.levelName = "ETB'S ANCIENT";
			levelInfo.newTime = 340;
		break;
		
		case LevelIndex.PreETB_Level1:
			levelInfo.targetRoom = ETBRoom_Level1_1;
			levelInfo.newSong = music_pizza;
			levelInfo.newPos = [224, 465];
			levelInfo.levelName = "PRE-ETB'S LEVEL 1";
			levelInfo.newTime = 130;
		break;
	}
	levelInfo.index = levelIndex;
	return levelInfo;
}