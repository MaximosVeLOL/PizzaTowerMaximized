function LoadTextureGroup(name) {
	texturegroup_load(name);
} 
function UnloadTextureGroup(name) {
	var tex = texturegroup_get_textures(name);
	for(var i = 0 ; i < array_length(tex);i++) {
		texture_flush(tex[i]);
	}
	texturegroup_unload(name);
}
function TextureGroupIsLoaded(name) {
}