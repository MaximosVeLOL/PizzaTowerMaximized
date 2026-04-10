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
		if(inst != noone) Log("Touching an object! (" + object_get_name(inst.object_index) + ")");
		if(mode == "place" && inst == noone && selectedObject != noone) {
			instance_create_depth(Grid(mouse_x), Grid(mouse_y), 0, o_LevelObject, {ID : selectedObject});
		}
		if(mode == "edit") {
			if(editObject == noone || editObject != noone && sqrt( power(mouse_x - editObject.x, 2) + power(mouse_y - editObject.y, 2)) > 76) editObject = inst;
			if(editObject != noone) {
				editObject.x = Grid(mouse_x);
				editObject.y = Grid(mouse_y);
			}
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
	//if((mouse_check_button_released(mb_right) || mouse_check_button_released(mb_left)) && mode == "edit") editObject = noone;
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
		var inst = GetObjectTouching(false);
		if(inst != noone) {
			
			if(mode == "place") {

				instance_destroy(inst);
				//instance_create_depth(mouse_x, mouse_y, 0, o_MaxGUI_E_PropertyEditor, {targetObject : inst, alignedToGUI : false});

			}
		}
		if(mode == "edit" && editObject != noone) {
			editObject.image_xscale = (Grid(mouse_x) - editObject.x ) / 32;
			if(editObject.image_xscale == 0)
				editObject.image_xscale = 1;
			editObject.image_yscale = (Grid(mouse_y) - editObject.y ) / 32;
			if(editObject.image_yscale == 0)
				editObject.image_yscale = 1;
		}

	}

	if(mouse_check_button_pressed(mb_middle) && !instance_exists(o_MaxGUI_E_PropertyEditor)) {
		return;
		var inst = collision_point(mouse_x, mouse_y, all, false, true);
		if(inst != noone && inst.object_index == o_LevelObject) {
				instance_create_depth(mouse_x, mouse_y, -10, o_MaxGUI_E_PropertyEditor, {targetObject : inst.settings, alignedToGUI : false});
		}
	}

	
	//if(keyboard_check_pressed(ord("I"))) ImportLevel(get_open_filename("Pizza Tower Maximized Level|*.PTMLVL", ""));
	if(keyboard_check_pressed(ord("O"))) ExportLevel();
}
previousMouse = new Vector(mouse_x, mouse_y);