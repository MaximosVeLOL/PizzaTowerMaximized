//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
	vec4 sampled = texture2D(gm_BaseTexture, v_vTexcoord);
	if(sampled.a == 1.0) {
		if(sampled.r == (128.0/255.0)) {
			sampled.r = (97.0/255.0);
			sampled.g = (48.0/255.0);
		}
		else if(sampled.r == (208.0/255.0)) {
			sampled.r = (146.0/255.0);
			sampled.g = (86.0/255.0);
		}
		else if(sampled.r == (248.0/255.0)) {
			sampled.r = (206.0/255.0);
			sampled.g = (82.0/255.0);
		}
	}
	gl_FragColor = sampled * v_vColour;
}