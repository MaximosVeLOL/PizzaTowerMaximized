if(other.state != "bomb" && global.settings.player.moveSet != Moveset.PreETB) {
	other.setState("bomb");
	other.tempVar[0] = 3;
}