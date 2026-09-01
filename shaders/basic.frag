#version 330 core

// Rasterization generates fragments for the covered samples of the cube.
// This shader uses interpolated surface data to produce a colour for each fragment.

in vec3 worldPosition;
in vec3 worldNormal;

// lightDirection points from the surface toward the directional light.
uniform vec3 lightDirection;
uniform vec3 lightColor;
uniform vec3 viewPosition;
uniform vec3 baseColor;
uniform float ambientStrength;
uniform float specularStrength;
uniform float shininess;

out vec4 FragColor; // The colour produced for this fragment.

void main()
{
//    float valueX = 0.5 + 0.5 * sin(localCoord.x * 75 + (time * 20));
//    float valueY = sin(localCoord.y * (time * 20)) - 0.5;
//    FragColor = vec4(vec3(valueX, valueY, 0.0), 1.0);
    // FragColor = vec4(vertexColor, 1.0);
    // FragColor = vec4(1.0, 0.0, 1.0, 1.0);
    
    // vec3 circle = vec3(sin(time * 4.0) * 0.3, -sin(time * 8.0) * 0.3, 0.3);
    // float d = length(localCoord - circle.xy) - circle.z;
    
    // float circleMask = 1.0 - smoothstep(-0.1, 0.01, d);
    // Interpolation can change a normal's length, so normalize per fragment.
    vec3 N = normalize(worldNormal);
    vec3 L = normalize(lightDirection);

    float diffuse = max(dot(N, L), 0.0);

    vec3 V = normalize(viewPosition - worldPosition);
    vec3 H = normalize(L + V);

    // Only a surface facing the light may receive a specular highlight.
    float specular = 0.0;
    if (diffuse > 0.0)
    {
        specular = pow(max(dot(N, H), 0.0), shininess);
    }

    vec3 ambientColor = ambientStrength * baseColor * lightColor;
    vec3 diffuseColor = diffuse * baseColor * lightColor;
    vec3 specularColor = specularStrength * specular * lightColor;

    vec3 color = ambientColor + diffuseColor + specularColor;
    FragColor = vec4(color, 1.0);

    // FragColor = vec4(vertexColor * circleMask, 1.0);
}