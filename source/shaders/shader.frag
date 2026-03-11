#version 450

layout(location = 0) out vec4 outColor;

layout(push_constant) uniform Push {
    uint enlapsedTime;
} push;

void main() {
    outColor = vec4(1,0.5,1,1);
}
