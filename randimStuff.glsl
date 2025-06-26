
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 u_resolution = iResolution.xy;
    float u_time = iTime;

    // Zemin rengi başlangıçta beyaz
    vec3 initial_ground_color = vec3(1.0);

    // Zemindeki ışık efekti
    float i_for_ground_effect_params = 0.2;
    float angle_ground = (u_time + i_for_ground_effect_params) * 4.0;
    angle_ground -= sin(angle_ground);
    angle_ground -= sin(angle_ground);
    angle_ground /= 4.0;

    vec2 uv_screen = (fragCoord * 2.0 - u_resolution) / u_resolution.y;
    vec2 u_for_ground_calc = uv_screen;
    mat2 rot = mat2(cos(angle_ground), -sin(angle_ground), sin(angle_ground), cos(angle_ground));
    vec2 u_g_transformed = u_for_ground_calc * rot;
    vec2 clamped_u_g_transformed = clamp(u_g_transformed, -i_for_ground_effect_params, +i_for_ground_effect_params);
    u_for_ground_calc -= rot * clamped_u_g_transformed;

    float dist_for_ground_pattern = length(u_for_ground_calc);
    float glow_mask = smoothstep(0.4, 0.1, dist_for_ground_pattern);
    float noise_pattern_for_ground = sin((uv_screen.x + uv_screen.y) * 10.0 + u_time * 0.8 + dist_for_ground_pattern * 3.0) * 0.5 + 0.5;
    float final_ground_glow_intensity = glow_mask * noise_pattern_for_ground * 0.20;

    vec3 ground_light_color = vec3(0.6, 0.7, 1.0);
    initial_ground_color += ground_light_color * final_ground_glow_intensity;
    initial_ground_color = clamp(initial_ground_color, 0.0, 1.0);

    vec4 o = vec4(initial_ground_color, 1.0);

    // Nesne katmanları
    vec4 h_object_albedo;
    vec2 u_object_coords;
    
    for(float i_layer = 0.6; i_layer > 0.1; i_layer -= 0.1) {
        float angle_object_layer = (u_time + i_layer) * 4.0;
        angle_object_layer -= sin(angle_object_layer);
        angle_object_layer -= sin(angle_object_layer);
        angle_object_layer /= 4.0;

        u_object_coords = uv_screen;
        mat2 rot_obj = mat2(cos(angle_object_layer), -sin(angle_object_layer), sin(angle_object_layer), cos(angle_object_layer));
        vec2 u_obj_transformed_by_a = u_object_coords * rot_obj;
        vec2 clamped_u_obj_transformed = clamp(u_obj_transformed_by_a, -i_layer, +i_layer);
        u_object_coords -= rot_obj * clamped_u_obj_transformed;

        float l_object_dist = max(length(u_object_coords), 0.1);
        float A_object_mix = min((l_object_dist - 0.1) * u_resolution.y * 0.2, 1.0);

        h_object_albedo = sin(i_layer / 0.1 + angle_object_layer + vec4(1.0, 3.0, 5.0, 0.0)) * 0.2 + 0.7;
        h_object_albedo.a = 1.0;

        o = mix(h_object_albedo, o, A_object_mix);

        vec4 modulation_color_source = vec4(h_object_albedo.rgb + 0.5 * A_object_mix * u_object_coords.y / l_object_dist, 1.0);
        modulation_color_source.rgb = max(modulation_color_source.rgb, 0.0);
        
        o *= mix(vec4(1.0), modulation_color_source, clamp(0.1 / l_object_dist, 0.0, 1.0));
    }

    fragColor = vec4(o.rgb, 1.0);
}

