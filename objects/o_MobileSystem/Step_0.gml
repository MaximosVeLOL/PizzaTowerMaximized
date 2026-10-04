var i = 0;
var success = false;
for(; i < TOUCH_COUNT;i++) {
	
	if(IS_MOBILE) {
		if(device_mouse_check_button(i, mb_left)) {
			allTouches[i].x = device_mouse_x(i);
			allTouches[i].y = device_mouse_y(i);
			success = true;
		}
	}
	else {
		if(mouse_check_button(mb_left)) {
			allTouches[i].x = window_mouse_get_x();
			allTouches[i].y = window_mouse_get_y();
			success = true;
		}
	}
	if(!success) {
		allTouches[i].x = -1;
		allTouches[i].y = -1;
	}
	onPress(i);
}