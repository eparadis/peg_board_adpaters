// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

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

module shelf() {
  W = 100;
  D = 25;
  rotate([90,0,0]) hook_rest();
  translate([0,W,0]) rotate([90,0,0]) hook_rest();

  translate([0,2.5,-15]) {
    cube([D, W-5, 3]);
    cube([3,W-5,15]);
  }
}

shelf();
//hook_rest();