event_inherited();
objectListElement = o_MaxGUI_E_ObjectList;
selectedObject = noone;
depth = 99;
gridSize = 32;
mode = "place";
//Room index for exporting/importing
rmIndex = 0;
//The buffer for importing/exporting
outBuffer = -1;
//Amount of rooms when importing
roomCount = 0;
//All of the rooms in the level
rooms = [Room_LevelEditor];
notification = [false, 0];

level = {
	name : "UnsetName",
	song : music_water,
	
};

ReturnToMenu = function() {
	mode = "exit";
	rmIndex = 0;
	o_MusicManager.stopMusic(true);
	room_goto(rooms[0]);
}

alarm[0] = (60 * 60) * 5; //Save every 5 minutes
if(!global.settings.audio.muteAll) o_MusicManager.playNewSong(music_editor);

function Grid(value) {
	return round(value / gridSize) * gridSize;
}
function GetObjectTouching(usePosition = true) {
	/*
	for(var i = 0 ; i < instance_number(object);i++) {
		var inst = instance_find(object, i);
		if(_x >= inst.x && inst.x <= x + sprite_width && _y >= y && _y <= y + sprite_height)
			return 
	}
	*/
	var _x = Grid(mouse_x);
	var _y = Grid(mouse_y);
	with(o_LevelObject) {
		if(usePosition) {
			if(x == o_LevelEditor.Grid(mouse_x) && y == o_LevelEditor.Grid(mouse_y)) {
				return id;
			}
		}
		else {
			if(_x >= bbox_left && _x <= bbox_right && _y >= bbox_top && _y <= bbox_bottom) {
				return id;
			}
		}

		//if(_x >= x && _x <= x + (sprite_width * image_xscale) && _y >= y && _y <= y + (sprite_height * image_xscale)) {
		//	return id;
		//}
		
		//This also checks for object size, which is needed by the edit mode.
		//if(_x >= bbox_left && _x <= bbox_right && _y >= bbox_top && _y <= bbox_bottom) {
		//	return id;
		//}
	}
	return noone;
}


createRoom = function(width = 960, height = 540, backgroundSprite = sprite_editor_background) {
	var _room = room_add();
	array_push(rooms, _room);
	room_set_camera(_room, 0, camera_create_view(0, 0, 960, 540));
	room_set_view_enabled(_room, true);
	room_set_viewport(_room, 0, true, 0, 0, 960, 540);
	room_set_persistent(_room, true); //For editing purposes.settings..
	room_set_width(_room, width);
	room_set_height(_room, height);
	layer_set_target_room(_room);
	//Create all the layers
	layer_create(0, "FG");
	layer_create(100, "FG");
	layer_create(200, "Instances");
	var bg = layer_background_create(layer_create(100, "Background"), backgroundSprite);
	layer_background_htiled(bg, true);
	layer_background_vtiled(bg, true);

	
}

enum ErrorType {
	UserFault = 0,
	ObjectNotExists = 1,
};

ShowError = function(type, _message) {
	//var o = instance_create_depth()
	
	MaxGUI_CreateAlert(offset[0] + 320, offset[1] + 240, 14, 9, "An error has occured!\n" + _message);
}

SetupLevel = function() {

	visible = false;
	active = false;
	with(o_LevelObject) {
		if(ID == o_Le_LevelGate)
			instance_create_depth(x, y - 50, 0, o_Player);
	}
	if(!instance_exists(o_Player)) {
		visible = true;
		active = true;
		//ShowError(ErrorType.UserFault, "No suitable o_Le_LevelGate to spawn the player in!");
		return false;
	}
	instance_create_depth(0, 0, 0, o_Camera);
	with(o_LevelObject) {
		Summon();
	}
	o_MusicManager.playNewSong(music_water);
	return true;
}
DestroyLevel = function() {
	visible = true;
	active = true;
	instance_destroy(o_Player);
	instance_destroy(o_Camera);
	with(o_LevelObject) {
		Respawn();
	}
	o_MusicManager.playNewSong(music_editor);
		
}

ExportLevel = function() {
	mode = "export";
	outBuffer = buffer_create(0, buffer_grow, 1);
	buffer_write(outBuffer, buffer_u8, 0x00); //Version 0.00
	//Make sure to write the projectName
	
	buffer_write(outBuffer, buffer_u8, array_length(rooms)); //Amount of rooms
	room_goto(rooms[0]);
}

ImportLevel = function(fileName) {
	outBuffer = buffer_load(fileName);
	if(outBuffer == -1) return;
	Log("Version " + string(buffer_read(outBuffer, buffer_u8)) + "!");
	mode = "import";
	roomCount = buffer_read(outBuffer, buffer_u8);
	room_goto(rooms[0]);
	/*
	var currentLetter = "";
	while(currentLetter != 0x00) {
		currentLetter = buffer_read(inBuffer, buffer_s8);
		projectName += chr(currentLetter);
	}
	
	Log("Project name: " + projectName);
	*/
	return;
	var roomList = MaxGUI_FindElement("lE_L");
	//256/5 = (32 [sprite height] * 8 [yscale]) / 5 [squish to fit]
	var roomAmount = buffer_read(inBuffer, buffer_u8);
	Log("Amount of rooms: " + string(roomAmount));
	for(var curRoom = 0 ; curRoom < roomAmount ;curRoom++) {
		Log("Reading room " + string(curRoom));
		if(curRoom > 0) {
			Log("Creating room and adding to list!");
			roomList.Add("Room " + string(curRoom + 1));
			createRoom(buffer_read(inBuffer, buffer_u16), buffer_read(inBuffer, buffer_u16), sprite_editor_background);
		}
		else {
			room_set_width(rooms[0], buffer_read(inBuffer, buffer_u16));
			room_set_height(rooms[0], buffer_read(inBuffer, buffer_u16));
		}
		buffer_read(inBuffer, buffer_u32);
		room_goto(rooms[curRoom]);
		var instanceCount = buffer_read(inBuffer, buffer_u16);
		Log("Instance count: " + string(instanceCount));
		for(var i = 0 ; i < instanceCount;i++) {
			//instance_create_depth(buffer_read(inBuffer, buffer_u16), buffer_read(inBuffer, buffer_u16), 0, o_LevelObject, {ID : buffer_read(inBuffer, buffer_u16)});
			var toPos = new Vector(buffer_read(inBuffer, buffer_u16),  buffer_read(inBuffer, buffer_u16));
			Log("Creating instance " + string(i) + " at " + string(toPos.x) + " " + string(toPos.y));
			instance_create_depth(toPos.x, toPos.y, 0, o_C_Wall);
			buffer_read(inBuffer, buffer_u16);
		}
	}
	room_goto(rooms[0]);
	buffer_delete(inBuffer);
}
editObject = noone;