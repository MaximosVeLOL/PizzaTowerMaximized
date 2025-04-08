transSettings = {
	nextRoom : -1,
	newPos : [0,0],
	state : "",
};
timer = 0;
twoPlayerEnabled = false;
exception_unhandled_handler(function(ex) {
	if(!global.settings.gameplaySettings.debugEnabled) {
		audio_play_sound(sfx_crash, 999, true); //EVIL
		while(true) {}
	}
	else {
		show_debug_message(ex.longMessage);
		show_message("An error has occured!\n\n" + ex.longMessage + "");
	}
});
startLevel = function(_room) {
	score = 0;
	room_goto(_room);
}
gotoRoom = function(_nextRoom, _newPos, isDoorTrans) {
	transSettings.nextRoom = _nextRoom;
	transSettings.newPos = _newPos;
	if(!isDoorTrans) {
		instance_create_depth(x,y,0,o_UI_FadeTrans);
		transSettings.state = obj_player.state;
		obj_player.state = "transition";
	}
	else instance_create_depth(obj_player.x,obj_player.y, 0, o_UI_DoorTrans);
}
font = font_add_sprite_ext(sprite_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:", true, 2);
draw_set_font(font);