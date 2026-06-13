if(global.settings.player.moveSet == Moveset.PreETB) return;
instance_destroy();
other.setState(PlayerState.Bomb);
if(instance_exists(o_MusicManager)) o_MusicManager.pauseMusic();
