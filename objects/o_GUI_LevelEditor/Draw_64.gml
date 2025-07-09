//draw_sprite_stretched(sprite_editor_background, -1, -960, -960, room_width + 960, room_height + 960);
draw_set_color(c_black);
draw_text(resizeTextByPosition(toolTip, 600), 20, toolTip);
GUI_RESET;
event_inherited();

if(currentObject != noone) draw_sprite(object_get_sprite(currentObject), 0, round(window_mouse_get_x() / gridSize) * gridSize, round(window_mouse_get_y() / gridSize) * gridSize);
