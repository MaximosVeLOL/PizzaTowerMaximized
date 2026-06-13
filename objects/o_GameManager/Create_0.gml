transSettings = {
	nextRoom : -1,
	newPos : new Vector(),
	//REGION=PlayerTrans
	//state : "",
};
enum Gamemode {
	None = 0,
	TimeAttack,
	Sandbox
}
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
	//Always set to none if we aren't in a level!
	index : LevelIndex.None,
	//If we are not in a save
	demo : false,
	timer : 0,
	score : 0,
	gameMode : Gamemode.None,
	reset : function() {
		self.pizzakin = {
			shroom : false,
			cheese : false,
			tomato : false,
			sausage : false,
			pineapple : false,
		};
		self.lap = 0;
		self.time = -1;
		self.index = LevelIndex.None;
		self.demo = false;
		self.timer = 0;
		self.score = 0;
	},
	//If we have started the level so we can update the timer for gamemodes and misc
	update : false,
	toggleTimer : function() {
		self.update = !self.update;
		//Automatically skips the exists check, so do this
		with(o_PizzaTimeManager) paused = !paused;
	},
};
#macro TIME_BASE (1/game_get_speed(gamespeed_fps))
#macro PLAYER_TOUCHING_IMAGE place_meeting(x + image_xscale, y, o_C_Wall)
#macro IMAGE_COMPLETE (round(image_index) == image_number)
//Global state of the game
enum GameState {
	//When doing nothing important (why do we exist then?)
	None = 0,
	//When doing game actions (so we can pause)
	Game = 1,
}
mode = GameState.None;

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


startLevel = function(pIndex, pDoPrompt = true) {
	LevelPrecacheTextures(pIndex);
    //data = GetLevelInfo(data);
	//level.time = data.newTime;
	level.index = pIndex;
	//o_Camera.setupLevelTransition();
	if(pDoPrompt) {
		instance_deactivate_all(true);
		instance_create_depth(0, 0, 0, o_UI_GamemodePrompt);
		return;
	}
	
	
	//if(instance_exists(o_Player) ) gotoRoom(data.targetRoom, data.newPos, true, data.newSong, data.loopData);
	/*
	else { //Leftover from when we went from the disclaimer to the level directly.
		room_goto(data.targetRoom);
		if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(data.newSong, data.loopData);
		instance_create_depth(data.newPos.x, data.newPos.y, -10, o_Player);
		
	}
	*/
	//level.index = data.index;
	//Not needed since we already have it set
	//mode = GameState.Game;
}
restartLevel = function() {
	ResetLevel(level.index);
	instance_destroy(o_Le_Pizzakin);
	var data = GetLevelInfo(level.index);
	room_goto(data.targetRoom);
	o_Player.x = data.newPos.x;
	o_Player.y = data.newPos.y;
	if(instance_exists(o_MusicManager)) {
		o_MusicManager.stopMusic(true);
		o_MusicManager.playNewSong(data.newSong, data.loopData);
	}
	o_Player.setState(PlayerState.Door);
	o_Player.tempVar[0] = 1;
};
returnToMenu = function() {
	if(instance_exists(Net_o_Server))
		instance_destroy(Net_o_Server)
	else if(instance_exists(Net_o_Client))
		instance_destroy(Net_o_Client)
	o_GameManager.level.demo = true;
	o_GameManager.goToHub();
	mode = GameState.None;
}
//gameHasStarted - Have we already started the game up? (true - yes)
goToHub = function(gameHasStarted = true) {
	if(gameHasStarted) {
		level.reset();
		
		if(level.demo && !IS_NETWORKING) {
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
			mode = GameState.None;
			return;
		}
		
		instance_activate_object(o_Player);
		instance_activate_object(o_Camera);
	}
	else {
		mode = GameState.Game;
	}
	//This was when we used the music manager to play the main menu music, but we don't do it anymore, what should we do?
	with(o_MusicManager) {
		stopMusic(true);
		playNewSong(music_demoroom);
	}
	room_goto(Room_DemoRoom);
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
	//if(global.settings.multiplayer.enabled) o_MultiplayerHandler.RemoveAllPlayers();
	
	//instance_deactivate_object(o_Player);
	instance_destroy(o_Le_Pizzakin);
	mode = GameState.None;
	//o_GameManager.level.score = 0;
	ResetLevel(level.index);
	if(instantly) {
		goToHub();
	}
	else {
		instance_deactivate_object(o_Camera);
		instance_deactivate_object(o_Player);
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
	if(_nextRoom == -1) {
		LogError("Invalid Room!");
		o_Player.x = o_Player.xstart;
		o_Player.y = o_Player.ystart;
		o_Player.setState(PlayerState.Normal);
		return;
	}
	if(!isDoorTrans) {
		instance_create_depth(x,y,-100,o_UI_FadeTrans);
		transSettings.state = o_Player.state;
		//o_Player.state = "transSettingsition";
	}
	else instance_create_depth(o_Player.x,o_Player.y, -100, o_UI_DoorTrans);

	if(_newSong != -1 && instance_exists(o_MusicManager)) o_MusicManager.playNewSong(_newSong, _loopData); //I'm tired of it logging unneccesary stuff.
}
sessions = {
	total : 0,
	save : 0,
}