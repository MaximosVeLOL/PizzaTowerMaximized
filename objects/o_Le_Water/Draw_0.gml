//image_blend = c_black;
if(!someoneOnTop) {
	for(var i = 0 ; i < image_xscale;i++) {
		draw_sprite(sprite_index, image_index, x + (i * 32), y);
	}
}
else {
	if(pushDir == 0)
		draw_self();
	else {
		for(var _x = 0 ; _x < image_xscale ; _x++) {
			for(var _y = 0; _y < image_yscale ; _y++) {
				draw_sprite(sprite_index, image_index, x + (_x * 32), y + (_y * 32));
			}
		}
	}
}
//draw_set_color((someoneOnTop ? c_green : c_red));
//draw_ellipse(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
