if(!visible) {
	if(keyboard_check_pressed(ord("V"))) endLevel();
	return;
}
switch(editorLayer) {
	case EditorLayers.Object:
		gridSize = keyboard_check(vk_shift) ? 0 : 32;
		//Object placement code
		if(currentObject != noone && mouse_check_button(mb_left) && !isInteractingWithGUI() && getObjectTouching(mouse_x, mouse_y) == noone) {
			instance_create_depth(round(mouse_x / gridSize) * gridSize, round(mouse_y / gridSize) * gridSize, 0, o_LevelEditorObject, {image_xscale : editorSize[0], image_yscale : editorSize[1]});
		}
		//Object edit code
		if(mouse_check_button(mb_right)) {
			var obj = getObjectTouching(mouse_x, mouse_y);
			if(obj != noone) {
				instance_destroy(obj);
			}
		}
		if(keyboard_check_pressed(ord("X"))) editorSize[0] *= -1;
		if(keyboard_check_pressed(ord("Y"))) editorSize[1] *= -1;
		
	break;
}
if(keyboard_check_pressed(vk_shift)) Save();
var moveX = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
var moveY = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
x += moveX * gridSize;
y += moveY * gridSize;
camera_set_view_pos(view_camera[0], x, y);
//Log(StrCat(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[1])));