//This is NOT stolen from thecore0.

	varying vec2 v_vTexcoord;
    varying vec4 v_vColour;
    uniform float time;
    #define A 0.01  //(A)mplitude
    #define W 16.0  //(W)avelength
    #define F 10.0  //(F)requency
    void main() {
        float D = A * sin(W * v_vTexcoord.y + F * time);  //(D)isplacement
        vec2 T = v_vTexcoord + vec2(D, 0.0); //new (T)exture coordinates
        gl_FragColor = v_vColour * texture2D( gm_BaseTexture, T );
    }