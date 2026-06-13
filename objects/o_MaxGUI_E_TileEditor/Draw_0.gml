draw_self();
draw_sprite_stretched(tileset_sprite_tower, 0, x, y, sprite_width, sprite_height);
draw_sprite(sprite_editor_32x, 0, x, y);
//draw_sprite(tileset_sprite_tower, 0, x, y);
if(inBounds) {
	var mX = Grid(mouse_x - x, 1, gridWidth);
	var mY = Grid(mouse_y - y, 1, gridHeight);
	if(mouse_check_button_pressed(mb_left)) {
		tileX = floor((mouse_x - x) / gridWidth);
		tileY = floor((mouse_y - y) / gridHeight);
	}
	
	draw_set_color(c_white);
	draw_rectangle(x + mX, y + mY, x + mX + gridWidth, y + mY + gridHeight, true);
}
draw_set_color(c_white);
var tX = (tileX * gridWidth);
var tY = (tileY * gridHeight);
draw_rectangle(x + tX, y + tY, x + tX + gridWidth, y + tY + gridHeight, true);

GUI_RESET;