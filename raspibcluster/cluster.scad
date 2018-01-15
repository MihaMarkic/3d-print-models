include <common.scad>;

mikrotik_y = 90;
mikrotik_x = 113.5;
mikrotik_full_x = mikrotik_x+2*delta;
mikrotik_full_y = mikrotik_y+2*delta;
mikrotik_h = 2;
mikrotik_vent_h = 2;

round_border_r = 3;

plate_x = mikrotik_full_x + 2*h;
plate_y = mikrotik_full_y + 2*h;
border_z = 6;
total_z = h + border_z;

charger_x=26;
charger_y=90;

module main_plate_half(x, y, z) {
    difference() {
        union() {
            translate([0, round_border_r, 0]) cube([x, y-round_border_r, z], false);
            translate([round_border_r, 0, 0]) cube([x-round_border_r, round_border_r, z], false);
            translate([round_border_r, round_border_r, 0]) cylinder(h=z, r=round_border_r, $fn=fn);
        }
        translate([2 * h, 2 * h, border_z]) cube([mikrotik_x / 2 - h + delta, mikrotik_y - 2 * h, h]);
        translate([h, h, 0]) cube([mikrotik_x / 2 + delta, mikrotik_y, border_z]);
    }
}
module main_plate() {
    union() {
        main_plate_half(plate_x / 2, plate_y, total_z);
        translate([plate_x, 0, 0]) mirror([1, 0, 0]) main_plate_half(plate_x / 2, plate_y, total_z);
    }
}

module base() {
    difference() {
        main_plate();
    }
}

module bottom_left_pin() {
    translate([d_large/2+h, d_large/2 + mikrotik_vent_h, h])
        small_pin(hole_z-delta);
}

module bottom_left_pin_with_holder() {
    translate([h+delta, h+delta, border_z]) union() 
    {
        cube([d_large+h, d_large+mikrotik_vent_h, h]);
        bottom_left_pin();
    }
}

module full() {
    base();
    union() {
        bottom_left_pin_with_holder();
        translate([0, between_pins_y, 0]) bottom_left_pin_with_holder();
        translate([between_pins_x, between_pins_y, 0]) bottom_left_pin_with_holder();
        gap = plate_y - 2*h - d_large+mikrotik_vent_h - (between_pins_x - (d_large+mikrotik_vent_h)/2);
        translate([between_pins_x, 0, 0]) union() {
            bottom_left_pin_with_holder();
            translate([h+delta, plate_y - 2*h - gap, border_z]) cube([d_large+h, gap, h]);
        }
    }
}

full();
