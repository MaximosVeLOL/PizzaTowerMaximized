event_inherited();
sprite_index = obj_player.sprite_index;
image_xscale = obj_player.xscale;
mass = 0;
isStatic = false;
velocity[1] = instance_number(object_index) == 1 ? 5 : -5;
if(instance_number(object_index) < 2) instance_create_depth(x,y,0,object_index);