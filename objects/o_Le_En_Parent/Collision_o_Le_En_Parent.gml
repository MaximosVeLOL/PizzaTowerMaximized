CreateEffect({x : (other.x + (other.xscale * 40)), sprite_index : sprite_effect_punchdust});
setState("hit");
other.tempVar[2] = self;
setState("stunned");
setSprite("stomped");
PlaySound(sfx_bump);