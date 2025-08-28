if(global.settings.playerSettings.moveSet == Moveset.PreETB) return;
instance_destroy();
other.setState("bomb");
if(instance_exists(o_MusicManager)) o_MusicManager.pauseMusic();
