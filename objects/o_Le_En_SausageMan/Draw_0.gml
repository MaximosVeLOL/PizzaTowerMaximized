if(isCigarMan) {
	shader_set(Shader_PaletteSwap);
	texture_set_stage(shader_get_sampler_index(Shader_PaletteSwap, "samplePalette"), sprite_get_texture(sprite_enemy_sausageman_pal_base, 0) );
	shader_set_uniform_f(shader_get_uniform(Shader_PaletteSwap, "palIndex"), 0);
	shader_set_uniform_f(shader_get_uniform(Shader_PaletteSwap, "palSize"), sprite_get_height(sprite_enemy_sausageman_pal_base) );
	draw_self();
	shader_reset();
	
	return;
}


draw_self();



/*
if(isCigarMan) { //The og method was useless, using advanced systems meant for different objects with different palettes, not this...
	shader_set(Shader_PaletteSwap);
    var tex = sprite_get_texture(sprite_enemy_sausageman_palette, 0)
    var UVs = sprite_get_uvs(sprite_enemy_sausageman_palette, 0)
    texture_set_stage(global.Pal_Texture, tex)
    //texture_set_interpolation_ext(global.Pal_Texture, 1)
    var texel_x = texture_get_texel_width(tex)
    var texel_y = texture_get_texel_height(tex)
    var texel_hx = texel_x * 0.5
    var texel_hy = texel_y * 0.5
    shader_set_uniform_f(global.Pal_Texel_Size, texel_x, texel_y)
    shader_set_uniform_f(global.Pal_UVs, UVs[0] + texel_hx, UVs[1] + texel_hy, UVs[2] + texel_hx, UVs[3] + texel_hy)
    shader_set_uniform_f(global.Pal_Index, 1);
	draw_self();
	
	shader_reset();
}