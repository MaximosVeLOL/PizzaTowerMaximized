event_inherited();
//Exiting/Return code
if(keyboard_check_pressed(vk_escape)) {
	if(active) {
		ReturnToMenu();
	}
	else DestroyLevel();
}

//Don't do anything if we aren't active
if(!active)
	return;

if(!isInteracting && !isTyping) {
	offset[0] += (keyboard_check(ord("D")) - keyboard_check(ord("A")) ) * 32;
	offset[1] += (keyboard_check(ord("S")) - keyboard_check(ord("W")) ) * 32;
	//TODO - Add zoom features
	camera_set_view_pos(view_camera[0], offset[0], offset[1]);
	if(mouse_check_button(mb_left)) {
		var inst = GetObjectTouching();
		switch(mode) {
			case 0:
				if(selectedObject != noone)
					instance_create_depth(Grid(mouse_x), Grid(mouse_y), 0, o_LevelObject, {ID : selectedObject});
			break;
			
			case 1:
				if(editObject == noone || editObject != noone && distance_to_point(mouse_x - editObject.x, mouse_y - editObject.y) /*sqrt( power(mouse_x - editObject.x, 2) + power(mouse_y - editObject.y, 2)) > 76*/) editObject = inst;
				if(editObject != noone) {
					editObject.x = Grid(mouse_x);
					editObject.y = Grid(mouse_y);
				}
			break;
			
			case 2:
				var reqTileset = layer_tilemap_get_id(layer_get_id((useFG ? "FG" : "BG")));
				var reqTile = (o_MaxGUI_TileEditor.tileY * 11) + o_MaxGUI_TileEditor.tileX;
				//tilemap_set_at_pixel(reqTileset, reqTile, Grid(mouse_x), Grid(mouse_y));

				tilemap_set_at_pixel(reqTileset, tilemap_get(reqTileset, o_MaxGUI_TileEditor.tileX, o_MaxGUI_TileEditor.tileY), Grid(mouse_x), Grid(mouse_y));
				//tilemap_set(reqTileset, tilemap_get(tileset_tower))
			break;
		}
		
		//if(inst != noone) Log("Touching an object! (" + object_get_name(inst.object_index) + ")");

	}
	if(mouse_check_button(mb_right)) {
		var inst = GetObjectTouching(false);
		switch(mode) {
			case 0:
			if(inst != noone)
				instance_destroy(inst);
			break;
			
			case 1:
				editObject.image_xscale = (Grid(mouse_x) - editObject.x ) / 32;
				if(editObject.image_xscale == 0)
					editObject.image_xscale = 1;
				editObject.image_yscale = (Grid(mouse_y) - editObject.y ) / 32;
				if(editObject.image_yscale == 0)
					editObject.image_yscale = 1;
			break;
			
			case 2:
			
			break;
		}



	}

	if(mouse_check_button_pressed(mb_middle) && mode != 2 && !instance_exists(o_MaxGUI_E_PropertyEditor)) {
		var inst = collision_point(mouse_x, mouse_y, all, false, true);
		if(inst != noone && inst.object_index == o_LevelObject) {
				instance_create_depth(mouse_x, mouse_y, -10, o_MaxGUI_E_PropertyEditor, {targetObject : inst, alignedToGUI : false});
		}
	}

	if(keyboard_check(vk_control)) {
		if(mode == "edit") {
			if(keyboard_check_pressed(ord("C")) && editObject != noone)
				Log("Copy placeholder!");
			if(keyboard_check_pressed(ord("V")) )
				Log("Paste placeholder!");
			if(keyboard_check_pressed(ord("S")) )
				ExportLevel();
		}
	}
	//if(keyboard_check_pressed(ord("I"))) ImportLevel(get_open_filename("Pizza Tower Maximized Level|*.PTMLVL", ""));
	if(keyboard_check_pressed(ord("O"))) ExportLevel();
}
previousMouse = new Vector(mouse_x, mouse_y);