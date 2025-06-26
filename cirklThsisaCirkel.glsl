
float sdCircle( in vec2 p, in float r ) 
{
	vec2 newP = p;
    return length(newP) - r;
}

float sdEllipse(in vec2 p, in vec2 r) {
    return length(p / r) - 1.0;
}

mat2 rot(float a) {
	float c = cos(a);
	float s = sin(a);
	return mat2(c, -s, s, c);
}

void mainImage(out vec4 O, in vec2 I){
    vec2 uv = (2.0 * I - iResolution.xy) / iResolution.y;

	float mainRadius = 0.5;

    vec2 local = fract(uv * 10.0) -0.5;
	vec2 grid = (floor(uv * 10.0) );

	float newCirkls = sdCircle(uv, mainRadius);

	float circle;
	if(step(newCirkls, 0.0) ==1) {
		vec2 toTheCenter = uv - grid;
		float angel = atan(toTheCenter.y, toTheCenter.x);

		local *= rot((iTime * 2.5 + angel) * 0.5);

		float distCirl = sdEllipse(local, vec2(newCirkls * 0.5, newCirkls ));
		circle = smoothstep(0.01, 0.0, distCirl);
	}

	O.rgb = vec3(circle);
}

//vec2 ellipseRadius = vec2(0.1 + abs(newCirkls) *						1.5, 0.1 + abs(newCirkls) * 0.5);

