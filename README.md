Flow_tweak-post-processor
=========================

Works with KISSlicer and Cura gcode files with the comments enabled.

Post processor to adjust the flow rate of individual extrusion types in RepRap gcode

It looks for the comments stating when each extrusion type starts (perimeter, loops, solid infill, sparse infill, 
support, support interface) and injects a M221 S code which changes the flow rate in Marlin in percentages. 

The script is written in lua so you will need lua installed or an executable copy in the same folder as the script 
and the slicer. 

To use with Kisslicer you will also need to add the following to the post-process field in the firmware tab of Kisslicer.
`lua "Flow_rate.lua" " <FILE> "`

To use with Cura you will have to run it as a seperate process from the command line with the following command.
`lua "Flow_rate.lua" "example.gcode"` Can be overidden by using percentage in plae of the equation.

Set the layer height and extruson width to automatically calculate the correct extrusion rate for the perimeters using Nopheads equation for perimeter flow.
At the top of the script file you will see where the variables are set to adjust the flow rate of each extrusion type.

Note: The script creates a second gcode file marked processed.

 Uses
======
1. Decrease perimeter flow rate as described above in case of holes coming out too small.
2. Increase the loop flow rate to ensure all the loops all well fused to each other. Good for watertight prints.
3. Increase the support structure flow rate. Good to overcome starving the extruder from under extruding.
4. Increase the sparse infill flow rate to ensure un-broken paths while using straight infill.
5. Decrease the support interface flow rate to reduce the adhesion strength (Kisslicer only).
6. Increase or Decrease the solid infill flow rate to ensure solid infill without holes or lumps (Kisslicer only).


