
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 uv = fragCoord / iResolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float space = 0.025;
    int   N   = int(floor(2.0/space)) + 1; 



    float tanMask   = 0.0;


	float speed = 0.03;

	float half = space * 0.5;

	for(int i = 0; i < N; i++){

		float worldX = float(i)*space - 1.0 + half + speed*iTime;
		float x0     = mod(worldX + 1.0, 2.0) - 1.0;
		float y0     = - (x0*x0) / 0.6;
		float m      = -10.0/3.0 * x0;           
		vec2  dir    = normalize(vec2(1.0, m));   
		vec2  perp   = vec2(-dir.y, dir.x);       
		float dL     = abs(dot(uv - vec2(x0,y0), perp));
		tanMask      = max(tanMask, step(dL, 0.003));
	}


    vec3 col = vec3(0.05, 0.1, 0.2);
    col = mix(col, vec3(1.0, 0.0, 0.0), tanMask);

    fragColor = vec4(col, 1.0);
}














//float circle (vec2 thisCord, float radius) {
//	return  length(thisCord) - radius;
//}
//
//float lineCross (vec2 thisCord) {
//
//	float x = pow(thisCord.x,2) -  thisCord.y;
//	return abs(x);
//}
//
//
//float fmarked (vec2 thisCord) {
//	float f = -10.0 / 3.0 * thisCord.x - thisCord.y;
//	return abs(f) * 123;
//}
//
//float otherLineCross (vec2 thisCord, float angle) {
//	float b = thisCord.y - thisCord.x * angle;
//	float f = angle * thisCord.x - thisCord.y + b;
//	return abs(f) * 123;
//}
//
//void mainImage(out vec4 O, in vec2 I){
//	vec2 uv = I / iResolution.xy;
//	uv = uv * 2.0 - 1.0; 
//	uv.x *= iResolution.x / iResolution.y; 
//
//	vec3 col = vec3(0.0, 0.1, 0.0);
//
//	float space = 0.1;
//
//	float sekmnet = floor((uv.x + 1.0) / space);
//	float xPos = sekmnet * space - 1.0 + space / 2.0;
//	
//	float yPos = - pow(xPos, 2.0) / 0.6;
//	vec2 p = vec2(xPos, yPos);
//
//	float circleX = circle(uv - p, 0.01);
//	circleX = step(circleX, 0.0) * 1.0;
//
//	
//	col = vec3(1.) * circleX;
//
//	float holding = fmarked(uv - p);
//	col += vec3(step(holding, 1.0)) * 0.5;
//
//	float otherLineX = otherLineCross(-p, holding);
//	//col += vec3(step(otherLineX, 1.0)) * 0.3;
//
//	O.rgb = col;
//}

