if(global.settings.gameplay.fpsSave == FPSSaveMode.OnlyTheNeccessary || global.settings.gameplay.fpsSave == FPSSaveMode.VisualRemover) {
	instance_destroy();
	//return; We stil have to create the variables because it still runs the step event for some reason???
}
canMove = true;
mass = 1/4;
velocity = new Vector();
owner = noone;
depth = -100;
