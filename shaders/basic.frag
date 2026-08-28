#version 330 core

// Fragment shader. What do we mean by fragment? A fragment is a pixel on the screen.
// The fragment shader is responsible for determining the color of each pixel on the screen.
// It takes the output from the vertex shader and uses it to determine the final color of each pixel.

in vec3 vertexColor; // "in" means this variable is coming from the vertex shader
in vec2 localCoord; // Interpolated local/object-space XY coordinate.

uniform float time; // Seconds since GLFW started, uploaded by the CPU each frame.

out vec4 FragColor; // "out" means this variable is going to the fragment shader

void main()
{
    float valueX = 0.5 + 0.5 * sin(localCoord.x * 75 + (time * 20));
    float valueY = sin(localCoord.y * (time * 20)) - 0.5;
    FragColor = vec4(vec3(valueX, valueY, 0.0), 1.0);
    // FragColor = vec4(vertexColor, 1.0);
    // FragColor = vec4(1.0, 0.0, 1.0, 1.0);

}