movespeed = 1.5;
state = "idle";
mass = 0.5;
curMass = mass;
velocity = [0,0];
tempVar = [0,0,20];
animVar = false;
targetPD = -1;
stunnable = true;
die = function(dead_sprite, canMove = false) {
	instance_destroy();
	if(canMove) instance_create_depth(x,y,0,o_P_Effect, {sprite_index : dead_sprite});
	else instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : dead_sprite});
}
dropPoints = false;
setState = function(newState, overTemp = true) {
	state = newState;
	image_index = 0;
	image_speed = 1;
	if(overTemp) tempVar = [0,0,tempVar[2]];
	animVar = false;
	curMass = mass;
}
name = "";
curSprite = "";
var obName = object_get_name(object_index);
for(var i = 0; i <= string_length(obName);i++) {
	name += string_lower(string_char_at(obName, i));
	if(string_count("en_", name) > 0) {
		name = "";
	}
}
//mask_index = spr_player_mask;
setSprite = function(reqSpriteName) {
	//if(!is_string(reqSpriteName)) LogError("Invalid type!", true);
	sprite_index = asset_get_index("sprite_enemy_" + name + "_" + reqSpriteName);
	mask_index = spr_player_mask;
	//image_index = 0;
	//image_speed = 1;
	if(sprite_index == -1) LogError("Invalid sprite index!\nState: " + state + "\nReqSprite: " + reqSpriteName + "\nName: " + name);
	curSprite = reqSpriteName;
}