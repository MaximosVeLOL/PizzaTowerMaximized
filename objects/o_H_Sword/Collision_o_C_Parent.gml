if(object_get_parent(other.object_index) == o_B_Parent && object_get_parent(other.object_index) != o_B_Metal) instance_destroy(other);
CreateEffect({sprite_index : sprite_effect_hurtspike, x : parent.x + (parent.xscale * 40)})
parent.movespeed = -4;
PlaySound(sfx_landmetal, false, false, true);