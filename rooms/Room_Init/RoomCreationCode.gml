randomize();
enum FPSSaveMode {
	None = -1,
	UselessRemover,
	VisualRemover,
	OnlyTheNeccessary,
}
global.settings = {
	keyBinds : {
		p0 : {
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
		p1: {
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
		p2 : {
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
		p3 : {
			up : ord("5"),
			down : ord("5"),
			left : ord("5"),
			right : ord("5"),
			jump : ord("5"),
			dash : ord("5"),
			shoot : ord("5"),
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
		surroundSound : false,
	},
	videoSettings : {
		fullscreen : false,
		resolutionOpt : 1,
		vSync : false,
	},
	gameplaySettings : {
		debugEnabled : false,
		//Moved to multiplayerSettings
		//multiplayer : true, //We're back!
		goonerMode : false,
		fpsSave : FPSSaveMode.None,
	},
	playerSettings : {
		moveSet : Moveset.ETB,
		ETB_useOldMach3 : true,
		PreETB_betterRunning : true,
		waterInteraction : true,
	},
	multiplayerSettings : {
		enabled : false,
		//playerCount : 4,
		cameraType : 1,
		hudType : 1,
	},
	saveFileIndex : -1,
}

global.misc = { //Bye bye o_GameManager's font!
	font : font_add_sprite_ext(sprite_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:)(", false, -10),
	score : 0,
}
//show_debug_overlay(true);
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
/*
if(false) {
	room_goto(Room_FeatureTest);
	instance_create_depth(1000, 200, 0, o_Player);
	instance_create_depth(1000, 200, 0, o_Camera);
	//instance_create_depth(1000, 200, 0, o_GameManager);
	instance_create_depth(1000, 200, 0, o_DEBUG_Console);
	var out = "";
	if(parameter_count() == 3) {
		instance_create_depth(0, 0, 0,  Net_o_Server);
		window_set_position(0, 240);
		//instance_create_depth(0, 0, 0,  o_Client);
		execute_shell_simple(parameter_string(0), "-game " + parameter_string(2) + " " + "-secondary -tertiary -nigga -nigga")
	}
	else if(parameter_count() == 7) {
		window_set_caption("P2");
		window_set_position(400, 240);
		execute_shell_simple(parameter_string(0), "-game " + parameter_string(2) + " " + "-secondary -tertiary -nigga -nigga -nigga")
		instance_create_depth(0, 0, 0,  Net_o_Client);
	}
	else if(parameter_count() == 8) {
		window_set_caption("P3");
		window_set_position(900, 240);
		//execute_shell_simple(parameter_string(0), "-game " + parameter_string(2) + " " + "-secondary -tertiary -nigga -nigga -nigga -nigga -nigga")
		instance_create_depth(0, 0, 0,  Net_o_Client);
	}
	else {
		window_set_caption("P4");
		//execute_shell_simple(parameter_string(0), "-game " + parameter_string(2) + " " + "-secondary -tertiary -nigga -nigga -nigga -nigga -nigga")
		instance_create_depth(0, 0, 0,  Net_o_Client);
	}
	return;
}
*/
if(global.settings.gameplaySettings.debugEnabled) {
	var DEBUG_STARTUP = {
		startInLevelEditor : false,
		startInStartingRoom : false,
		startUpRoom : ETBRoom_Level2_7,
		startUpPos : [/*2167*/200, 100],
	};
	if(global.settings.multiplayerSettings.enabled) instance_create_depth(0, 0, 0, o_MultiplayerHandler);
	instance_create_depth(0,0,0,o_DEBUG_Console);
	show_debug_overlay(true, true);
	if(DEBUG_STARTUP.startInLevelEditor) {
		room_goto(Room_LevelEditor_Menu);
	}
	else if(DEBUG_STARTUP.startInStartingRoom) {
		room_goto(DEBUG_STARTUP.startUpRoom);
		//var instances = [o_GameManager, o_MultiplayerHandler, o_MusicManager, o_Camera];
		var instances = [o_GameManager, o_MusicManager, o_Camera];
		for(var i = 0 ; i < array_length(instances);i++) if(!instance_exists(instances[i])) instance_create_depth(0,0,0,instances[i]);
		o_GameManager.mode = "game";
		if(global.settings.multiplayerSettings.enabled) {
			o_MultiplayerHandler.AddPlayer(new Vector(DEBUG_STARTUP.startUpPos[0], DEBUG_STARTUP.startUpPos[1]));
			o_MultiplayerHandler.AddPlayer(new Vector(DEBUG_STARTUP.startUpPos[0] + 10, DEBUG_STARTUP.startUpPos[1]));
			o_MultiplayerHandler.AddPlayer(new Vector(DEBUG_STARTUP.startUpPos[0] + 20, DEBUG_STARTUP.startUpPos[1]));
			o_MultiplayerHandler.AddPlayer(new Vector(DEBUG_STARTUP.startUpPos[0] + 30, DEBUG_STARTUP.startUpPos[1]));
		}
		else instance_create_depth(DEBUG_STARTUP.startUpPos[0], DEBUG_STARTUP.startUpPos[1], 0, o_Player);
	}
	else room_goto(Room_Disclaimer);
	

}
else room_goto(Room_Disclaimer);
draw_text(480,270, "INITIALIZATION");