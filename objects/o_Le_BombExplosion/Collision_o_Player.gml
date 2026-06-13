if(other.state != PlayerState.Bomb && global.settings.player.moveSet != Moveset.PreETB) {
	other.setState(PlayerState.Bomb);
	other.tempVar[0] = 3;
}