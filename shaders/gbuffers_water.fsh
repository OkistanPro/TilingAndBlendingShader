#version 330 compatibility

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;
uniform sampler2D tex;
uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;
in vec4 spriteBounds;
in vec2 texBlockFloor;
in vec3 block_pos_2;
flat in int mat;

#include "textureSynthesis.glsl"
#include "spaceConversion.glsl"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	vec3 viewPos = (gbufferModelView * vec4(block_pos_2, 1.0)).xyz;
    vec3 playerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    ivec3 blockPosFrag = ivec3(floor(playerPos + cameraPosition + 0.001));

	color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}
}
