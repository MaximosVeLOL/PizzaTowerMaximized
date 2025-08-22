event_inherited();
child.x = x;
child.y = y;
child.image_xscale = image_xscale;
if(state == "stun") {
	instance_deactivate_object(child);
}
else instance_activate_object(child);
if(keyboard_check_pressed(ord("R") ) ) die();