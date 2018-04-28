include <common.scad>;

raspbi_pins_y = 49;
raspbi_pins_x = 58;
raspbi_support_h = 4;
raspbi_support_d = 6;
raspbi_support_hole_d = 2.15;

horizontal_support_height = 6;
horizontal_support_y = (between_pins_y-raspbi_pins_y-horizontal_support_height)/2;

horizontal_height = 6;

module quarter() {
    union() {
        pin();
        difference() {
            union() {
                rotate(90) translate([0, -d_large/2]) cube([between_pins_y/2, d_large, h]);
                translate([0, horizontal_support_y, 0]) cube([between_pins_x/2, horizontal_support_height, h]);
                translate([(between_pins_x-raspbi_pins_x)/2, (between_pins_y-raspbi_pins_y)/2, h]) difference() {
                    cylinder(d=raspbi_support_d, h=raspbi_support_h, $fn=fn);
                    cylinder(d=raspbi_support_hole_d, h=raspbi_support_h, $fn=fn);
                }
            }
            pin_hole();
        }
    }
}

module four_pins() {
    quarter();
    translate([between_pins_x, 0]) mirror([1, 0, 0]) quarter();
    translate([0, between_pins_y]) mirror([0, 1, 0]) quarter();
    translate([between_pins_x, between_pins_y]) mirror([1,0,0]) mirror([0,1,0]) quarter();
}

four_pins();