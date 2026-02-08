event_inherited();
if(!o_GUIHandler.active) {
	if(keyboard_check_pressed(vk_escape)) {
		DestroyLevel();
	}
	return;
}


if(!isInteracting) {
	offset[0] += (keyboard_check(ord("D")) - keyboard_check(ord("A")) ) * 32;
	offset[1] += (keyboard_check(ord("S")) - keyboard_check(ord("W")) ) * 32;
	camera_set_view_pos(view_camera[0], offset[0], offset[1]);

	if(mouse_check_button(mb_left)) {
		if(mode == "place") {
			if(collision_point(Grid(mouse_x), Grid(mouse_y), all, false, true) == noone && selectedObject != noone) {
					instance_create_depth(Grid(mouse_x), Grid(mouse_y), 0, o_LevelObject, {ID : selectedObject});

			}
		}
		else if(mode == "edit") {
			var inst = collision_point(Grid(mouse_x), Grid(mouse_y), all, false, true);
			if(inst != noone && inst.object_index == o_LevelObject) {
				instance_create_depth(mouse_x, mouse_y, 0, o_MaxGUI_E_PropertyEditor, {targetObject : inst.settings, alignedToGUI : false});
			}
		}
	}
/*
		var detected = false;
		var checkables = [o_Player];
		for(var i = 0 ; i < array_length(checkables);i++) {
			if(selectedObject == checkables[i]) {
			
				with(o_LevelObject) {
					if(ID == checkables[i]) {
						detected = true;
						break;
					}
				}
			
			}
		}
		if(!detected)
		*/
	if(mouse_check_button(mb_right)) {
		var inst = collision_point(mouse_x, mouse_y, all, false, true);
		if(inst != noone && inst.object_index == o_LevelObject) {
				instance_destroy(inst);
				//instance_create_depth(mouse_x, mouse_y, 0, o_MaxGUI_E_PropertyEditor, {targetObject : inst, alignedToGUI : false});
		}
	}
	/*
	if(mouse_check_button_pressed(mb_middle)) {
		var inst = collision_point(mouse_x, mouse_y, all, false, true);
		if(inst != noone && inst.object_index == o_LevelObject) {
				
				instance_create_depth(mouse_x, mouse_y, 0, o_MaxGUI_E_PropertyEditor, {targetObject : inst.settings, alignedToGUI : false});
		}
	}
	*/
	
	if(keyboard_check_pressed(ord("I"))) ImportLevel("MaximizedGM2/level.PTMLVL");
	if(keyboard_check_pressed(ord("O"))) ExportLevel();
}