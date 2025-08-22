event_inherited();

if(isCigarMan) {
	cigarObject.x = x;
	cigarObject.y = y;
	cigarObject.image_index = image_index;
	cigarObject.image_xscale = image_xscale;
	cigarObject.sprite_index = asset_get_index("sprite_enemy_sausageman_cigar_" + curSprite);
	if(state == "hitspecial" || state == "rolling" || state == "land" || state == "hit" || state == "stunned" || state == "fly" || state == "grabbed") {
		instance_deactivate_object(cigarObject);
	}
	else instance_activate_object(cigarObject);
}