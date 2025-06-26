vec3 theGreenCOlor() {
	return vec3(0.3, 0.5, 0.3);
}


float sdDisc(vec2 p, float r) {
	return length(p) - r;
}

vec3 theStemColor() {
	return vec3(0.2, 0.1, 0.2);
}



mat2 rot(float a) {
	float c = cos(a);
	float s = sin(a);
	return mat2(c, -s, s, c);
}

void mainImage(out vec4 O, in vec2 I){
	vec2 uv = I / iResolution.xy;
	uv = uv * 2.0 - 1.0; 
	uv.x *= iResolution.x / iResolution.y; 
	uv *= 1.0; // Scale the UV coordinates

	float x = uv.x;
	float y = uv.y;

	float topF = - .9 * pow(x,2) + 0.45;
	float butF = -.67 * pow(x,3) + 0.18 * pow(x,2) + 0.43 * x - 0.10;

	float midF = (topF + butF) / 2.0;

	vec2 rotatedUV = rot(radians(-17.0)) * uv;
	float xRotated = rotatedUV.x;

	float splitXline = xRotated * 10.0;
	float sqment = mod(splitXline, 2)/5.0 * step(midF, y);

	sqment *= step(butF, y) * step(y, topF);

	rotatedUV = rot(radians(34.0)) * uv;
	xRotated = rotatedUV.x;

	float otherXline = xRotated * 10.0 + 1.0;
	float otherSqment = mod(otherXline, 2)/5.0 * step(y, midF);
	otherSqment *= step(butF, y) * step(y, topF);

	sqment += otherSqment;

	vec3 stemColor = theStemColor() * midF;
	topF = step(y, topF) * step(butF, y);
	vec3 currentCOlor = theGreenCOlor() * topF;

	O.rgb = vec3(sqment);
	O.rgb += currentCOlor;
}







