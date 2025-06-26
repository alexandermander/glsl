
#define PI 3.14159265359

float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) - smoothstep( pct, pct+0.01, st.y);
}

void mainImage(out vec4 O, in vec2 I) {

    vec2 uv = I.xy/iResolution.xy;

    vec3 color = vec3(0.0);

	vec3 colorA = vec3(0.51,0.142,0.13);
	vec3 colorB = vec3(1.000,0.836,0.24);

	float f = 2 * sin(uv.x + uv.x * 46 ) / 1.2 + .8;

    vec3 pct = vec3(f);

    color = mix(colorA, colorB, pct);


    color = mix(color,vec3(1.0,0.0,0.0), plot(uv,pct.r) );
    color = mix(color,vec3(0.0,1.0,0.0), plot(uv,pct.g) );
    color = mix(color,vec3(0.0,0.0,1.0), plot(uv,pct.b) );

    O = vec4(color,1.0);
}


