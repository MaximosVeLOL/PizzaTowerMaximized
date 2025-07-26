event_inherited();
global.bestInputs = [];
#macro MACHINE_SCORE_MIN -50
#macro MACHINE_VEL_X_MIN 3
#macro MACHINE_VEL_Y_MIN 2
availableInputs = [/*global.settings.keyBinds.p1.up, global.settings.keyBinds.p1.down,*/ global.settings.keyBinds.p1.left, global.settings.keyBinds.p1.right, global.settings.keyBinds.p1.dash, global.settings.keyBinds.p1.jump];
inputs = [];
time = 0;
selfScore = 0;
restart = function(failed) {
	randomize();
	inputs = [];
	time = 0;
	selfScore = 0;
	if(failed && false) game_restart();
	else {
		x = xstart;
		y = ystart;
		setState("normal");
	}
}
inputToString = function(index) {
	switch(index) {
		case global.settings.keyBinds.p1.up:
			return "Up";
		case global.settings.keyBinds.p1.down:
			return "Down";
		case global.settings.keyBinds.p1.left:
			return "Left";
		case global.settings.keyBinds.p1.right:
			return "Right";
		case global.settings.keyBinds.p1.dash:
			return "Dash";
		case global.settings.keyBinds.p1.jump:
			return "Jump";
		
	}
	//return [/*"Up", "Down",*/ "Left", "Right", "Dash", "Jump"][index];
}