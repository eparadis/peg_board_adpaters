// holds small screwdrivers, tip down
// uses cheap pegboard hooks

include <BOSL2/std.scad>

module hook_rest() {
  tcmds = [
    "move",5, "right",90, "move",20,
    "arcleft",5,120, "move",20,
    "left",60, "untily",5, "left",90, "untilx",0,
  ];
  path = turtle(tcmds);
  linear_extrude(height=5, convexity=10) polygon(path);
  
}

hook_rest();