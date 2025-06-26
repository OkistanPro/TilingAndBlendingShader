#define TEXSYN_PI 3.14159265359

vec2 spriteDimensions = vec2(spriteBounds.z - spriteBounds.x, spriteBounds.w - spriteBounds.y);
float spriteDimension;

bool isTop(in vec3 normals) {
	return normals.x <= 0.1 && normals.y >= 0.1 && normals.z <= 0.1;
}

bool isBottom(in vec3 normals) {
	return normals.x >= -0.1 && normals.y <= -0.1 && normals.z >= -0.1;
}

bool isLeft(in vec3 normals) {
	return normals.x >= 0.1 && normals.y <= 0.1 && normals.z <= 0.1;
}

bool isRight(in vec3 normals) {
	return normals.x <= -0.1 && normals.y >= -0.1 && normals.z >= -0.1;
}

bool isFront(in vec3 normals) {
	return normals.x <= 0.1 && normals.y <= 0.1 && normals.z >= 0.1;
}

bool isBack(in vec3 normals) {
	return normals.x >= -0.1 && normals.y >= -0.1 && normals.z <= -0.1;
}

ivec2 getUniqueID(in vec3 normals, in ivec3 blockPos, in bool flip_x, in bool flip_z) {
	ivec2 uniqueID;
	if (isFront(normals)) {
		if (flip_x) {
			uniqueID = ivec2(-blockPos.y, -(blockPos.x + blockPos.z));
		} else {
			uniqueID = ivec2(blockPos.x + blockPos.z, -blockPos.y);
		}
    }
    if (isBack(normals)) {
    	if (flip_x) {
    		uniqueID = ivec2(blockPos.y, -(blockPos.x + blockPos.z));
    	} else {
    		uniqueID = ivec2(-(blockPos.x + blockPos.z), -blockPos.y);
    	}
    }
    if (isTop(normals)) {
    	if (flip_x) {
    		uniqueID = ivec2(blockPos.z, -blockPos.x + blockPos.y);
    	} else {
    		uniqueID = ivec2(blockPos.x + blockPos.y, blockPos.z);
    	}
    }
    if (isBottom(normals)) {
    	if (flip_x) {
    		uniqueID = ivec2(-blockPos.z, -(blockPos.x + blockPos.y));
    	} else if (flip_z) {
    		uniqueID = ivec2(-(blockPos.x + blockPos.y), blockPos.z);
    	} else {
    		uniqueID = ivec2((blockPos.x + blockPos.y), -blockPos.z);
    	}
    }
    if (isLeft(normals)) {
    	if (flip_z) {
    		uniqueID = ivec2(-blockPos.y, blockPos.x + blockPos.z);
    	} else {
    		uniqueID = ivec2(-(blockPos.x + blockPos.z), -blockPos.y);
    	}
    }
    if (isRight(normals)) {
    	if (flip_z) {
    		uniqueID = ivec2(blockPos.y, blockPos.x + blockPos.z);
    	} else {
    		uniqueID = ivec2(blockPos.x + blockPos.z, -blockPos.y);
    	}
    }
    return uniqueID;
}

void SquareGrid(vec2 uv, out vec2 weights, out ivec2 vertex1, out ivec2 vertex2)
{
    // New code for pixelated transitions
    // Scale UV to a 16x16 grid
    // Aligns the UV coordinates to a 16x16 grid
    // En multipliant les coordonnées UV par 16 puis en prenant la valeur floor,
    // nous alignons effectivement les coordonnées UV sur le plus proche intervalle de 1/16ème.
    uv = floor(uv * spriteDimension) / spriteDimension;

    // Calculate sine values
    vec2 sinuv = sin(uv * TEXSYN_PI);
    vec2 sinuv2 = sinuv * sinuv;

    vertex1 = ivec2(0, 0);

    // Calculate weights based on the sine values
    weights.x = sinuv2.x * sinuv2.y + 0.001;

    // Adjust UV for the second vertex
    vec2 uv2 = uv - vec2(0.5, 0.5);
    vertex2 = ivec2(floor(uv2)) * ivec2(2, 2) + ivec2(1, 1);
    sinuv = sin(uv2 * TEXSYN_PI);
    sinuv2 = sinuv * sinuv;

    weights.y = sinuv2.x * sinuv2.y + 0.001;
}


// see https://www.shadertoy.com/view/XlGcRh
uvec2 pcg2d(uvec2 v)
{
    v = v * 1664525u + 1013904223u;

    v.x += v.y * 1664525u;
    v.y += v.x * 1664525u;

    v = v ^ (v>>16u);

    v.x += v.y * 1664525u;
    v.y += v.x * 1664525u;

    v = v ^ (v>>16u);

    return v;
}

// see https://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl
float floatConstruct(uint m) {
    const uint ieeeMantissa = 0x007FFFFFu; // binary32 mantissa bitmask
    const uint ieeeOne      = 0x3F800000u; // 1.0 in IEEE binary32

    m &= ieeeMantissa;                     // Keep only mantissa bits (fractional part)
    m |= ieeeOne;                          // Add fractional part to 1.0

    float  f = uintBitsToFloat(m);         // Range [1:2]
    return f - 1.0;                        // Range [0:1]
}

vec2 hash22u(uvec2 p)
{
    uvec2 hash = pcg2d(p);
    return vec2(floatConstruct(hash.x), floatConstruct(hash.y));
}

vec2 offsetToXxX(in vec2 offset, in vec2 uv, float offsetAdjust, float heightAdjust)
{
    offset = floor(offset * offsetAdjust) / offsetAdjust ; // Align to sub textures in the atlas

    if (heightAdjust != 0.0) {
    	// Align the offset to the brick grid
    	offset.y = floor(offset.y / heightAdjust) * heightAdjust; // Align to brick height grid
    }
    
    vec2 uvCeil = ceil(uv);

    uv += offset;
    uv.x = float(uv.x < uvCeil.x) * uv.x + float(uv.x >= uvCeil.x) * (uv.x - 1.0); 
    uv.y = float(uv.y < uvCeil.y) * uv.y + float(uv.y >= uvCeil.y) * (uv.y - 1.0);

    return uv;
}

vec2 rotate(vec2 v, int rotateTimes)
{
    float s = sin(rotateTimes * (TEXSYN_PI / 2.0));
    float c = cos(rotateTimes * (TEXSYN_PI / 2.0));
    return vec2(c * v.x - s * v.y, s * v.x + c * v.y);
}

vec2 RotateUV(in vec2 uv, in vec2 random)
{
    int randomRotate = int(random.x * 4.0); // Random rotation between 0 and 3
    uv = rotate(uv, randomRotate);
    
    return fract(uv);
}
#if ANISOTROPIC_FILTER == 0

vec4 TilingAndBlending(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, float offsetAdjust, float heightAdjust, in vec3 normals, in bool borderless, in bool flip_x, in bool flip_z)
{
    float notCenterBlock = float(mat == 101) + float(mat == 601) + float(mat == 1203) + float(mat == 20);
    // Dynamically determine the atlas size
    vec2 atlasSize = vec2(textureSize(sampler, 0));
    if (notCenterBlock > 0.) {
    	spriteDimension = 16.0;
    } else {
    	spriteDimension = ceil(spriteDimensions.x *atlasSize.x);
    }
   
    vec2 nbBlocks = atlasSize / spriteDimension;
    ivec2 tile1;
    ivec2 tile2;
    vec2 weights;
    
    vec2 dfdx_uv = dFdx(uv);
    vec2 dfdy_uv = dFdy(uv);

    vec2 blockUV = uv * nbBlocks;
    vec2 blockUV_2 = texBlockFloor * nbBlocks;
    
    vec2 blockUVFloor = floor(blockUV_2);
    vec2 blockUVFract = blockUV - blockUVFloor;
    
    
    if (borderless) {
		float isBorder = float(blockUVFract.x < 1./spriteDimension) + float(blockUVFract.x > 1. - (1./spriteDimension)) + float(blockUVFract.y < 1./spriteDimension) + float(blockUVFract.y > 1 - (1. - spriteDimension));
		if (isBorder > 0.0) {
			return textureGrad(tex, uv, dfdx_uv, dfdy_uv);
		}
    }
    
    if (blockUVFract.x >= 1.|| blockUVFract.y >= 1.) {
    	return vec4(1.0, 1.0, 0.0, 1.0);
    }

    SquareGrid(blockUVFract, weights, tile1, tile2); // Weight is normalized for 16x16 pixels per cube
    float W = length(weights);
    
    ivec2 uniqueID = getUniqueID(normals, blockPos, flip_x, flip_z);

    tile1 = uniqueID * ivec2(2, 2);
    tile2 = uniqueID * ivec2(2, 2) + tile2;

    vec2 offset1 = hash22u(uvec2(tile1));
    vec2 offset2 = hash22u(uvec2(tile2));

    vec2 uvContent1 = offsetToXxX(offset1, blockUVFract, offsetAdjust, heightAdjust);
    vec2 uvContent2 = offsetToXxX(offset2, blockUVFract, offsetAdjust, heightAdjust);

    uvContent1 = (uvContent1 + blockUVFloor) / nbBlocks;
    uvContent2 = (uvContent2 + blockUVFloor) / nbBlocks;

    vec4 mean = textureLod(sampler, uv, 4);

    vec4 content1 = textureGrad(tex, uvContent1, dfdx_uv, dfdy_uv) - mean;
    vec4 content2 = textureGrad(tex, uvContent2, dfdx_uv, dfdy_uv) - mean;
    vec4 value = content1 * weights.x + content2 * weights.y;
    return value / W + mean;
}

vec4 TilingAndBlendingRotate(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, in bool borderless)
{
    float notCenterBlock = float(mat == 101) + float(mat == 601) + float(mat == 1203) + float(mat == 20);
    // Dynamically determine the atlas size
    vec2 atlasSize = vec2(textureSize(sampler, 0));
    if (notCenterBlock > 0.) {
    	spriteDimension = 16.0;
    } else {
    	spriteDimension = ceil(spriteDimensions.x *atlasSize.x);
    }
    vec2 nbBlocks = atlasSize / spriteDimension;
    ivec2 tile1;
    ivec2 tile2;
    vec2 weights;
    
    vec2 dfdx_uv = dFdx(uv);
    vec2 dfdy_uv = dFdy(uv);

    vec2 blockUV = uv * nbBlocks;
    vec2 blockUVFract = fract(blockUV);
    vec2 blockUVFloor = floor(blockUV);
    
    if (borderless) {
    	float isBorder = float(blockUVFract.x < 1./spriteDimension) + float(blockUVFract.x > 1. - (1./spriteDimension)) + float(blockUVFract.y < 1./spriteDimension) + float(blockUVFract.y > 1 - (1. / spriteDimension));
		if (isBorder > 0.0) {
			return texture(sampler, uv);
			//return vec4(1.0, 1.0, 0.0, 1.0);
		}
    }

    SquareGrid(blockUVFract, weights, tile1, tile2); // Weight is normalized for 16x16 pixels per cube
    float W = length(weights);

    ivec2 uniqueID = ivec2(blockPos.x + blockPos.y, blockPos.z);
    tile1 = uniqueID * ivec2(2, 2);
    tile2 = uniqueID * ivec2(2, 2) + tile2;

    vec2 uvContent1 = RotateUV(blockUVFract, hash22u(uvec2(tile1)));
    vec2 uvContent2 = RotateUV(blockUVFract, hash22u(uvec2(tile2)));

    uvContent1 = (uvContent1 + blockUVFloor) / nbBlocks;
    uvContent2 = (uvContent2 + blockUVFloor) / nbBlocks;

    vec4 mean = textureLod(sampler, uv, 4);
    vec4 content1 = textureGrad(tex, uvContent1, dfdx_uv, dfdy_uv) - mean;
    vec4 content2 = textureGrad(tex, uvContent2, dfdx_uv, dfdy_uv) - mean;

    vec4 value = content1 * weights.x + content2 * weights.y;
    return value / W + mean;
}

#else
vec4 TilingAndBlendingAF(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, float offsetAdjust, float heightAdjust, in vec3 normals, in bool borderless, in bool flip_x, in bool flip_z)
{
    // Dynamically determine the atlas size
    vec2 atlasSize = vec2(textureSize(sampler, 0));
    spriteDimension = ceil(spriteDimensions.x *atlasSize.x);
    vec2 nbBlocks = atlasSize / spriteDimension;
    ivec2 tile1;
    ivec2 tile2;
    vec2 weights;
    
    vec2 dfdx_uv = dFdx(uv);
    vec2 dfdy_uv = dFdy(uv);

    vec2 blockUV = uv * nbBlocks;
    vec2 blockUVFloor = floor(blockUV);
    vec2 blockUVFract = clamp(blockUV, blockUVFloor, blockUVFloor + 1.0) - blockUVFloor;
    //vec2 blockUVFract = fract(blockUV);
    
    if (borderless) {
    	float isBorder = float(blockUVFract.x < 1./spriteDimension) + float(blockUVFract.x > 1. - (1./spriteDimension)) + float(blockUVFract.y < 1./spriteDimension) + float(blockUVFract.y > 1 - (1. - spriteDimension));
		if (isBorder > 0.0) {
			return textureGrad(tex, uv, dfdx_uv, dfdy_uv);
		}
    }

    SquareGrid(blockUVFract, weights, tile1, tile2); // Weight is normalized for 16x16 pixels per cube
    float W = length(weights);

    ivec2 uniqueID = getUniqueID(normals, blockPos, flip_x, flip_z);
    tile1 = uniqueID * ivec2(2, 2);
    tile2 = uniqueID * ivec2(2, 2) + tile2;

    vec2 offset1 = hash22u(uvec2(tile1))*;
    vec2 offset2 = hash22u(uvec2(tile2))*;

    vec2 uvContent1 = offsetToXxX(offset1, blockUVFract, offsetAdjust, heightAdjust);
    vec2 uvContent2 = offsetToXxX(offset2, blockUVFract, offsetAdjust, heightAdjust);

    uvContent1 = (uvContent1 + blockUVFloor) / nbBlocks;
    uvContent2 = (uvContent2 + blockUVFloor) / nbBlocks;

    vec4 mean = textureLod(sampler, uv, 4);

    vec4 content1 = textureAF_d(tex, uvContent1, dfdx_uv, dfdy_uv) - mean;
    vec4 content2 = textureAF_d(tex, uvContent2, dfdx_uv, dfdy_uv) - mean;

    vec4 value = content1 * weights.x + content2 * weights.y;
    return value / W + mean;
}
vec4 TilingAndBlendingRotateAF(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, in bool borderless)
{
    // Dynamically determine the atlas size
    vec2 atlasSize = vec2(textureSize(sampler, 0));
    spriteDimension = ceil(spriteDimensions.x *atlasSize.x);
    vec2 nbBlocks = atlasSize / spriteDimension;
    ivec2 tile1;
    ivec2 tile2;
    vec2 weights;
    
    vec2 dfdx_uv = dFdx(uv);
    vec2 dfdy_uv = dFdy(uv);

    vec2 blockUV = uv * nbBlocks;
    vec2 blockUVFract = fract(blockUV);
    vec2 blockUVFloor = floor(blockUV);
    
    if (borderless) {
    	float isBorder = float(blockUVFract.x < 1./spriteDimension) + float(blockUVFract.x > 1. - (1./spriteDimension)) + float(blockUVFract.y < 1./spriteDimension) + float(blockUVFract.y > 1 - (1. - spriteDimension));
    
		if (isBorder > 0.0) {
			return textureGrad(tex, uv, dfdx_uv, dfdy_uv);
		}
    }

    SquareGrid(blockUVFract, weights, tile1, tile2); // Weight is normalized for 16x16 pixels per cube
    float W = length(weights);

    ivec2 uniqueID = ivec2(blockPos.x + blockPos.y, blockPos.z);
    tile1 = uniqueID * ivec2(2, 2);
    tile2 = uniqueID * ivec2(2, 2) + tile2;

    vec2 uvContent1 = RotateUV(blockUVFract, hash22u(uvec2(tile1)));
    vec2 uvContent2 = RotateUV(blockUVFract, hash22u(uvec2(tile2)));

    uvContent1 = (uvContent1 + blockUVFloor) / nbBlocks;
    uvContent2 = (uvContent2 + blockUVFloor) / nbBlocks;

    vec4 mean = textureLod(sampler, uv, 4);
    
    vec4 content1 = textureAF_d(tex, uvContent1, dfdx_uv, dfdy_uv) - mean;
    vec4 content2 = textureAF_d(tex, uvContent2, dfdx_uv, dfdy_uv) - mean;

    vec4 value = content1 * weights.x + content2 * weights.y;
    return value / W + mean;
}


#endif
vec4 TilingAndBlendingMethod(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, in vec3 normals, in int method, in bool flip_x, in bool flip_z) {
	if (method == 0) {
		return TilingAndBlending(sampler, uv, blockPos, 16.0, 0.0, normals, false, flip_x, flip_z);
	} else if (method == 1) {
		return TilingAndBlending(sampler, uv, blockPos, 16.0, 1.0, normals, false, flip_x, flip_z);
	} else if (method == 2) {
		return TilingAndBlending(sampler, uv, blockPos, 2.0, 0.5, normals, false, flip_x, flip_z);
	} else if (method == 3) {
		return TilingAndBlending(sampler, uv, blockPos, 2.0, 0.25, normals, false, flip_x, flip_z);
	} else if (method == 4) {
		return TilingAndBlending(sampler, uv, blockPos, 16.0, 0.0, normals, true, flip_x, flip_z);
	} else if (method == 5) {
		return TilingAndBlending(sampler, uv, blockPos, 16.0, 1.0, normals, true, flip_x, flip_z);
	} else if (method == 6) {
		return TilingAndBlending(sampler, uv, blockPos, 16.0, 0.5, normals, true, flip_x, flip_z);
	} else if (method == 7) {
		return TilingAndBlending(sampler, uv, blockPos, 2.0, 0.25, normals, true, flip_x, flip_z);
	} else if (method == 8) {
		return TilingAndBlendingRotate(sampler, uv, blockPos, false);
	} else if (method == 9) {
		return TilingAndBlendingRotate(sampler, uv, blockPos, true);
	} else {
		return vec4(1.0, 0.0, 0.0, 1.0);
	}
}

vec4 TilingAndBlendingAFMethod(in sampler2D sampler, in vec2 uv, in ivec3 blockPos, in vec3 normals, in int method, in bool flip_x, in bool flip_z) {
	if (method == 0) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 16.0, 0.0, normals, false, flip_x, flip_z);
	} else if (method == 1) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 16.0, 1.0, normals, false, flip_x, flip_z);
	} else if (method == 2) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 2.0, 0.5, normals, false, flip_x, flip_z);
	} else if (method == 3) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 2.0, 0.25, normals, false, flip_x, flip_z);
	} else if (method == 4) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 16.0, 0.0, normals, true, flip_x, flip_z);
	} else if (method == 5) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 16.0, 1.0, normals, true, flip_x, flip_z);
	} else if (method == 6) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 2.0, 0.5, normals, true, flip_x, flip_z);
	} else if (method == 7) {
		return TilingAndBlendingAF(sampler, uv, blockPos, 2.0, 0.25, normals, true, flip_x, flip_z);
	} else if (method == 8) {
		return TilingAndBlendingRotateAF(sampler, uv, blockPos, false);
	} else if (method == 9) {
		return TilingAndBlendingRotateAF(sampler, uv, blockPos, true);
	} else {
		return vec4(1.0, 0.0, 0.0, 1.0);
	}
}
