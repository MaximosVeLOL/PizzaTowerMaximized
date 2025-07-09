triggerOnce = false;
target = noone;
playerCanTrigger = true;
enemiesCanTrigger = false;
speceficPlayerState = "";


onTrigger = function() {
	if(target == noone) {
		o_GUI_LevelEditor.addError("Target is not defined!", self);
		return;
	}
	target.action();
}