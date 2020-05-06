$fa = 1;
$fs = 0.4;

include <../configuration.scad>

// Don't mind me here
backplane_height = bottom_thickness + edge_thickness;

module base() {
  difference () {
    cube([10, 40, bottom_thickness]);
    translate([-2, 41, -14])
      rotate([45, 0, 0])
        cube(size=14.14);
  }
}

module backplane() {
  
  cube([10, 5, backplane_height]);
}

module top_cover() {
  translate([0, 0, backplane_height]) {
    difference() {
      cube([10, 30, top_thickness]);
      translate([-2, 21, 10])
        rotate([-45, 0, 0])
          cube(size=14.14);
    }
  }
}

module cable_ring() {
  thickness = 3;

  translate([5, ring_thickness, backplane_height+top_thickness + 3]) {
    difference() {
      rotate([90, 0, 0]) {
        cylinder(h=ring_thickness, r=5, center=false);
      };
      union() {
        rotate([90, 0, 0]) {
          translate([0, 0, -0.01])
            cylinder(h=ring_thickness + 0.1, r=3, center=false);
        };
        translate([-1, -ring_thickness, 2.8])
          rotate([0, 45, 0])
            cube([4.3, ring_thickness, 4.3]);
      }
    }
  }
}

module cable_holder(offset=0) {
  translate([offset*10,0,0]) {
    base();
    backplane();
    top_cover();
    cable_ring();
    if (counter_ring) {
      translate([10, counter_ring_distance, 0]) {
        rotate([0, 0, 180]) cable_ring();
      }
    }
  }
}

// I know this is dumb and I should just re-do rotations on everything
// else, but I can't be bothered.
rotate([90, 0, 0]) {
  for (i = [ 0 : holder_count - 1 ]) {
    cable_holder(i);
  }
}
