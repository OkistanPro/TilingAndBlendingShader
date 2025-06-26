#version 330 compatibility
#define PI 3.14159265359

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform sampler2D tex;
uniform vec3 cameraPosition;
uniform vec3 shadowLightPosition;

uniform mat4 gbufferModelView;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;
uniform float viewHeight;
uniform float viewWidth;


uniform float alphaTestRef = 0.1;

const vec3 sunlightColor = vec3(1.0);

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;
in vec4 spriteBounds;
in vec2 texBlockFloor;
in vec3 block_pos_2;
flat in int mat;

#include "textureSynthesis.glsl"
#include "textureSynthesisUVHints.glsl"
#include "spaceConversion.glsl"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

vec3 sine_values_show(in sampler2D sampler, in vec2 uv) {
	vec2 atlasSize = vec2(textureSize(sampler, 0));
    vec2 nbBlocks = atlasSize / 16.0;
    vec2 blockUV = uv * nbBlocks;
    vec2 blockUVFract = fract(blockUV);
	vec2 sinuv = sin(blockUVFract * TEXSYN_PI);
    vec2 sinuv2 = sinuv * sinuv;
    float value = sinuv2.x * sinuv2.y + 0.001;
    return vec3(value, value, value);
}

void main() {
	vec3 viewPos = (gbufferModelView * vec4(block_pos_2, 1.0)).xyz;
    vec3 playerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    ivec3 blockPosFrag = ivec3(floor(playerPos + cameraPosition + 0.001));
    
    //vec3 screenPos = vec3(gl_FragCoord.xy/ vec2(viewWidth, viewHeight), gl_FragCoord.z);
    //vec3 viewPos = ScreenToView(screenPos);
    //vec3 playerPos = ViewToPlayer(viewPos); 
    //ivec3 blockPosFrag = ivec3(floor(playerPos + cameraPosition + 0.001));
    
    vec3 lightVector = normalize(shadowLightPosition);
	vec3 worldLightVector = mat3(gbufferModelViewInverse) * lightVector;
	vec3 sunlight = sunlightColor * clamp(dot(worldLightVector, normal), 0.0, 1.0);

	switch (mat) {
		case 1:
		case 101:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
			break;
		case 2:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
			break;
		case 3:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 2, false, false) * glcolor;
			break;
		case 4:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 3, false, false) * glcolor;
			break;
		case 5:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 4, false, false) * glcolor;
			break;
		case 6:
		case 601:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 8, false, false) * glcolor;
			break;
		case 7:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
			break;
		case 8:
			color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 5, false, false) * glcolor;
			break;
		case 10:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			}
		case 1001:
			if (isLeft(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else if (isRight(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, true, false) * glcolor;
				break;
			}
		case 1002:
			if (isFront(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else if (isBack(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, true) * glcolor;
				break;
			}
		case 11:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 3, false, false) * glcolor;
				break;
			}
		case 1101:
			if (isLeft(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else if (isRight(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 3, true, false) * glcolor;
				break;
			}
		case 1102:
			if (isFront(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else if (isBack(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 3, false, true) * glcolor;
				break;
			}
		case 12:
		case 1203:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 1201:
			if (isLeft(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else if (isRight(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, true, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 1202:
			if (isFront(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else if (isBack(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, true) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 13:
			if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 14:
			if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				color.a = 1.0;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 15:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			}
		case 16:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 17:
			if (!(isTop(normal))) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 18:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 8, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 19:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 20:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 2, false, false) * glcolor;
				break;
			}
		case 21:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			}
		case 2101:
			if (isLeft(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isRight(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			}
		case 2102:
			if (isFront(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (isBack(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			}
		case 22:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isBottom(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 2201:
			if (isRight(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isLeft(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 2202:
			if (isBack(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isFront(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 2203:
			if (isLeft(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isRight(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 2204:
			if (isFront(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isBack(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 2205:
			if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 9, false, false) * glcolor;
				break;
			} else if (!(isTop(normal))){
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 23:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 24:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 8, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 8, false, false) * glcolor;
				break;
			} else {
				color = texture(gtexture, texcoord) * glcolor;
				break;
			}
		case 25:
			if (isTop(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else if (isBottom(normal)) {
				color = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 0, false, false) * glcolor;
				break;
			} else {
				color.rgb = TilingAndBlendingMethod(tex, texcoord, blockPosFrag, normal, 1, false, false).rgb * glcolor.rgb;
				color.a = 1.0;
				break;
			}
		default:
			color = texture(gtexture, texcoord) * glcolor;
	}
	
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}
}
