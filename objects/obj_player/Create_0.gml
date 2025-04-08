if(instance_number(object_index) > 2 + o_GameManager.twoPlayerEnabled) {
	LogError("I have a brother");
	instance_destroy();
}
depth = -1;
mass = 0.5;
velocity = [0,0];
movespeed = 0;
xscale = 1;
state = "normal";
tempVar = [0, 0, 0];
animVar = false;
sounds = [];
PD = o_MultiplayerSystem.registerPlayer();
mask_index = spr_player_mask;
inventory = {
	key : true,
	
};
#macro PLAYER_GROUNDED place_meeting(x, y + 1, o_C_Parent)
#macro PLAYER_TOUCHING place_meeting(x + xscale, y, o_C_Wall)
#macro SPRITE_NO_REPEAT if(round(image_index) == image_number) image_speed = 0
#macro GUI_RESET draw_set_color(c_white); draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_alpha(1)

setState = function(newState, overrideTemp = true, overrideMoveSpeed = false, overrideSound = true) {
	state = newState;
	animVar = false;
	tempVar = overrideTemp ? [0,0,0] : tempVar;
	mass = 0.5;
	image_speed = 1;
	image_index = 0;
	if(overrideSound) {
		for(var i = 0 ; i < array_length(sounds) ; i++) {
			if(sounds[i] != undefined)
				audio_stop_sound(sounds[i]);
		}
		sounds = [];
	}
}

playSound = function(snd, override = false, loop = false) {
	array_resize(sounds, array_length(sounds) + 1);
	sounds[array_length(sounds) - 1] = PlaySound(snd, override, loop);
}