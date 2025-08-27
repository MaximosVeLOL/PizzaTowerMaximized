//This uses stolen code from a decompile, thanks thecore0!

varying vec2 v_texcoord;

void main()
{ 
    vec4 colour = texture2D(gm_BaseTexture, v_texcoord);
    gl_FragColor.rgb = vec3(1,0.9,0.9);
    gl_FragColor.a = colour.a;
}