repeat(8) {
	instance_create_depth(x+16,y+50, 0, o_P_Breakable, {sprite_index : spr_breakabledoor_broken});
}
PlaySound(sfx_break, false, false, true)