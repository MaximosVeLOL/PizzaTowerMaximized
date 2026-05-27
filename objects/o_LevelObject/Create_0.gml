sprite_index = object_get_sprite(ID);
mask_index = sprite_index;
x += sprite_get_xoffset(sprite_index);
y += sprite_get_yoffset(sprite_index);
//mask_index = sprite_editor_32x;
settings = [];
for(var i = 0 ; i < array_length(o_LevelEditor.objectDefinitions);i++) {
	if(o_LevelEditor.objectDefinitions[i].objectName == object_get_name(ID)) {
		settings = o_LevelEditor.objectDefinitions[i].properties;
		for(var j = 0; j < array_length(settings);j++) {
			var val = "";
			var v = settings[j].value;
			switch(settings[j].type) {
				case VariableType.Real:
					val = string(v);
				break;
				
				case VariableType.String:
					val = v;
				break;
				
				case VariableType.AssetRoom:
					val = (v == -1 ? "None" : room_get_name(v));
				break;
				
				case VariableType.ObjectVector:
					val = string(v.x) + " " string(v.y);
				break;

			}
		settings[j].renderValue = val;
		}
		return;
	}
}
//settings = {visible : true};
child = noone;

/*
	Create the object
	get the struct
	Put into settings var
	destroy object
*/

child = instance_create_depth(x,y,0, ID);
/*
var names = variable_instance_get_names(child);
for(var i = 0 ; i < array_length(names);i++) {
	variable_struct_set(settings, names[i], variable_instance_get(child, names[i]));
}
settings.visible = child.visible;
*/
instance_destroy(child, false);
child = noone;


Summon = function() {
	child = instance_create_depth(x,y,0, ID, {image_xscale : self.image_xscale, image_yscale : self.image_yscale});
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