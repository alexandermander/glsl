
#define PI 3.14159265358979323846
#define NUMPERS_OF_EGGS 2


float rand(float n) {
    return fract(sin(n) * 43758.5453);
}

// 1D value noise (optional, smoother than rand)
float noise(float x) {
    float i = floor(x);
    float f = fract(x);
    return mix(rand(i), rand(i + 1.0), smoothstep(0.0, 1.0, f));
}

vec3 palette(float t) {
	vec3 a = vec3(0.9, 0.2, 0.2);
	vec3 b = vec3(0.6, 0.3, 0.4);
	vec3 c = vec3(0.5, 0.5, 0.0);
	vec3 d = vec3(0.6, 0.6, 0.3);

	return a + b * cos(6.28318 * (c * t + d));
}

// 2d rotatuin 
mat2 rot(float a) {
	float c = cos(a);
	float s = sin(a);
	return mat2(c, -s, s, c);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = uv * 2.0 - 1.0; // Normalize to [-1, 1]
	uv.x *= iResolution.x / iResolution.y; 

	float x = uv.x;
	float y = uv.y;

	vec3 resultColor = vec3(0.0);

	for (int i = 0; i < NUMPERS_OF_EGGS; i++) {

		float angle;
		if (i == 1) {
			angle = radians(45.0); // Fixed angle for the second layer
		} else {
			angle = radians(rand(float(i)) * 360.0); // Random angle for the first layer
		}

		float otherRanim = rand(float(i) + float(i)) * 0.5 + 0.5; 
		
		vec2 uvLayer = uv;
		if (i == 1) {
			uvLayer.y = -uvLayer.y;
		}
		
		vec2 rotatedUV = rot(angle) * uvLayer;
		float x = rotatedUV.x;
		float y = rotatedUV.y;

		// Wavy distorted line
		float sinFn = sin(x * 3.0 + iTime) / 2.0;
		float noiseVal = noise(x * otherRanim + iTime * 0.3) * otherRanim;
		float distorted = sinFn + noiseVal;

		// Blended with parabola shape
		float curve = x * x / 5.0 - 0.5;
		float mixFn = mix(distorted, curve, 0.8);
		
		float lineMask = step(y, mixFn);

		// Color layer with palette
		vec3 color = vec3(lineMask) * palette(-y * 0.5);

		resultColor += color * 0.5;
	}

	fragColor = vec4(resultColor, 1.0);
}

