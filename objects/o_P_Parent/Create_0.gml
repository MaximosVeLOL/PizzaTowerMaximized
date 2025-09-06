if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary || global.settings.gameplaySettings.fpsSave == FPSSaveMode.VisualRemover) {
	instance_destroy();
	return;
}
canMove = true;
gravity = 0.25;
gravity_direction = 90;
owner = noone;
depth = -100;
