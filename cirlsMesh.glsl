
float someHash(vec2 p) {
	
	return fract(sin(dot(p, vec2(127.9901, 78.236))) * 4360.5455); // returns a value between 0.0 and 1.0
}


float cirkel(vec2 centrum, vec2 cor) {
	// range form 0.0 to 0.3
	float r = someHash(centrum) * 0.4 + 0.1 * -cos(someHash(centrum) * 6.28 + iTime * 1.5); 
	vec2 diff = centrum - cor;
	float cirklLent = length(diff);

	return smoothstep(r - 0.01, r + 0.01, cirklLent); // smoothstep for a soft edge
//

}

void mainImage(out vec4 O, in vec2 fragCoord) {
    vec2 uv = (2.0*fragCoord-iResolution.xy)/iResolution.y; // range [-1, 1]
	uv *= 4.0; // scale to 4x4 grid, range [-2, 2]

	vec2 uvi = floor(uv) + 0.5; // center of the grid cell, range [-1.5, 1.5]
    float xline = 	uvi.x ;
    float yline = 	uvi.y ;

	float theCIrl = cirkel(vec2(xline,yline), uv);

	vec3 color = (theCIrl > 0.0) ? (
		vec3(0.0)
		//make it orange
	) :	vec3(
		exp(-0.5 * length(uv - uvi) * 19.0), 
		exp(-0.5 * length(uv - uvi) * 3.0),
		exp(-0.5 * length(uv - uvi) * 1.0)
	  );
	O.rgb = vec3(color);
}

