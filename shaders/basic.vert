#version 330 core

// Vertex shader. What does that mean?
// A vertex shader is responsible for processing each vertex's attributes,
// such as position and color, and passing data to the fragment shader.

layout (location = 0) in vec3 aPosition; // Input vertex position. Meaning, this is the position of the vertex in 3D space.
layout (location = 1) in vec3 aColor; // Input vertex color. This is the color of the vertex.
// layout = Specifies the location of the input attribute in the shader.
// In this case, aPosition is at location 0 and aColor is at location 1.

// These matrices are created in C++ and uploaded to the GPU as uniforms.
// A uniform keeps the same value for every vertex processed by this draw call.
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform float time;

out vec3 vertexColor; // Output variable to pass the vertex color to the fragment shader.
out vec2 localCoord; // Local/object-space XY coordinate for fragment shader experiments.

void main()
{
    // Start with the local/object-space vertex from the VBO. The final 1.0 makes
    // it a homogeneous position, so matrix translations affect it. Reading the
    // multiplication from right to left follows the vertex through these spaces:
    // local -> world (model) -> view (view) -> clip (projection).
//    model = 
    float angle = time * 2.0;

    mat3 rotY = mat3(
        cos(angle * 2.0),  0.0, sin(angle * 2.0),
        0.0,         1.0, 0.0,
        -sin(angle * 2.0),  0.0, cos(angle * 2.0)
    );

//    mat3 rotX = mat3(
//    1.0,  0.0,      0.0,
//    0.0,  cos(angle * 2.0), -sin(angle * 2.0),
//    0.0, -sin(angle * 2.0), cos(angle * 2.0)
//    );

    mat3 rotZ = mat3(
        cos(angle * 2.0),  -sin(angle * 2.0),      0.0,
        sin(angle * 2.0),  cos(angle * 2.0), 0.0,
        0.0, 0.0, 1.0
        );
        
    vec3 spunPosition = rotZ * aPosition;   //rotX *
    float xOffset = sin(time) * 1.5;
    vec3 finalLocalPosition = spunPosition + vec3(xOffset, 0.0, 0.0);
    gl_Position = projection * view * model * vec4(finalLocalPosition, 1.0);
//    vec3 roundIt = vec3(aPosition.x, cos(aPosition.y * time), aPosition.z);
//    gl_Position = projection * view * model * vec4(roundIt, 1.0);
    // Which matrix would you change to move the object without moving the viewer?
    // Which one controls perspective and the visible clipping range?
    vertexColor = aColor;

    localCoord = aPosition.xy;

}