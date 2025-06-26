float sinSqure(float v) {
  return sin(v + iTime) * 0.5 + 0.5;
}

// the sdBox is from Inigo Quilez's article on distance functions
// https://iquilezles.org/articles/distfunctions2d/
float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

void mainImage(out vec4 O, in vec2 I){
	vec2 R = iResolution.xy; // 
	vec2 uv = (I) / R.y;
	uv = uv * 2.0 - 1.0; // range [-1, 1]
	
	uv = uv * 4;

	vec2 uvi = floor(uv); 
	float testTheHash = sinSqure(uvi.x + uvi.y * iTime);

	testTheHash = step(0.15, testTheHash);
	
	vec2 boxSize = vec2(0.5, 0.5);

	float boxDist = sdBox(uv - uvi, boxSize);

	O = vec4(0.0);
	O.rgb += vec3(testTheHash) * step(boxDist, 0.01);
}

