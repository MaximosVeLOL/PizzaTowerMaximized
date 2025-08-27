event_inherited();
if(state == "stun") instance_deactivate_object(child);
else {
	instance_activate_object(child);
	child.x = x;
	child.y = y;
	child.image_xscale = image_xscale;
}