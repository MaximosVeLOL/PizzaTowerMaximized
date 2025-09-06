transSettings = {
	nextRoom : -1,
	newPos : [0,0],
	state : "",
};
level = {
	startParameters : [],
	pizzakin : {
		shroom : false,
		cheese : false,
		tomato : false,
		sausage : false,
		pineapple : false,
	},
	lap : 0,
	time : 340, //5:40
	index : LevelIndex.None,
};
#macro TIME_BASE (1/game_get_speed(gamespeed_fps))
#macro PLAYER_TOUCHING_IMAGE place_meeting(x + image_xscale, y, o_C_Wall)
#macro IMAGE_COMPLETE round(image_index) == image_number
mode = "none";

/*
exception_unhandled_handler(function(ex) {
	if(!global.settings.gameplaySettings.debugEnabled) {
		Log(ex.longMessage);
		
		audio_stop_all();
		
		audio_play_sound(sfx_crash, 999, true); //EVIL
		while(true) {}
	}
	else {
		show_debug_message(ex.longMessage);
		show_message("An error has occured!\n\n" + ex.longMessage + "\n\nRoom: " + string(room));
	}
});*/


startLevel = function(data) {
	data = GetLevelInfo(data);
	score = 0;
	level.time = data.newTime;
	if(instance_exists(o_PlayerParent) ) o_GameManager.gotoRoom(data.targetRoom, data.newPos, true, data.newSong, data.loopData);
	else { //Leftover from when we went from the disclaimer to the level directly.
		room_goto(data.targetRoom);
		if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(data.newSong, data.loopData);
		CreatePlayer(200,200); //Temporary!
		
	}
	level.startParameters = data;
	level.index = data.index;
	mode = "game";
}
restartLevel = function() {
	ResetLevel(0);
	instance_destroy(o_Le_Pizzakin);
	room_goto(level.startParameters[0]);
	o_PlayerParent.x = level.startParameters[1][0];
	o_PlayerParent.y = level.startParameters[1][1];
	level.pizzakin.shroom = false;
	level.pizzakin.cheese = false;
	level.pizzakin.tomato = false;
	level.pizzakin.sausage = false;
	level.pizzakin.pineapple = false;
	level.time = level.startParameters[4];
	level.lap = 0;
	score = 0;
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(level.startParameters[2], level.startParameters[3]);
	}
	o_PlayerParent.setState("door");
	o_PlayerParent.tempVar[0] = 1;
}
goToHub = function() {
	score = 0; //Score is used in the rank screen, so reset it here.
	level.pizzakin.shroom = false;
	level.pizzakin.cheese = false;
	level.pizzakin.tomato = false;
	level.pizzakin.sausage = false;
	level.pizzakin.pineapple = false;
	level.startParameters = [];
	level.time = -1;
	level.lap = 0;
	mode = "game";
	room_goto(Room_DemoRoom);
	
	
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(music_demoroom);
	}
	else instance_create_depth(0,0,0,o_MusicManager).playNewSong(music_demoroom);
	if(!instance_exists(o_Camera)) instance_create_depth(0,0,0,o_Camera);
	if(!instance_exists(o_PlayerParent)) CreatePlayer(256, 658);
	else {
		o_PlayerParent.x = 256;
		o_PlayerParent.y = 658;
		o_PlayerParent.setState("normal");
	}
}

endLevel = function(win = false, instantly = false) {
	if(instance_exists(o_ParralaxBackground)) instance_destroy(o_ParralaxBackground); //Hack for the release...
	if(instance_exists(o_PizzaTimeManager)) instance_destroy(o_PizzaTimeManager);
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		instance_destroy(o_MusicManager);
	}
	//instance_create_depth(0,0,0,o_RoomRamOpener);
	instance_destroy(o_Camera);
	instance_destroy(o_PlayerParent);
	instance_destroy(o_Le_Pizzakin);
	mode = "none";
	ResetLevel(level.index);
	if(instantly) {
		goToHub();
	}
	else {
		room_instance_add(Room_Empty, 0, 0, ( win ? o_UI_Rank : o_UI_GameOver) );
		room_goto(Room_Empty);
	}
}
/// @function           gotoRoom(Room_Empty, [0,0], true);
/// @param {Asset.GMRoom}  _nextRoom  The value to calculate the square of
/// @description        Goes to another room, PT style
gotoRoom = function(_nextRoom, _newPos, isDoorTrans, _newSong = -1, _loopData = [-1,-1]) {
	transSettings.nextRoom = _nextRoom;
	transSettings.newPos = _newPos;
	if(!isDoorTrans) {
		instance_create_depth(x,y,-100,o_UI_FadeTrans);
		transSettings.state = o_PlayerParent.state;
		o_PlayerParent.state = "transition";
	}
	else instance_create_depth(o_PlayerParent.x,o_PlayerParent.y, -100, o_UI_DoorTrans);
	if(_nextRoom == -1) {
		LogError("Invalid Room!", true);
	}
	if(_newSong != -1 && instance_exists(o_MusicManager)) o_MusicManager.playNewSong(_newSong, _loopData); //I'm tired of it logging unneccesary stuff.
}
sessions = {
	total : 0,
	save : 0,
}