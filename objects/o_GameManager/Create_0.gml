transSettings = {
	nextRoom : -1,
	newPos : [0,0],
	state : "",
};
timer = 0;
exception_unhandled_handler(function(ex) {
	if(!global.settings.gameplaySettings.debugEnabled) {
		audio_play_sound(sfx_crash, 999, true); //EVIL
		while(true) {}
	}
	else {
		show_debug_message(ex.longMessage);
		show_message("An error has occured!\n\n" + ex.longMessage + "\n\nRoom: " + string(room));
	}
});
startLevel = function(_room) {
	score = 0;
	room_goto(_room);
}
endLevel = function() {
	instance_create_depth(0,0,0,o_UI_Rank);
	instance_create_depth(0,0,0,o_RoomRamOpener);
	instance_destroy(o_Camera);
	instance_destroy(obj_player);
}
gotoRoom = function(_nextRoom, _newPos, _newSong, isDoorTrans) {
	transSettings.nextRoom = _nextRoom;
	transSettings.newPos = _newPos;
	if(!isDoorTrans) {
		instance_create_depth(x,y,0,o_UI_FadeTrans);
		transSettings.state = obj_player.state;
		obj_player.state = "transition";
	}
	else instance_create_depth(obj_player.x,obj_player.y, 0, o_UI_DoorTrans);
	if(_nextRoom == -1) LogError("Invalid Room!", true);
	if(_newSong != -1) o_MusicManager.playNewMusic(_newSong);
}
font = font_add_sprite_ext(sprite_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:", false, -10);
draw_set_font(font);