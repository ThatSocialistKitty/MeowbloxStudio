#version 450

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec2 inUv;
layout(location = 0) out vec2 outUv;

layout(push_constant) uniform Push {
    uint enlapsedTime;
} pushConstants;

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 projection;
} uniformBufferObjects;

void main() {
    gl_Position = uniformBufferObjects.projection * uniformBufferObjects.view * uniformBufferObjects.model * vec4(inPosition,1);
    outUv = inUv;
}
