// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

size_in_pegs = 4;

module _stop_customizer() {}

$fn = 32;

function peg_board_holes_to_mm(x) = INCH * x;

module hook_rest() {
  T=5;
  H=15;
  tcmds = [
    "right",90, "move",5, "arcleft",5,120, "untilx",22,
    "left",60, "untily", 0
  ];
  path = turtle(tcmds);
  translate([3,0,-T/2]) linear_extrude(height=T, convexity=10) polygon(path);
  translate([0,-H,T/2]) cube([25,H,3]);
  translate([0,-H,-T/2-3]) cube([25,H,3]);
}

module shelf(D, W) {
  cube([D, W-5, 3]);
  cube([3,W-5,15]);
}

module shelf_with_holes(W) {
  D = 25;
  difference() {
    shelf(D, W);
    for (i=[0:peg_board_holes_to_mm(0.5):W]) {
      translate([15, i+10, -20]) cylinder(h=30, d=5);
    }
  }
}

module screwdriver_holder(hook_distance) {
  W = hook_distance;
  D = 25;
  rotate([90,0,0]) hook_rest();
  translate([0,W,0]) rotate([90,0,0]) hook_rest();
  
  translate([0,2.5,-15]) shelf_with_holes(W);
}

//shelf_with_holes(peg_board_holes_to_mm(5));
screwdriver_holder(peg_board_holes_to_mm(size_in_pegs));