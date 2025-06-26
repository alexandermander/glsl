

vec3 palette(float t) {
	vec3 a = vec3(3.10, .4, 0.7);
	vec3 b = vec3(.8, 0.2, 1.8);
	vec3 c = vec3(.8, 0.5, 0.0);
	vec3 d = vec3(.9, 0.6, 0.3);
	return a + b * cos(6.28318 * (c * t + d));
}


void mainImage(out vec4 O, in vec2 I){
	vec2 uv = I / iResolution.xy;
	uv = uv * 2.0 - 1.0; // Normalize to [-1, 1]
	uv.x *= iResolution.x / iResolution.y; // Maintain aspect ratio

	uv *= 2.0; // Scale the UV coordinates

	float t = 2.0 * 0.5;
	float r = length(uv) + iTime * 0.1;

	float color = 0.6 + 0.4 * sin(r * 4.0 * 7.0 + t);
	float f = -uv.x * uv.x;

	float thismix = mix(f, color, 0.5);
	float oustSit = step(thismix, -uv.y);

	float newRess = thismix * oustSit * 100.0;
	vec3 col = palette(step(thismix, 0.0));
	col = col * step(newRess, 0.0);

	O = vec4(col, 1.0);
}



