small_height = 23;
large_height = 12;

outer_large_x = 91.5;
outer_large_y = 79.5;

d_small = 5;
d_large = 10;
delta = .1;

between_pins_x = outer_large_x - d_large;
between_pins_y = outer_large_y - d_large;

hole_z = 10;
hole_full_d = d_small+8*delta;

h = 2;

fn = 80;

module pin() {
    union() {
        difference() {
            cylinder(d=d_large, h=large_height, $fn=fn);
            pin_hole();
        }
        translate([0, 0, large_height]) small_pin(small_height);
    }
}

module small_pin(z) {
    cylinder(d=d_small, h=z, $fn=fn);
}

module pin_hole() {
    cylinder(d=hole_full_d, h=hole_z, $fn=fn);
}