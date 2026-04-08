#version 450

layout(location = 0) in vec2 inUv;
layout(location = 0) out vec4 outColor;

layout(binding = 1,set = 0) uniform sampler2D textures[];

layout(push_constant) uniform Push {
    uint enlapsedTime;
} push;

void main() {
    outColor = vec4(1,0.5,1,1);
    outColor = texture(textures[0],inUv);
}
