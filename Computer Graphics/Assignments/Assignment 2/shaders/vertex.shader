attribute vec4 aVertexPosition;
attribute vec4 aVertexColor;
uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
varying lowp vec4 vColor;
uniform bool uWireframe;
void main(void) {
    gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
    if (uWireframe) {
        vColor = vec4(1,1,1,1);
    } else {
        vColor = aVertexColor;
    }
}