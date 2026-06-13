if(!visible) return;
if(isPoints)
	repeat(2) instance_create_depth(x - 32,y - 32,0,o_Le_BigPoints);
else o_GameManager.level.lap++;
PlaySound(sfx_bell);
PlaySound(sfx_bigcollect);
if(o_GameManager.level.gameMode == Gamemode.TimeAttack)
	visible = false;
else instance_destroy();