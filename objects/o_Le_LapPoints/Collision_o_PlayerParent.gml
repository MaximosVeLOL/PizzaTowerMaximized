if(!visible) return;
repeat(2) instance_create_depth(x - 32,y - 32,0,o_Le_BigPoints);
PlaySound(sfx_bell);
instance_destroy();