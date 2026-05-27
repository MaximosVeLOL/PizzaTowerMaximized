if(global.settings.gameplay.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy();
	return;
}
movespeed = 3;
setSprite = function(target) {
    sprite_index = asset_get_index("spr_pizzakin_" + type + "_" + target);
	if(sprite_index == -1) LogError("We have no sprite! This isn't good.settings..");
}
follow = [];
delay = 0;
masterObject = o_Player;
depth = 0;

