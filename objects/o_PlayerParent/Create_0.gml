//Movesets are enums because it shouldn't be to hard to debug,
//That's mostly the reason why I made states string values.
enum Moveset {
	Invalid = -1,
	PreETB,
	ETB,
	Demo1Tester,
	Demo1,
	Demo2Tester,
	Demo2,
};

if(global.settings.gameplaySettings.twoPlayerEnabled && instance_number(o_PlayerParent) < 2) CreatePlayer(x,y);
depth = -1000;
mass = 0.5;
velocity = [0,0];
movespeed = 0;
xscale = 1;
state = "normal";
tempVar = [0, 0, 0]; //0 - mach/substate/idle timer. 1 - timer
animVar = false;
sounds = [];
stunStuff = {
	invincibleFrames : 0,
	flashing : false,
};
PD = o_MultiplayerSystem.registerPlayer();
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
	if(stunStuff.invincibleFrames > 0) return;
	if(state == "knight") {
		o_MusicManager.stopTempSong();
		for(var i = 0 ; i <= 5 ; i++) { instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : sprite_player_knightdebris,  image_index : i})}
	}
	setState("hurt");
	tempVar[1] = 20;
	stunStuff.invincibleFrames = 200;
	playSound(choose(va_happy1, va_happy2, va_happy3));
	
}
playSound = function(snd, override = false, loop = false) {
	array_resize(sounds, array_length(sounds) + 1);
	sounds[array_length(sounds) - 1] = PlaySound(snd, override, loop);
}
