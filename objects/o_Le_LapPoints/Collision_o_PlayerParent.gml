if(!visible) return;
repeat(2) instance_create_depth(x,y,0,o_Le_BigPoints);
PlaySound(sfx_bell);
instance_destroy();