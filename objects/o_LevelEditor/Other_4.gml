if(mode == "export") {
	Log("Exporting room " + string(rmIndex) + "!");
	var objects = instance_number(o_LevelObject);
	
	//buffer_write(outBuffer, buffer_u16, room_width);
	//buffer_write(outBuffer, buffer_u16, room_height);

	//buffer_write(outBuffer, buffer_u32, layer_background_get_sprite(layer_background_get_id(layer_get_id("Background"))));
	buffer_write(outBuffer, buffer_u16, objects);
	for(var i = 0 ; i < objects;i++) {
		var inst = instance_find(o_LevelObject, i);
		buffer_write(outBuffer, buffer_u16, inst.x);
		buffer_write(outBuffer, buffer_u16, inst.y);
		buffer_write(outBuffer, buffer_u32, inst.ID);
	}
	rmIndex++;
	if(rmIndex >= array_length(rooms)) {
		mode = "place";
		rmIndex = 0;
		/*
		var dir = "MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/LevelEditor/" + projectName + ".PTMLVL";
		if(file_exists(dir)) { //filename = filename
			while(file_exists(dir + string(fileIndex))) { //filename0 = filename
				fileIndex++;
			}
			dir += string(fileIndex);
		}
		*/
		var dir = BASE_DIRECTORY + "/LevelEditor/" + level.name + ".PTMLVL"
		buffer_save(outBuffer, dir);
		buffer_delete(outBuffer);
		Log("Finished export! (exported to " + dir + ")");
		room_goto(rooms[0]);
	}
	else room_goto(rooms[rmIndex]);
}
else if(mode == "import") {
	if(rmIndex >= roomCount) {
		mode = "place";
		if(playOnEnter)
			SetupLevel();
	}
	
	Log("Parsing room " + string(rmIndex) + "!");
	
	//room_width = buffer_read(outBuffer, buffer_u16);
	//room_height = buffer_read(outBuffer, buffer_u16);
	//layer_background_sprite(layer_background_get_id(layer_get_id("Background")), buffer_read(outBuffer, buffer_u32));

	var instanceCount = buffer_read(outBuffer, buffer_u16);
	Log("Instance count: " + string(instanceCount));
	repeat(instanceCount) {
		var outPos = new Vector(buffer_read(outBuffer, buffer_u16), buffer_read(outBuffer, buffer_u16));
		instance_create_depth(outPos.x, outPos.y, 0, o_C_Wall);
		buffer_read(outBuffer, buffer_u16);
	}

	rmIndex++;
	if(rmIndex >= roomCount) {
		rmIndex = 0;
		/*
		var dir = "MaximizedGM2/Save" + string(global.settings.saveFileIndex) + "/LevelEditor/" + projectName + ".PTMLVL";
		if(file_exists(dir)) { //filename = filename
			while(file_exists(dir + string(fileIndex))) { //filename0 = filename
				fileIndex++;
			}
			dir += string(fileIndex);
		}
		*/
		buffer_delete(outBuffer);
		
		room_goto(rooms[0]);
	}
	else {
		createRoom();
		var list = MaxGUI_FindElement("lE_L");
		//256/5 = (32 [sprite height] * 8 [yscale]) / 5 [squish to fit]
		list.Add("Room " + string(rmIndex + 1));
		room_goto(rooms[rmIndex]);
	}
}
else if(mode == "exit") {
	with(o_LevelObject) instance_destroy();
	room_restart();
	rmIndex++;
	if(rmIndex >= array_length(rooms)) {
		with(all) persistent = false;
		Destroy();
		room_goto(Room_LevelEditor_Menu);
	}
	else {
		room_goto(rooms[rmIndex]);
	}
}
with(o_MaxGUI_E_ElementParent) {
	persistent = true;
}