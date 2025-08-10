//draw_sprite_stretched(sprite_editor_background, -1, -960, -960, room_width + 960, room_height + 960);
if(!visible) return;
var _toRender = "Current Room: " + string(room);
//draw_text(resizeTextByPosition(_toRender, 960, 20), 20, _toRender);
//draw_text(resizeTextByPosition(toolTip, 960, 20), 40, toolTip);
event_inherited();
if(currentObject != noone) draw_sprite_ext(object_get_sprite(currentObject), 0, round(window_mouse_get_x() / gridSize) * gridSize, round(window_mouse_get_y() / gridSize) * gridSize, editorSize[0], editorSize[1], 0, c_white, 1);