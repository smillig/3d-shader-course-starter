#version 460 core

// Fragment shader. What do we mean by fragment? A fragment is a pixel on the screen.
// The fragment shader is responsible for determining the color of each pixel on the screen.
// It takes the output from the vertex shader and uses it to determine the final color of each pixel.

in vec3 vertexColor; // "in" means this variable is coming from the vertex shader
in float colorPhase;
out vec4 FragColor; // "out" means this variable is going to the fragment shader

uniform float iTime;
uniform float colorBounceR;
uniform float colorBounceG;
uniform float colorBounceB;

void main()
{
    float adjustedTime = iTime + colorPhase * 6.283185; // Tao
    float pulse = 0.5 + 0.5 * sin(adjustedTime);
    FragColor = vec4(
        clamp(vertexColor.r * colorBounceR, 0.0, 1.0),
        clamp(vertexColor.g * colorBounceG, 0.0, 1.0),
        clamp(vertexColor.b * colorBounceB, 0.0, 1.0),
        1.0);
    //FragColor = vec4(0.5, 0.0, 1.0, 1.0);

}
