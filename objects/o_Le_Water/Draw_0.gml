//image_blend = c_black;
if(!someoneOnTop) {
	for(var i = 0 ; i < image_xscale;i++) {
		draw_sprite(sprite_index, image_index, x + (i * 32), y);
	}
}
else draw_self();
//draw_set_color((isTop ? c_green : c_red));
//draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
