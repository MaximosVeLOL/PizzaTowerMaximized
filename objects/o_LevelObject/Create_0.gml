sprite_index = object_get_sprite(ID);
settings = {};
child = noone;

/*
	Create the object
	get the struct
	Put into settings var
	destroy object
*/

child = instance_create_depth(x,y,0, ID);
var names = variable_instance_get_names(child);
for(var i = 0 ; i < array_length(names);i++) {
	variable_struct_set(settings, names[i], variable_instance_get(child, names[i]));
}
instance_destroy(child, false);
child = noone;


Summon = function() {
	child = instance_create_depth(x,y,0, ID);
	var names = variable_struct_get_names(settings);
	for(var i = 0 ; i < array_length(names);i++) {
		variable_instance_set(child, names[i], variable_struct_get(settings, names[i]));
	}
	visible = false;
}

Respawn = function() {
	instance_destroy(child, false);
	child = noone;
	visible = true;
}