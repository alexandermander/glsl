

mat2 rot(float a) {
	float c = cos(a);
	float s = sin(a);
	return mat2(c, -s, s, c);
}

void mainImage(out vec4 O, in vec2 I) {
    vec2 uv = I / iResolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    vec3 color = vec3(0.2, 0.5, 1.0);


	vec2 rotatedUV = rot(radians( iTime * 7)) * uv;

	float yPos = -pow(rotatedUV.x, 2.0) / 0.9 - rotatedUV.y;
	// add sime noise to x rotation.x wut sin on the + fract
	yPos += sin(-rotatedUV.x * 3.0 + iTime) / 2 * 1.1;

	yPos = sin(yPos * 7.0 + iTime);
	color *= vec3(1.0) - abs(yPos) * 12; 

    O.rgb = color;
    O.a = 1.0;
}

