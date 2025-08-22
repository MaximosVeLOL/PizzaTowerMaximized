if(object_get_parent(other.object_index) == o_B_Parent && other.object_index != o_B_Metal) instance_destroy(other);
CreateEffect({sprite_index : sprite_effect_hurtspike, x : o_PlayerParent.x + (o_PlayerParent.xscale * 40)})
o_PlayerParent.movespeed = -4;
PlaySound(sfx_landmetal, false, false, true);