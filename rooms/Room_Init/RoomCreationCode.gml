global.settings = {
	keyBinds : {
		p1 : {
			up : vk_up,
			down : vk_down,
			left : vk_left,
			right : vk_right,
			jump : ord("Z"),
			dash : ord("X"),
		},
		p2 : {
			up : ord("W"),
			down : ord("S"),
			left : ord("A"),
			right : ord("D"),
			jump : ord("K"),
			dash : ord("L"),
		},
	},
	audioSettings : {
		muteSfx : false,
		muteMusic : false,
		muteAll : false,
	},
	videoSettings : {
		fullscreen : false,
		resolutionX : 960,
		resolutionY : 540,
		vSync : false,
	},
	gameplaySettings : {
		debugEnabled : true,
	},
}
audio_group_load(AG_Sound);
room_goto(Room_Level1_Tutorial);
audio_play_sound(music_pizza, 999, true, 0.7);