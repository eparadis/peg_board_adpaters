// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

size_in_pegs = 3;
depth = 25;
hole_diameter = 3.1;
holes_per_peg = 2;
two_rows = true;
second_row_diameter = 5.5;

module _stop_customizer() {}

// the screw drivers I want to hang with this have the following diameters:
// 4.32, 1.42, 1.97, 3.11, 2.36, 2.95, 3.80


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
  translate([0,0,-T/2-3]) linear_extrude(height=3) polygon(turtle([
    "move",depth-radius, "arcright",radius,90, "untily",-H,
    "right",90, "untilx",0,
  ]));
}

module shelf(D, W) {
  cube([D, W-5, 3]);
  cube([3,W-5,15]);
}

module holes(W, dia) {
  for (i=[0:peg_board_holes_to_mm(1/holes_per_peg):W-25]) {
    translate([0, i+10, -20]) cylinder(h=30, d=dia);
  }
  echo(str("hole spacing is: ", peg_board_holes_to_mm(1/holes_per_peg)));
}

module shelf_with_holes(W) {
  D = depth;
  difference() {
    shelf(D, W);
    if(two_rows) {
      translate([3+(depth-3)*.25,0,0]) holes(W, hole_diameter);
      translate([3+(depth-3)*.67,0,0]) holes(W, second_row_diameter);
      echo(str("distance between rows (center to center): ", (depth-3)*.67 - (depth-3)*.25));
    } else {
      translate([3+depth/2,0,0]) holes(W, hole_diameter);
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