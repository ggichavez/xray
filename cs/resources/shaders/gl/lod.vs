#include "common.h"

out gl_PerVertex { vec4 gl_Position; };

layout(location = 0) in vec3 pos0;
layout(location = 1) in vec3 pos1;
layout(location = 2) in vec3 n0;
layout(location = 3) in vec3 n1;
layout(location = 4) in vec2 tex0;
layout(location = 5) in vec2 tex1;
layout(location = 6) in vec4 rgbh0;		// rgb.h
layout(location = 7) in vec4 rgbh1;		// rgb.h
layout(location = 8) in vec4 sun_af;	// x=sun_0, y=sun_1, z=alpha, w=factor

layout(location = 0) out vec3	position;
layout(location = 1) out vec2 	tc0;	// base0
layout(location = 2) out vec2 	tc1;	// base1
layout(location = 3) out vec4 	af;		// alpha&factor

#define L_SCALE (2.0f*1.55f)
void 	main	()
{
	// lerp pos
	float 	factor 	= sun_af.w	;
	float4 	pos 	= float4	(lerp(pos0,pos1,factor),1);

	float 	h 	= lerp		(rgbh0.w,rgbh1.w,factor)		*L_SCALE;

	gl_Position	= mul		(m_VP, 	pos);				// xform, input in world coords
	position	= mul		(m_V,	pos);

	// replicate TCs
	tc0			= tex0;						
	tc1			= tex1;						

	// calc normal & lighting
	af			= float4	(h,h,sun_af.z,factor);
}
