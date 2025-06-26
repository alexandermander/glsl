
mat2 rotationMatrix(float angle) {
    return mat2(
        cos(angle), -sin(angle),
        sin(angle),  cos(angle)
    );
}

#define PI 3.14159265359

float box(vec2 someCor) {
	float size = 0.05;
	return step(abs(someCor.x),size) * step(abs(someCor.y),size);
}

float funStupe(vec2 uv, float adding){
	float left = step(-0.02,uv.y + adding);
	float right = step(0.02,uv.y + adding);
	return left - right;
}

//float plot(vec2 st){
//	float x = st.x;
//	float y = st.y;
//
//	float f = x;
//
//	return step(f,y)* step(y, f + 0.01);
//}

//    vec2 uv = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

vec3 color(vec3 theColor) {
	return vec3(theColor.r/ 225.0, theColor.g / 225.0, theColor.b / 225.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy; // range [0, 1]
	uv = uv * 2.0 - 1.0; // range [-1, 1]

	float bettwing = 0.3;
	float someSteo = 0;

	for (float i = 0.0; i < 10.0; i++) {
		someSteo =  step(i / 100, uv.y );
	}

	vec3 sunColor = vec3(0.5, 0.3, 0.0); 
	sunColor = mix(vec3(0.0, 0.0, 0.0), sunColor, someSteo);

	fragColor = vec4(vec3(sunColor), 0.0);
}


