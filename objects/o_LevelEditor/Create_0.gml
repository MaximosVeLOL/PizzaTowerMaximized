event_inherited();
objectListElement = o_MaxGUI_E_ObjectList;
selectedObject = noone;
depth = 99;
gridSize = 32;
mode = "place";
if(!global.settings.audioSettings.muteAll) o_MusicManager.playNewSong(music_editor);

function Grid(value) {
	return ceil(value / gridSize) * gridSize;
}

SetupLevel = function() {

	visible = false;
	active = false;
	with(o_LevelObject) {
		if(ID == o_Le_LevelGate)
			instance_create_depth(x, y - 50, 0, o_Player);
	}
	instance_create_depth(0, 0, 0, o_Camera);
	with(o_LevelObject) {
		Summon();
	}
	o_MusicManager.playNewSong(music_water);
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
	/*
		Background
		Song
		Objects
	
	*/
	var outBuffer = buffer_create(0, buffer_grow, 1);
	//buffer_write()
	for(var i = 0 ; i < instance_number(o_LevelObject);i++) {
		buffer_write(outBuffer, buffer_u32, o_LevelObject.x); //4
		buffer_write(outBuffer, buffer_u32, o_LevelObject.y); //8
		buffer_write(outBuffer, buffer_u32, o_LevelObject.ID); //12
	}
	//Every object is 12 bytes so object count = size/12
	
	buffer_save(outBuffer, "MaximizedGM2/level.PTMLVL");
	buffer_delete(outBuffer);
}

ImportLevel = function(fileName) {
	var inBuffer = buffer_load(fileName);
	if(inBuffer == -1) return;
	var size = 0;
	buffer_seek(inBuffer, buffer_seek_end, 0);
	size = buffer_tell(inBuffer);
	buffer_seek(inBuffer, buffer_seek_start, 0);
	for(var i = 0 ; i < size/12;i++) {
		instance_create_depth(buffer_read(inBuffer, buffer_u32), buffer_read(inBuffer, buffer_u32), 0, buffer_read(inBuffer, buffer_u32));
	}
	buffer_delete(inBuffer);
}

/*
	Created objects have two things:
		Object ID
		Spawn struct (loaded from JSON)

*/