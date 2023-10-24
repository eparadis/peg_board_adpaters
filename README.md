Instead of buying a whole new tool pegboard system, just re-use the junky hooks to make secure holders for your tools!

This is a small shelf that securely hangs on the inexpensive hooks available from Harbor Freight. I designed it to fit small tools like allen wrenches or small screwdrivers, but it is widely customizable to fit various needs.

# Customization Parameters

## `size_in_pegs`

The width of shelf in the number of peg holes it takes up.

## `depth`

The distance (in mm) that the shelf extends from the peg board. It includes the strengthening piece across the back that lays against the peg board.

## `hole_diameter`

The diameter (in mm) of the first row of holes.

## `holes_per_peg`

The number of holes in the shelf included in the distance between two peg holes. Holes start a bit away from the edge of the shelf. For example, a with `size_in_pegs=3` and `holes_per_peg=2`, you end up with five holes in a row.

## `two_rows`

Set to true to get two rows of holes spaced apart. Set to false to get one row centered in the shelf.

## `second_row_diameter`

The same as `hole_diameter` but for the second row of holes.

## `height`

The overall height of the shelf. Increase this to make the shelf “taller” which can help stability for larger tools by putting the center of gravity lower.

## `shelf_thickness`

The thickness of the shelf itself. Increase this to provide more support for your tools if they tend to flop over.

# Printing

You can print this in any orientation that makes sense to you for where you want the strength to be. You'll need to use supports most likely no matter what, but you won't need much.

I printed my shelves on a Prusa MINI with Hatchbox Dark Gray Matte PLA using the “0.25mm DRAFT” preset with “supports on build plate only” with the model oriented upright (the way it will be used on the peg board).
