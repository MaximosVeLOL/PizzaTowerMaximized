repeat(8) {
	CreateParticle(x+16,y+50, o_P_Breakable, {sprite_index : spr_breakabledoor_broken});
}
PlaySound(sfx_break, false, false, true)