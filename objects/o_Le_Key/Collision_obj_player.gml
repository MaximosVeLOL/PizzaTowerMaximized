obj_player.inventory.key = true;
obj_player.setState("key");
audio_pause_all();
PlaySound(sfx_keyjingle);
instance_destroy();