if(!visible) return;
instance_destroy();
o_GameManager.level.lap++;
PlaySound(sfx_bell);
PlaySound(sfx_bigcollect);