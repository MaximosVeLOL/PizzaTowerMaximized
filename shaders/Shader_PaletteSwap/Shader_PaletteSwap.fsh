varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D samplePalette;

uniform float palIndex;
uniform float palSize;

void main() {
	vec4 index = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 sampledColor = texture2D(samplePalette, vec2(index.r, palIndex / palSize ));
	gl_FragColor = vec4(sampledColor.rgb, index.a);
}