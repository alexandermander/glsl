

mat2 rot(float a) {
	float c = cos(a);
	float s = sin(a);
	return mat2(c, -s, s, c);
}



void mainImage(out vec4 O, in vec2 I){
    vec2 uv = (2.0 * I - iResolution.xy) / iResolution.y;

	float f;

	float tsiwst = 60.;

	vec2 currnttUv = uv;
	for (int i = 0; i < 6; i++){
		currnttUv = rot(radians(tsiwst)) * currnttUv;
		float polt = -pow(currnttUv.x, 2) + sin(iTime) * 0.2 - currnttUv.y;
		polt = abs(polt) * 123;
		f += 1 - step(0.5, polt);
	}

	O.rgb = vec3(f);
}
