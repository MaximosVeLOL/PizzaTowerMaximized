randomize();
enum FPSSaveMode {
	None = -1,
	UselessRemover,
	VisualRemover,
	OnlyTheNeccessary,
}
global.settings = {
	keyBinds : {
		p1 : {
			up : vk_up,
			down : vk_down,
			left : vk_left,
			right : vk_right,
			jump : ord("Z"),
			dash : ord("X"),
			shoot : ord("C"),
			gamepad : {
				up : gp_padu,
				down : gp_padd,
				left : gp_padl,
				right : gp_padr,
				jump : gp_face1,
				dash : gp_face3,
				shoot : gp_shoulderlb,
			}
		},
		p2 : {
			up : ord("W"),
			down : ord("S"),
			left : ord("A"),
			right : ord("D"),
			jump : ord("E"),
			dash : ord("R"),
			shoot : ord("T"),
			gamepad : {
				up : gp_padu,
				down : gp_padd,
				left : gp_padl,
				right : gp_padr,
				jump : gp_face1,
				dash : gp_face3,
				shoot : gp_shoulderlb,
			}
		},
		p3 : {
			up : ord("I"),
			down : ord("K"),
			left : ord("J"),
			right : ord("L"),
			jump : ord("O"),
			dash : ord("P"),
			shoot : ord("C"),
			gamepad : {
				up : gp_padu,
				down : gp_padd,
				left : gp_padl,
				right : gp_padr,
				jump : gp_face1,
				dash : gp_face3,
				shoot : gp_shoulderlb,
			}
		},
	},
	audioSettings : {
		sfxVolume : 100,
		musicVolume : 100,
		masterVolume : 100,
		muteAll : false,
	},
	videoSettings : {
		fullscreen : false,
		resolutionOpt : 1,
		vSync : false,
	},
	gameplaySettings : {
		debugEnabled : true,
		//multiplayer : false, Removed due to it being too hard to implement...
		goonerMode : false,
		fpsSave : FPSSaveMode.None,
	},
	playerSettings : {
		moveSet : Moveset.ETB,
		useOldMach3 : true,
		
	},
	saveFileIndex : -1,
}

global.misc = { //Bye bye o_GameManager's font!
	font : font_add_sprite_ext(sprite_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:)(", false, -10)
}
show_debug_overlay(true);
audio_group_load(AG_Sound);
/*
if(false) {
	room_goto(Room_MachineLearning);
	return;
}
if(true) {
	room_goto(Room_FeatureTest);
	instance_create_depth(200,200,0,o_Player_Network);
	return;
}*/
/*
if(global.settings.gameplaySettings.debugEnabled) {
	instance_create_depth(0,0,0,o_DEBUG_Console);
	//room_goto(Room_DemoRoom);instance_create_depth(0,0,0,o_Camera);instance_create_depth(200,200,0,o_Player_Noise);
}
if(global.settings.gameplaySettings.fpsSave != FPSSaveMode.OnlyTheNeccessary) {
	instance_create_depth(0,0,0, o_MusicManager);
	instance_create_depth(0,0,0, o_GameManager);
}
*/
var DEBUG_STARTUP = {
	startInLevelEditor : false,
	startInDemoRoom : false,
	startUpRoom : ETBRoom_Level1_1,
	startUpPos : [200, 200],
}
if(global.settings.gameplaySettings.debugEnabled) {
	if(DEBUG_STARTUP.startInLevelEditor) {
		room_goto(Room_LevelEditor);
	}
	else if(DEBUG_STARTUP.startInDemoRoom) {
		room_goto(DEBUG_STARTUP.startUpRoom);
		//var instances = [o_GameManager, o_MultiplayerSystem, o_MusicManager, o_Camera];
		var instances = [o_GameManager, o_MusicManager, o_Camera];
		for(var i = 0 ; i < array_length(instances);i++) if(!instance_exists(instances[i])) instance_create_depth(0,0,0,instances[i]);
		CreatePlayer(DEBUG_STARTUP.startUpPos[0], DEBUG_STARTUP.startUpPos[1]);
	}
	else room_goto(Room_Disclaimer);
}
draw_text(480,270, "INITIALIZATION");