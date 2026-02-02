if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy();
	return;
}
movespeed = 3;
setSprite = function(target) {
    sprite_index = asset_get_index("spr_pizzakin_" + type + "_" + target);
	if(sprite_index == -1) LogError("We have no sprite! This isn't good...");
}
followQueue = ds_queue_create();
masterObject = o_Player;
depth = 0;

