movespeed = 1.5;

state = EnemyState.Idle;
mass = 0.5;
curMass = mass;
//Since tempVar[2] is the point count, we dont need the third temp var
tempVar = [0, 0];
pointCount = 5;

animVar = false;
stunnable = true;
plr = noone;
ogDepth = depth;
velocity = new Vector();
//TODO - Remove this because ETB enemies can't die
//die = function(dead_sprite, canMove = false) {
//	instance_destroy();
//	if(canMove) instance_create_depth(x,y,0,o_P_Effect, {sprite_index : dead_sprite});
//	else instance_create_depth(x,y,0,o_P_DeadEnemy, {sprite_index : dead_sprite});
//	PlaySound(sfx_enemykill);
//}
dropPoints = false;
setState = function(newState, overTemp = true) {
    if(typeof(newState) == "string") throw("(setState) Expected enum, got string (" + newState + ")");
	state = newState;
	image_index = 0;
	image_speed = 1;
	if(overTemp) tempVar = [0, 0];
	animVar = false;
	curMass = mass;
}
//name = "";
//curSprite = "";

var obName = object_get_name(object_index);
var pos = 9;
if(object_index == o_Le_En_Cheeseslime) {
	sprite = {
		idle : spr_enemy_cheeseslime_idle,
		turn : spr_enemy_cheeseslime_bumped,
		
	};
	return;
}
var name = string_lower(string_copy(obName, pos, (string_length(obName) + 1) - pos));
sprite = {
    idle : -1,
	turn : -1,
	walk : -1,
	hit : -1,
	hitceiling : -1,
	hitwall : -1,
	land : -1,
	recover : -1,
	stomped : -1,
	turn : -1,
	fall : -1,
	stunfall : -1,
	stunfalltrans : -1,
	stunland : -1,
	stunned : -1,
	flying : -1,
};
var names = variable_struct_get_names(sprite);
for(var i = 0 ; i < array_length(names);i++) {
    var sp = asset_get_index("sprite_enemy_" + name + "_" + names[i]);
    if(sp == -1) throw("(Initialize sprites) name (" + names[i] + ") cannot be found at index (" + string(i) + ")!" ); 
        MarkDebugCode("(Initialize) Remove debug check!");
    variable_struct_set(sprite, names[i], sp);
}
mask_index = spr_player_mask;
/*setSprite = function(reqSpriteName) {
	//if(!is_string(reqSpriteName)) LogError("Invalid type!", true);
	sprite_index = asset_get_index("sprite_enemy_" + name + "_" + reqSpriteName);
	mask_index = spr_player_mask;
	//image_index = 0;
	//image_speed = 1;
	if(sprite_index == -1) LogError("Invalid sprite index!\nState: " + state + "\nReqSprite: " + reqSpriteName + "\nName: " + name);
	curSprite = reqSpriteName;
}*.