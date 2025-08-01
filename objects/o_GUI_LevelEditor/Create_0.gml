o_event_inherited();
add(new Screen());
depth = -1000;
currentObject = noone;
gridSize = 32;

levelSettings = {
	name : "",
	startRoom : -1,
	startSong : 0,
};
minRoomIndex = -1;
maxRoomIndex = -1;

toolTip = "";
enum EditorLayers {
	None = 0,
	Object,
	Tile,
	EditMode,
}
editorLayer = 0;
editorSize = [1,1];
errors = [];

o_GameManager.mode = "editor";
if(instance_exists(o_MusicManager)) o_MusicManager.playNewSong(music_editor);
getObjectTouching = function(_x,_y) {
	_x = round(_x / gridSize) * gridSize;
	_y = round(_y / gridSize) * gridSize;
	show_message(StrCat(_x, _y, instance_place(_x,_y, all) ));
	return instance_place(_x, _y, all);
}
createLevel = function() {
	var newRoom = room_add();
	room_set_viewport(newRoom, 0, true, 0, 0, 960, 540);
	room_set_camera(newRoom, 0, camera_create_view(0,0,960,540));
	room_set_width(newRoom, 960);
	room_set_height(newRoom, 540);
	room_set_view_enabled(newRoom, true);
	room_goto(newRoom);
	minRoomIndex = newRoom;
	
	//prompt("Input Level Name", function(str){levelSettings.name = str});
}
createRoom = function() {
	var newRoom = room_add();
	room_set_viewport(newRoom, 0, true, 0, 0, 960, 540);
	room_set_camera(newRoom, 0, camera_create_view(0,0,960,540));
	room_set_width(newRoom, 960);
	room_set_height(newRoom, 540);
	room_set_view_enabled(newRoom, true);
	room_goto(newRoom);
	maxRoomIndex = newRoom;
	roomArray[array_length(roomArray)] = "Room " + string(array_length(roomArray));
	screens[0].Get("editor_utilities").Get()
}

startLevel = function() {
	CreatePlayer(0,0);
	var objects = [o_Camera, o_MultiplayerSystem];
	for(var i = 0 ; i < array_length(objects);i++) {
		instance_create_depth(0,0,0,objects[i]);
	}
	o_GameManager.mode = "game";
	with(o_LevelEditorObject) {
		activate();
	}
	var targPos = instance_exists(o_Le_LevelGate) ? [o_Le_LevelGate.x, o_Le_LevelGate.y - 50 /*The Player's sprite's y center*/] : [mouse_x, mouse_y];
	o_PlayerParent.x = targPos[0];
	o_PlayerParent.y = targPos[1];
	visible = false;
}
endLevel = function() {
	var objects = [o_LevelEditorObject, o_GUI_LevelEditor, o_GameManager];
	var confirm = false; //Don't waste ram kids!
	for(var i = 0 ; i < instance_count;i++) {
		for(var j = 0 ; j < array_length(objects);j++) {
			if(instance_id[i].object_index == objects[j]) {
				confirm = false;
				break;
			}
			else confirm = true;
		}
		if(confirm) instance_destroy(instance_id[i]);
	}
	o_GameManager.mode = "editor";
}
addError = function(err, inst) {
	array_push(errors, "New error (" + StrCat(get_timer() / 1_000_000, object_get_name(inst), inst) + ": " + err);
	if(!show_question("From " + object_get_name(inst) + "\n" + err + "\n\n Continue?")) endLevel();

}
Save = function() {
	var saveBuffer = buffer_create(0, buffer_grow, 1);
	//buffer_write(buffer_u8, buffer_grow, 01);
	buffer_write(saveBuffer, buffer_u64, 00);
	for(var i = 0 ; i < instance_number(o_LevelEditorObject);i++) {
		with(instance_find(o_LevelEditorObject, i) ) {
			buffer_write(saveBuffer, buffer_u16, x);
			buffer_write(saveBuffer, buffer_u16, y);
			buffer_write(saveBuffer, buffer_u8, image_xscale);
			buffer_write(saveBuffer, buffer_u8, image_yscale);
			buffer_write(saveBuffer, buffer_u8, 0xFF);
		}
	}
	buffer_save(saveBuffer, "MaximizedGM2/LevelEditor/test.ptmles"); //P.T.M.L.E.S - Pizza Tower: Maximized Level Editor Save 
}








//screens[0].Add(new VariableEditor(100, 100, 200, 200, currentRoomSettings, 1, false), "editor_room");
//screens[0].Add(new VariableEditor(200, 100, 200, 200, levelSettings, 1, false), "editor_level");
screens[0].Add(new ObjectList(0,100,400,200, [[o_C_Wall, o_C_Slope, o_C_Platform], [o_Le_Door, o_Le_KeyDoor, o_Le_Transition, o_Le_LevelGate], [o_Le_Points, o_Le_BigPoints, o_Le_Key, o_Le_LapPoints, o_Le_Pizzabox, o_Le_Pizzakin, o_Le_Treasure], [o_Le_En_Cheeseslime, o_Le_En_SausageMan, o_Le_En_Goblin]], ["Collision", "Warp", "Collectable", "Enemies"] , 6, false), "objectList");

buttonShit = function() {
	room_width = real(get_string("New Room Width", ""));
	room_width = real(get_string("New Room Height", ""));
	return;
	prompt("New room size (w, h) (use \",\", or a space to seperate the size)", function(num){
		var _temp;
		var _out = [];
		for(var i = 0 ; i < string_length(num);i++) {
			_temp += string_char_at(num, i);
			if(string_count(" ", _temp) > 0 || i == string_length(num) - 1 ) {
				var _real = string_count(" ", _temp) > 0 ? string_copy(_temp, 1, string_length(_temp) - 1) : _temp;
				array_push(_out, real(_real));
				if(array_length(_out) > 2) throw("Invalid size proportions!");
			}
		}
		}, 0, [500,500]);
}
roomArray = ["Room 0"];
screens[0].Add(new Panel(100, 100, 200, 200, [new Button(100, 100, 200,50,  buttonShit, "Change Room Size"), new Button(100, 200, 200, 50, function(){layer_background_sprite(layer_background_get_id(layer_get_id("Background")), asset_get_index(get_string("Input sprite name", "") ) )}, "Change Room BG")], false), "editor_room");
screens[0].Add(new Panel(300, 100, 200, 200, [new Button(300, 100, 200, 50, createRoom, "Create New Room")], false), "editor_util");
screens[0].Get("editor_util").Add(new List(500, 100, 100, 100, roomArray, function(index){if(minRoomIndex + index < maxRoomIndex)room_goto(minRoomIndex + index); }), "roomList");

screens[0].Add(new Button(0, 0, 100, 100, function(){getCurrentScreen().Get("objectList").Toggle();editorLayer = EditorLayers.Object;toolTip = "Press X to flip objects horizontally\nPress Y to flip objects vertically"; }, "Objects"));
screens[0].Add(new Button(100, 0, 100, 100, function(){getCurrentScreen().Get("editor_room").Toggle()}, "Room Settings"));
screens[0].Add(new Button(200, 0, 100, 100, function(){getCurrentScreen().Get("editor_level").Toggle()}, "Level Settings"));
screens[0].Add(new Button(300, 0, 100, 100, function(){getCurrentScreen().Get("editor_util").Toggle()}, "Utilities"))
screens[0].Add(new Button(400, 0, 100, 100, startLevel, "Play"));
//getCurrentScreen().Add(new VariableEditor(480,270, 200, 200, self, 0));