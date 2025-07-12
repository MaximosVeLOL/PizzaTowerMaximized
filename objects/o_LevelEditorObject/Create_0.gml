targetObject = o_GUI_LevelEditor.currentObject;
activate = function() {
	instance_create_depth(x,y, 0, targetObject);
	//Log("Created object " + object_get_name(targetObject) + " at (" + StrCat(x,y) + ")");
	visible = false;
	if(place_meeting(x,y,all)) {
		Log("I'm an extra object...");
		instance_destroy();
	}
	//image_alpha = 0.5;
}
sprite_index = object_get_sprite(targetObject);