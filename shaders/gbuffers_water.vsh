#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

in vec2 mc_Entity;
in vec3 vaNormal;
in vec4 at_midBlock;
in vec2 mc_midTexCoord;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 normal;
out vec4 spriteBounds;
out vec2 texBlockFloor;
out vec3 block_pos_2;
flat out int mat;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal; // this gives us the normal in view space
	normal = mat3(gbufferModelViewInverse) * normal; // this converts the normal to world/player space
	mat = int(mc_Entity.x);
	
	vec2 spriteRadius = abs(texcoord - mc_midTexCoord.xy);
    vec2 bottomLeft = mc_midTexCoord.xy - spriteRadius;
    vec2 topRight = mc_midTexCoord.xy + spriteRadius;
    spriteBounds = vec4(bottomLeft, topRight);
    texBlockFloor = mc_midTexCoord;
    block_pos_2 = gl_Vertex.xyz;
    block_pos_2 = block_pos_2 + at_midBlock.xyz / 64.0;
}
