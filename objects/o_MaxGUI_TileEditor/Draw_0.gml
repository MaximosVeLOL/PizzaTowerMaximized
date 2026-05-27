draw_self();
draw_sprite_stretched(tileset_sprite_tower, 0, x, y, sprite_width, sprite_height);
//draw_sprite(tileset_sprite_tower, 0, x, y);
if(inBounds) {
	var mX = Grid(mouse_x - x, gridWidth);
	var mY = Grid(mouse_y - y, gridHeight);
	if(mouse_check_button_pressed(mb_left)) {
		tileX = mX;
		tileY = mY;
	}
	
	draw_set_color(c_white);
	draw_rectangle(x + mX, y + mY, x + mX + gridWidth, y + mY + gridHeight, true);
}
draw_set_color(c_white);
draw_rectangle(x + tileX, y + tileY, x + tileX + gridWidth, y + tileY + gridHeight, true);

GUI_RESET;