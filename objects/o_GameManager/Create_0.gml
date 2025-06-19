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
};
#macro FPS_CRUNCH false
#macro TIME_BASE (1/game_get_speed(gamespeed_fps))
#macro PLAYER_TOUCHING_IMAGE place_meeting(x + image_xscale, y, o_C_Wall)
mode = "none";
getScreenSize = function() {
    return [960,540];
}


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
});
startLevel = function(_room, _newPos, _newSong = -1, _loopData = [-1, -1]) {
	score = 0;
	if(instance_exists(o_PlayerParent)) o_GameManager.gotoRoom(_room, _newPos, true, _newSong, _loopData);
	else {
		room_goto(_room);
		o_MusicManager.playNewSong(_newSong, _loopData);
	}
	level.startParameters = [_room, _newPos, _newSong, _loopData];
	mode = "game";
}
endLevel = function() {
	//instance_create_depth(0,0,0,o_RoomRamOpener);
	//instance_destroy(o_Camera);
	//instance_destroy(o_MusicManager);
	//instance_destroy(o_PlayerParent);
	mode = "none";
	room_goto(Room_Empty);
	instance_create_depth(0,0,0,o_UI_Rank);
}
gotoRoom = function(_nextRoom, _newPos, isDoorTrans, _newSong = -1, _loopData = [-1,-1]) {
	transSettings.nextRoom = _nextRoom;
	transSettings.newPos = _newPos;
	if(!isDoorTrans) {
		instance_create_depth(x,y,0,o_UI_FadeTrans);
		transSettings.state = o_PlayerParent.state;
		o_PlayerParent.state = "transition";
	}
	else instance_create_depth(o_PlayerParent.x,o_PlayerParent.y, 0, o_UI_DoorTrans);
	if(_nextRoom == -1) LogError("Invalid Room!", true);
	if(_newSong != -1) o_MusicManager.playNewSong(_newSong, _loopData); //I'm tired of it logging unneccesary stuff.
}
font = font_add_sprite_ext(sprite_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:)(", false, -10);
draw_set_font(-1);



