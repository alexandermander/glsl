
void mainImage(out vec4 O, in vec2 I){
	vec2 uv = I / iResolution.xy;
	uv = uv * 2.0 - 1.0; 
	uv.x *= iResolution.x / iResolution.y; // Correct aspect ratio

	// randim
	vec2 p = mod(uv, 0.2); // Create a grid pattern);
	float thisP = p.x + p.y; // Combine x and y for a single value
	thisP = step(thisP, 0.1); // Threshold to create a binary pattern

	O.rgb = vec3(thisP);

}

