#version 450

layout(push_constant) uniform Push {
    uint enlapsedTime;
} pushConstants;

layout(location = 0) in vec3 vertexPosition;

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 projection;
} uniformBufferObjects;

void main() {
    gl_Position = uniformBufferObjects.projection * uniformBufferObjects.view * uniformBufferObjects.model * vec4(vertexPosition,1);
}
