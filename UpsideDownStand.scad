// A stand for holding the bottom half of rockets flat
//
// A wide-based cylinder with a cutout to hold a tube and a slot to accomodate a godnut
module stand(
    // Rocket parameters
    inner_diam,
    outer_diam,
    godnut_width,
    godnut_depth,
    inner_tube_protrudes=false,
    inner_tube_outer,
    inner_tube_length,
    // Stand parameters
    godnut_offset=1,
    stand_depth=10,
    tube_notch_depth=5,
    tube_notch_offset=0.5,
    bottom_rim_width=5,
    top_rim_width=4
) {
    // Assertions
    assert(inner_diam < outer_diam);
    assert(stand_depth > max([
        godnut_depth + godnut_offset,
        tube_notch_depth,
        inner_tube_length
    ]));

    godnut_notch_depth = godnut_depth + godnut_offset + 1;

    difference() {
        // Outer cylinder
        cylinder(
            r1 = (outer_diam / 2) + tube_notch_offset + bottom_rim_width,
            r2 = (outer_diam / 2) + tube_notch_offset + top_rim_width,
            h = stand_depth
        );

        // Tube cutout
        translate([0, 0, stand_depth - tube_notch_depth])
        difference() {
            cylinder(
                r = (outer_diam / 2) + tube_notch_offset,
                h = tube_notch_depth + 1
            );

            translate([0, 0, -1]) cylinder(
                r = (inner_diam / 2) - tube_notch_offset,
                h = tube_notch_depth + 3
            );
        }

        // Godnut notch
        translate([0, 0, (
            godnut_notch_depth / 2) + stand_depth - godnut_notch_depth + 1
        ])
        cube([
            inner_diam,
            godnut_width + godnut_offset,
            godnut_notch_depth
        ], center = true);

        // Inner tube
        if (inner_tube_protrudes) {
            translate([0, 0, stand_depth - inner_tube_length + 1])
            cylinder(
                r = (inner_tube_outer / 2) + tube_notch_offset,
                h = inner_tube_length + 1
            );
        }
    }
}

stand(50, 52, 10, 5);
translate([80, 0, 0])
stand(50, 52, 10, 5, true, 31, 8);
