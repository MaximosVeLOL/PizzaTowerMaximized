if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary || global.settings.gameplaySettings.fpsSave == FPSSaveMode.VisualRemover) {
	instance_destroy();
	return;
}
canMove = true;
velocity = [0, 0];
mass = 0.25;
parent = noone;
depth = -1;
