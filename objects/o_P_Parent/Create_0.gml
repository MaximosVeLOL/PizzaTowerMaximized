if(global.settings.gameplaySettings.fpsSave == FPSSaveMode.OnlyTheNeccessary || global.settings.gameplaySettings.fpsSave == FPSSaveMode.VisualRemover) {
	instance_destroy();
	return;
}
canMove = true;
mass = 1/4;
velocity = new Vector();
owner = noone;
depth = -100;
