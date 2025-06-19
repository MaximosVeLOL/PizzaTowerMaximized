if(!visible) return;
LogError("Collision!");
instance_destroy();
o_GameManager.level.lap++;
PlaySound(sfx_bell);
PlaySound(sfx_bigcollect);