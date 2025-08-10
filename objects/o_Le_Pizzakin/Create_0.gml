if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary) {
	instance_destroy();
	return;
}
followQueue = ds_queue_create();
velocity = [0,0];
movespeed = 3;
panic = false;
type = "null";
setSprite = function(target) {
    sprite_index = asset_get_index("spr_pizzakin_" + type + "_" + target);
	if(sprite_index == -1) LogError("We have no sprite! This isn't good...");
}
LAG_STEPS = 10;
depth = -999;

