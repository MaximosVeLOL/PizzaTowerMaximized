attribute vec2 in_Position;
attribute vec2 in_Texcoord;
attribute vec4 in_Colour;
varying vec2 v_Texcoord;
varying vec4 v_Colour;
void main() {
    v_Texcoord = in_Texcoord;
    v_Colour = in_Colour;
    gl_Position = vec4(in_Position.x, in_Position.y, 0.0, 1.0);
}