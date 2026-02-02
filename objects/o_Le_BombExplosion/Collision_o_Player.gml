if(other.state != "bomb" && global.settings.playerSettings.moveSet != Moveset.PreETB) {
	other.setState("bomb");
	other.tempVar[0] = 3;
}