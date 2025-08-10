o_Camera.shakeMag = 10;
PlaySound(sfx_breakmetal, false, false, true);
var spr = sprite_index == spr_metalblock ? spr_metalblock_broken : spr_breakable_broken;
CreateParticle(x - 16, y - 16, 0, o_P_Breakable, {sprite_index : spr});
CreateParticle(x + 16, y - 16, 0, o_P_Breakable, {sprite_index : spr});
CreateParticle(x - 16, y + 16, 0, o_P_Breakable, {sprite_index : spr});
CreateParticle(x + 16, y + 16, 0, o_P_Breakable, {sprite_index : spr});