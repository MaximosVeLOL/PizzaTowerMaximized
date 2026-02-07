//Movesets are enums because it shouldn't be to hard to debug,
//That's mostly the reason why I made states string values.

//currentMoveset = Moveset.Invalid;
depth = -10;
mass = 0.5;
movespeed = 0;
xscale = 1;
state = "normal";
tempVar = [0, 0, 0];
animVar = false;
sounds = [];
stunStuff = {
	invincibleFrames : 0,
	flashing : false,
};
velocity = new Vector();
/*
PD = 1;
if(!global.settings.gameplaySettings.multiplayer && instance_number(object_index) > 1) {
	instance_destroy();
	return;
}*/


if(instance_number(o_Player) > 1 && !global.settings.gameplaySettings.multiplayer) {
	Log("Extra player in room" + string(room) + " (" + room_get_name(room) + ")");
	instance_destroy();
}
if(!global.settings.gameplaySettings.multiplayer) playerID = 0;
mask_index = spr_player_mask;
inventory = {
	key : false,
	gun : false,
};
#macro PLAYER_GROUNDED place_meeting(x, y + 1, o_C_Parent)
#macro PLAYER_TOUCHING place_meeting(x + xscale, y, o_C_Wall)
#macro SPRITE_NO_REPEAT if(round(image_index) == image_number) image_speed = 0
#macro GUI_RESET draw_set_color(c_white); draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_alpha(1); draw_set_font(-1)
setState = function(newState, overrideTemp = true, overrideMoveSpeed = false, overrideSound = true) {
	if(state == "noclip") return; //Useful for debugging
	
	state = newState;
	animVar = false;
	tempVar = overrideTemp ? [0,0,0] : tempVar;
	mass = 0.5;
	image_speed = 1;
	image_index = 0;
	mask_index = spr_player_mask;
	if(overrideSound) {
		for(var i = 0 ; i < array_length(sounds) ; i++) {
			if(sounds[i] != undefined)
				audio_stop_sound(sounds[i]);
		}
		sounds = [];
	}
	movespeed = overrideMoveSpeed ? 0 : movespeed; //I don't know why we didn't implement this, even though we had the option for it. We only figured this out when mach1 accelleration was being a bad boy.
}
hurt = function() {
	if(stunStuff.invincibleFrames > 0 || state == "noclip") return;
	if(instance_exists(o_MusicManager) && o_MusicManager.tempSong != -1) o_MusicManager.stopTempSong();
	if(state == "knight") {
		instance_destroy(o_H_Sword);
		for(var i = 0 ; i <= 5 ; i++) { instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : sprite_player_knightdebris,  image_index : i})}
	}
	setState("hurt");
	tempVar[1] = 20;
	stunStuff.invincibleFrames = 200;
	PlaySound(choose(va_hurt1, va_hurt2, va_hurt3));
	
}
playSound = function(snd, override = false) {
	//M_OPTI - This looks like something very low languagey, but is this faster, or slower?
	array_resize(sounds, array_length(sounds) + 1);
	sounds[array_length(sounds) - 1] = PlaySound(snd, override);
}
stopSound = function(snd) {
	audio_stop_sound(snd);return;
	for(var i = 0 ; i < array_length(sounds);i++) {
		if(snd == asset_get_index(audio_get_name(sounds[i]))) {
			audio_stop_sound(sounds[i]);
			for(var j = i ; j < array_length(sounds) - 1;j++) {
				sounds[j] = sounds[j] + 1;
			}
			array_resize(sounds, array_length(sounds) - 1);
			break;
		}
	}
}
