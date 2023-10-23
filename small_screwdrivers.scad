// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

size_in_pegs = 4;
depth = 25;
hole_diameter = 5;
holes_per_peg = 2;

module _stop_customizer() {}

$fn = 32;

function peg_board_holes_to_mm(x) = INCH * x;

module hook_rest() {
  dist_from_board = 3;
  T=5;
  H=15;
  x = depth-dist_from_board > 25-dist_from_board ? 25-dist_from_board : depth-dist_from_board;
  tcmds = [
    "right",90, "move",5, "arcleft",5,120, "untilx",x,
    "left",60, "untily", 0
  ];
  path = turtle(tcmds);
  translate([dist_from_board,0,-T/2]) linear_extrude(height=T, convexity=10) polygon(path);
  translate([0,-H,T/2]) cube([x+dist_from_board,H,3]);
  translate([0,-H,-T/2-3]) cube([depth,H,3]);
}

module shelf(D, W) {
  cube([D, W-5, 3]);
  cube([3,W-5,15]);
}

module shelf_with_holes(W) {
  D = depth;
  difference() {
    shelf(D, W);
    for (i=[0:peg_board_holes_to_mm(1/holes_per_peg):W-25]) {
      translate([3+depth/2, i+10, -20]) cylinder(h=30, d=hole_diameter);
    }
  }
}

module screwdriver_holder(hook_distance) {
  W = hook_distance;
  D = depth;
  rotate([90,0,0]) hook_rest();
  //translate([0,W,0]) rotate([90,0,0]) hook_rest();
  mirror([0,1,0]) translate([0,-W,0]) rotate([90,0,0]) hook_rest();
  
  translate([0,2.5,-15]) shelf_with_holes(W);
}

//shelf_with_holes(peg_board_holes_to_mm(size_in_pegs));
screwdriver_holder(peg_board_holes_to_mm(size_in_pegs));