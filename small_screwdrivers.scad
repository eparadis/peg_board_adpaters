// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

size_in_pegs = 4;
depth = 25;
hole_diameter = 5;
holes_per_peg = 2;
two_rows = false;

module _stop_customizer() {}

$fn = 32;

function peg_board_holes_to_mm(x) = INCH * x;

module hook_rest() {
  angle = 70.1;
  dist_from_board = 4;
  T=5;
  H=15;
  x = depth-dist_from_board > 25-dist_from_board ? 25-dist_from_board : depth-dist_from_board;
  tcmds = [
    "right",90, "move",5, "arcleft",5,180-angle, "untilx",x,
    "left",angle, "untily", 0
  ];
  path = turtle(tcmds);
  translate([dist_from_board,0,-T/2]) linear_extrude(height=T, convexity=10) polygon(path);

  // outside support
  translate([0,-H,T/2]) cube([x+dist_from_board,H,3]);

  // inside support
  radius = min( H-3, depth-(x+dist_from_board));
  echo(radius);
  translate([0,0,-T/2-3]) linear_extrude(height=3) polygon(turtle([
    "move",depth-radius, "arcright",radius,90, "untily",-H,
    "right",90, "untilx",0,
  ]));
}

module shelf(D, W) {
  cube([D, W-5, 3]);
  cube([3,W-5,15]);
}

module holes(W) {
  for (i=[0:peg_board_holes_to_mm(1/holes_per_peg):W-25]) {
    translate([0, i+10, -20]) cylinder(h=30, d=hole_diameter);
  }
}

module shelf_with_holes(W) {
  D = depth;
  difference() {
    shelf(D, W);
    if(two_rows) {
      translate([3+(depth-3)*.25,0,0]) holes(W);
      translate([3+(depth-3)*.67,0,0]) holes(W);
    } else {
      translate([3+depth/2,0,0]) holes(W);
    }
  }
}

module screwdriver_holder(hook_distance) {
  W = hook_distance;
  D = depth;
  rotate([90,0,0]) hook_rest();
  mirror([0,1,0]) translate([0,-W,0]) rotate([90,0,0]) hook_rest();
  
  translate([0,2.5,-15]) shelf_with_holes(W);
}

//shelf_with_holes(peg_board_holes_to_mm(size_in_pegs));
screwdriver_holder(peg_board_holes_to_mm(size_in_pegs));