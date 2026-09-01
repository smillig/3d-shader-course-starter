#version 330 core

// The vertex shader processes each vertex's local-space attributes.
layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;

// These matrices are created in C++ and uploaded to the GPU as uniforms.
// A uniform keeps the same value for every vertex processed by this draw call.
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat3 normalMatrix;

uniform float time;

// out vec3 vertexColor; // Output variable to pass the vertex color to the fragment shader.
// out vec2 localCoord; // Local/object-space XY coordinate for fragment shader experiments.

// void main()
// {
//     // Start with the local/object-space vertex from the VBO. The final 1.0 makes
//     // it a homogeneous position, so matrix translations affect it. Reading the
//     // multiplication from right to left follows the vertex through these spaces:
//     // local -> world (model) -> view (view) -> clip (projection).
// //    model = 
//     float angle = time * 2.0;

//     mat3 rotY = mat3(
//         cos(angle * 2.0),  0.0, sin(angle * 2.0),
//         0.0,         1.0, 0.0,
//         -sin(angle * 2.0),  0.0, cos(angle * 2.0)
//     );

// //    mat3 rotX = mat3(
// //    1.0,  0.0,      0.0,
// //    0.0,  cos(angle * 2.0), -sin(angle * 2.0),
// //    0.0, -sin(angle * 2.0), cos(angle * 2.0)
// //    );

//     mat3 rotZ = mat3(
//         cos(angle * 2.0),  -sin(angle * 2.0),      0.0,
//         sin(angle * 2.0),  cos(angle * 2.0), 0.0,
//         0.0, 0.0, 1.0
//         );
        
//     vec3 spunPosition = rotZ * aPosition;   //rotX *
//     float xOffset = sin(time) * 1.5;
//     vec3 finalLocalPosition = spunPosition + vec3(xOffset, 0.0, 0.0);
//     gl_Position = projection * view * model * vec4(finalLocalPosition, 1.0);
// //    vec3 roundIt = vec3(aPosition.x, cos(aPosition.y * time), aPosition.z);
// //    gl_Position = projection * view * model * vec4(roundIt, 1.0);
//     // Which matrix would you change to move the object without moving the viewer?
//     // Which one controls perspective and the visible clipping range?
//     vertexColor = aColor;

//     localCoord = aPosition.xy;

// }
out vec3 worldPosition;
out vec3 worldNormal;

void main()
{
    // Position path: local -> world -> view -> clip.
    vec4 world = model * vec4(aPosition, 1.0);
    worldPosition = world.xyz;
    gl_Position = projection * view * world;

    // Normal path: local direction -> world direction. Translation must not
    // affect a direction, so normals use a mat3 normal matrix rather than model.
    worldNormal = normalMatrix * aNormal;
}
