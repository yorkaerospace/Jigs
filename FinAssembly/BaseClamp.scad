// A small, ashtray-shaped clamp for holding fin assemblies into a body while glue sets
module rocket_base_clamp(
    // Parameters of the rocket
    tube_diameter,
    fin_thickness,
    num_fins=4,
    // Basic dimensions
    claw_depth=20,
    base_depth=10,
    lip_width=7,
    // Bevel around the lip to allow easy fitting
    bevel_depth=5,
    bevel_expansion=2,
    // Notches
    notch_depth=5,
    notch_fin_sep=1,
) {
    notch_height = claw_depth + base_depth + 2;
    notch_width = fin_thickness + (notch_fin_sep * 2);

    difference() {
        // Base cylinder
        cylinder(h = base_depth + claw_depth, r = (tube_diameter / 2) + lip_width);

        // Hole
        union () {
            translate([0, 0, base_depth])
                cylinder(h = claw_depth + 1, r = tube_diameter / 2);

            translate([0, 0, base_depth + (claw_depth - bevel_depth)])
                cylinder(
                    h = bevel_depth + 1,
                    r1 = tube_diameter / 2,
                    r2 = (tube_diameter / 2) + bevel_expansion
                );
        };

        // Cutouts
        for (i = [0:num_fins - 1]) {
            rotate([0, 0, (360 / num_fins) * i])
            translate([
                (tube_diameter / 2) - notch_depth,
                -(notch_width / 2),
                -1
            ])
            cube(
                [
                    notch_depth + lip_width,
                    notch_width,
                    notch_height
                ]
            );
        }
    };
};

rocket_base_clamp(50, 3);

translate([120, 0, 0])
rocket_base_clamp(
    60,
    2,
    num_fins=6,
    base_depth=3,
    claw_depth=40,
    lip_width=4,
    bevel_depth=15
);
