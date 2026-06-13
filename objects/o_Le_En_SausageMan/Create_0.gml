event_inherited();
mass = 0.5;
cigarObject = (isCigarMan ? instance_create(x, y, o_H_Cigar) : noone);
cigarSprites = {};
var names = struct_get_names(sprite);
for(var i = 0 ; i < array_length(names);i++) {
	variable_struct_set(cigarSprites, names[i], asset_get_index("sprite_enemy_sausageman_cigar_" + names[i]));
}
//All enemy sprites are already defaulted to the sausageman.
mask_index = spr_player_mask;