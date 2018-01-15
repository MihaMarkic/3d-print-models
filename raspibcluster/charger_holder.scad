include <common.scad>;

charger_x=90;
charger_y=57.5;
charger_z = 4;

center_x = between_pins_x/2;
center_y = between_pins_y/2;

horizontal_height = 6;

module quarter() {
    union() {
        pin();
        difference() {
            union() {
                rotate(90) translate([0, -d_large/2]) cube([between_pins_y/2, d_large, h]);
                dist_from_large_y = (between_pins_y - charger_y + d_large) / 2;
                first_support_y = dist_from_large_y-d_large/2;
                remaining_y = center_y - (first_support_y + horizontal_height);
                translate([0, first_support_y - 1]) cube([between_pins_x/2, horizontal_height, h]);
                translate([0, remaining_y]) cube([between_pins_x/2, horizontal_height, h]);
                charger_space_y = charger_y/2+delta;
                charger_bay();
            }
            #pin_hole();
        }
    }
}

module charger_bay() {
    charger_space_y = charger_y/2+delta+h;
    charger_space_x = charger_x/2+delta+h;
    plate_quarter_y = between_pins_x/2 + d_large/2;
    charger_oversize_x = charger_space_x - plate_quarter_y;
    union() {
        translate([0, 0, h])
        union() {
            translate([-d_large/2, 0, 0]) cube([d_large, d_large/2, charger_z]);
        }
        translate([-d_large/2-charger_oversize_x, center_y-charger_space_y, 0])
        union() {
            difference() {
                cube([charger_space_x, charger_space_y, charger_z+h]);
                translate([h, h, 0])cube([charger_space_x, charger_space_y, charger_z+h]);
            }
            translate([charger_oversize_x, 0])cylinder(r=charger_oversize_x, h=charger_z+h, $fn=fn);
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
