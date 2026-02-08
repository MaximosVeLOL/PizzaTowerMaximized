if(!o_GUIHandler.active) return;
var i = 0;

var PAGE_WIDTH = 100;
var PAGE_HEIGHT = 25;

var OBJECT_WIDTH = 32;
var OBJECT_HEIGHT = 32;

var MAX_OBJECT_WIDTH = floor((sprite_width - PAGE_WIDTH) / OBJECT_WIDTH);
draw_self();

var xCheck = mouse_x >= bbox_left && mouse_x <= bbox_left + PAGE_WIDTH; //We don't need to repeat this for i times.
for(; i < array_length(objectList);i++) {
	if(xCheck && mouse_y >= y + (PAGE_HEIGHT * i ) && mouse_y <= y + (PAGE_HEIGHT * (i + 1) ) ) {
		image_index = 1;
		if(mouse_check_button_pressed(mb_left)) {
			objectPage = i;
			
		}
	}
	draw_sprite_stretched(sprite_index, image_index, x, y + (PAGE_HEIGHT * i), PAGE_WIDTH, PAGE_HEIGHT);
	image_index = 0;
	draw_text(x + 10, (y + (PAGE_HEIGHT * (i + 1))) - (PAGE_HEIGHT / 2) - 8, objectList[i][0] );
}
var yPos = 0;
var ignore = false;

for(i = 1 ; i < array_length(objectList[objectPage]);i++) {
	var curObject = objectList[objectPage][i];
	var blend = c_white;
	if(mouse_x >= bbox_left + PAGE_WIDTH + (OBJECT_WIDTH * (i - 1)) && mouse_x <= bbox_left + PAGE_WIDTH + (OBJECT_WIDTH * i) && mouse_y >= y + 1 + (OBJECT_HEIGHT * yPos) && mouse_y <= y + 1 + (OBJECT_HEIGHT * (yPos + 1))  ) {
		blend = c_gray;
		if(mouse_check_button_pressed(mb_left) && !ignore) {
			objectSelected = [objectPage, curObject];
			onObjectSelect(curObject);
			ignore = true;
		}
	}
	if(objectSelected[0] == objectPage  && objectSelected[1] == i) blend = c_green;
	
	//draw_sprite_general(object_get_sprite(curObject), 0, 0, 0, OBJECT_WIDTH, OBJECT_HEIGHT, x + PAGE_WIDTH + (OBJECT_WIDTH * (i - 1)), y + 1 +(OBJECT_HEIGHT * yPos), 1, 1, 0, blend, blend, blend, blend, 1);
	var sprite = object_get_sprite(curObject);
	if(sprite == -1) sprite = sprite_editor_unknown;
	draw_sprite_stretched_ext(sprite, 0, x + PAGE_WIDTH + (OBJECT_WIDTH * (i - 1)), y + 1 + (OBJECT_HEIGHT * yPos), OBJECT_WIDTH, OBJECT_HEIGHT, blend, 1);
	//draw_text(x + PAGE_WIDTH + (OBJECT_WIDTH * i), y + (OBJECT_HEIGHT * yPos), string(i) + ", " + string(yPos));
	if(i % MAX_OBJECT_WIDTH == 0 && i > 0) yPos++;
}

GUI_RESET;