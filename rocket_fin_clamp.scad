module rocket_fin_clamp(
    // Parameters of rocket
    tube_diameter,
    fin_thickness,
    fin_length,
    num_fins=4,
    // Basic Dimensions
    thickness=5,
    // Tolerances/offsets
    outer_offset=10,
    inner_offset=1,
    fin_side_offset=2,
    fin_outer_offset=1,
    fillet_radius=2,
) {
    // Intermediate vars
    inner_radius = (tube_diameter / 2) + inner_offset;
    fin_cutout_len = fin_length - inner_offset + fin_outer_offset;
    fin_cutout_width = fin_thickness + (fin_outer_offset * 2);

    difference() {
        // Basic cylinder
        cylinder(
            r = inner_radius + fin_cutout_len + outer_offset,
            h = thickness
        );

        union() {
            // Inner hole
            translate([0, 0, (thickness / 2)])
            cylinder(
                r = inner_radius,
                h = thickness + 2,
                center = true
            );

            for (i = [0:num_fins]) {
                rotate([0, 0, (360 / num_fins) * i])
                translate([0, -(fin_cutout_width / 2), -1])
                cube([
                        fin_cutout_len + inner_radius,
                        fin_cutout_width,
                        thickness + 2,
                    ]
                    /* center = true */
                );
            };
        };
    };
}

rocket_fin_clamp(50, 4, 50);
