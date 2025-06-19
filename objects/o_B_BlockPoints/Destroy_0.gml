event_inherited();
if(image_xscale != 2) instance_create_depth(x + 16,y + 16,0,o_Le_Points);
else {
	instance_create_depth(x,y + 16,0,o_Le_Points);
	instance_create_depth(x + 16,y,0,o_Le_Points);
	instance_create_depth(x + 16,y + 16,0,o_Le_Points);
	instance_create_depth(x + 16,y,0,o_Le_Points);
}