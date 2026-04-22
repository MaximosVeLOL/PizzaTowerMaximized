transSettings = {
	nextRoom : -1,
	newPos : new Vector(),
	state : "",
};
level = {
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
	//If we are not in a save
	demo : false,
	timer : 0,
	score : 0,
	reset : function() {
		self.pizzakin = {
			shroom : false,
			cheese : false,
			tomato : false,
			sausage : false,
			pineapple : false,
		};
		self.lap = 0;
		self.time = 0;
		self.index = LevelIndex.None;
		self.demo = false;
		self.timer = 0;
		self.score = 0;
	},
};
#macro TIME_BASE (1/game_get_speed(gamespeed_fps))
#macro PLAYER_TOUCHING_IMAGE place_meeting(x + image_xscale, y, o_C_Wall)
#macro IMAGE_COMPLETE (round(image_index) == image_number)
mode = "none";

/*
exception_unhandled_handler(function(ex) {
	if(!global.settings.gameplay.debugEnabled) {
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
	level.time = data.newTime;
	if(instance_exists(o_Player) ) o_GameManager.gotoRoom(data.targetRoom, data.newPos, true, data.newSong, data.loopData);
	else { //Leftover from when we went from the disclaimer to the level directly.
		room_goto(data.targetRoom);
		if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(data.newSong, data.loopData);
		instance_create_depth(data.newPos.x, data.newPos.y, -10, o_Player);
		
	}
	level.index = data.index;
	mode = "game";
}
restartLevel = function() {
	ResetLevel(level.index);
	instance_destroy(o_Le_Pizzakin);
	room_goto(data.targetRoom);
	var data = GetLevelInfo(level.index);
	o_Player.x = data.newPos.x;
	o_Player.y = data.newPos.y;
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(data.newSong, data.loopData);
	}
	o_Player.setState("door");
	o_Player.tempVar[0] = 1;
};
returnToMenu = function() {
	if(instance_exists(Net_o_Server))
		instance_destroy(Net_o_Server)
	else if(instance_exists(Net_o_Client))
		instance_destroy(Net_o_Client)
	o_GameManager.level.demo = true;
	o_GameManager.goToHub();
	mode = "none";
}
goToHub = function() {
	if(level.demo && !instance_exists(Net_o_Client) && !instance_exists(Net_o_Server)) {
		//instance_destroy(o_Camera);
		//instance_destroy(o_Player);
		if(instance_exists(o_MusicManager)) 
			o_MusicManager.playNewSong(music_mainmenu);
		with(all) {
			if(persistent && object_index != o_GameManager && object_index != o_MusicManager && object_index != o_DEBUG_Console) {
				instance_destroy();
				Log("Destroyed " + object_get_name(object_index));
			}
		}
		room_goto(Room_MainMenu);
		level.demo = false;
		mode = "none";
		return;
	}
	//Determine if we have -1 remembered count
	if(global.settings.multiplayer.enabled && o_MultiplayerHandler.rememberedCount == -1) {
		o_MultiplayerHandler.AddPlayer(new Vector(256, 658));
	}
	if(!global.settings.multiplayer.enabled && !instance_exists(o_Player))
		instance_create_depth(256, 658, 0, o_Player);
	if(global.settings.multiplayer.enabled && o_MultiplayerHandler.rememberedCount > 0) {
		for(var i = 0 ; i < o_MultiplayerHandler.rememberedCount;i++) {
			o_MultiplayerHandler.AddPlayer(new Vector(256, 658));
		}
	}
	//instance_create_depth(256, 658, 0, o_Player);
	o_GameManager.level.score = 0; //o_GameManager.level.score is used in the rank screen, so reset it here.
	level.pizzakin.shroom = false;
	level.pizzakin.cheese = false;
	level.pizzakin.tomato = false;
	level.pizzakin.sausage = false;
	level.pizzakin.pineapple = false;
	level.time = -1;
	level.lap = 0;
	mode = "game";
	room_goto(Room_DemoRoom);
	
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(music_demoroom);
	}
	else instance_create_depth(0,0,0,o_MusicManager).playNewSong(music_demoroom);
	room_instance_add(Room_DemoRoom, 0,0,o_Camera);
}

endLevel = function(win = false, instantly = false) {
	if(instance_exists(o_ParralaxBackground)) instance_destroy(o_ParralaxBackground); //Hack for the release.settings..
	if(instance_exists(o_PizzaTimeManager)) instance_destroy(o_PizzaTimeManager);
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		//instance_destroy(o_MusicManager);
	}
	//instance_create_depth(0,0,0,o_RoomRamOpener);
	SaveLevelInfo();
	//Both do the same thing, but the multiplayer handles the systems.
	if(global.settings.multiplayer.enabled) o_MultiplayerHandler.RemoveAllPlayers();
	else instance_destroy(o_Player);
	//instance_deactivate_object(o_Player);
	instance_destroy(o_Le_Pizzakin);
	mode = "none";
	o_GameManager.level.score = 0;
	ResetLevel(level.index);
	if(instantly) {
		goToHub();
	}
	else {
		instance_destroy(o_Camera);
		room_instance_add(Room_Empty, 0, 0, ( win ? o_UI_Rank : o_UI_GameOver) );
		room_goto(Room_Empty);
	}
}
/// @function           gotoRoom(Room_Empty, [0,0], true);
/// @param {Asset.GMRoom}  _nextRoom  The value to calculate the square of
/// @description        Goes to another room, PT style
gotoRoom = function(_nextRoom, _newPos, isDoorTrans, _newSong = -1, _loopData = [-1,-1]) {
	trans.nextRoom = _nextRoom;
	trans.newPos = _newPos;
	if(_nextRoom == -1) {
		LogError("Invalid Room!");
		o_Player.x = o_Player.xstart;
		o_Player.y = o_Player.ystart;
		o_Player.setState("normal");
		return;
	}
	if(!isDoorTrans) {
		instance_create_depth(x,y,-100,o_UI_FadeTrans);
		trans.state = o_Player.state;
		//o_Player.state = "transition";
	}
	else instance_create_depth(o_Player.x,o_Player.y, -100, o_UI_DoorTrans);

	if(_newSong != -1 && instance_exists(o_MusicManager)) o_MusicManager.playNewSong(_newSong, _loopData); //I'm tired of it logging unneccesary stuff.
}
sessions = {
	total : 0,
	save : 0,
}