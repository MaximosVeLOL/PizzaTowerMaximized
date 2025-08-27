if(global.settings.playerSettings.moveSet == Moveset.PreETB) return;
instance_destroy();
other.setState("bomb");
o_MusicManager.pauseMusic();
