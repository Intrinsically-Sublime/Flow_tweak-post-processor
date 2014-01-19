-- Flow_rate.lua
-- By Sublime 2013 https://github.com/Intrinsically-Sublime
-- Adjust flow rate of individual sections of gcode based on comments

-- Licence:  GPL v3
-- This library is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-----------------------------------------------------------------------------------

---------------------------- START USER SETTINGS ----------------------------

-- Set extrusion height and width to automatically calculate the required perimter flow rate based on Nopheads equation
height = 0.2
width = 0.55
-- Perimter flow rate used by Kisslicer and Cura
perimeter = math.floor(((1 + (3.14159/4 -1) / (width/height))*100)+0.5)

-- Set flow rate in percentage of default flow rate
-- Uses M221 Snn
interface = 100		-- Support interface used by Kisslicer only.
support = 100		-- All support in Cura and for main support in Kisslicer
loops = 100		-- Inner perimeters for Kisslicer and Cura
solid_infill = 100	-- Solid infill used by Kisslicer only.
sparse_infill = 100	-- All infill in Cura and sparse infill in Kisslicer.

---------------------------- END USER SETTINGS ----------------------------

-- open files
collectgarbage()  -- ensure unused files are closed
local fin = assert( io.open( arg[1] ) ) -- reading
local fout = assert( io.open( arg[1] .. ".processed", "wb" ) ) -- writing must be binary

-- read lines
for line in fin:lines() do
	
		-- Kisslicer
		local inter_k = line:match( "; 'Support Interface',") -- Find start of support interface
		local sup_k = line:match( "; 'Support (may Stack)',") -- Find start of support
		local perim_k = line:match( "; 'Perimeter',") -- Find start of perimeter
		local loop_k = line:match( "; 'Loop',") -- Find start of loops
		local solid_k = line:match( "; 'Solid',") -- Find start of solid infill
		local sparse_k = line:match( "; 'Stacked Sparse Infill',") -- Find start of sparse infill
	
		-- Cura
		local sup_c = line:match(";TYPE:SUPPORT") -- Find start of support
		local perim_c = line:match(";TYPE:WALL\--OUTER") -- Find start of perimeter
		local loop_c = line:match(";TYPE:WALL\--INNER") -- Find start of loops
		local infill_c = line:match(";TYPE:FILL") -- Find start of sparse infill

	
	-- Set new flow rate of support interface (Kisslicer)
	if inter_k then
		fout:write("; Set support interface flow rate.\r\n")
		fout:write("M221 S" .. interface .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of support (Kisslicer)
	elseif sup_k then
		fout:write("; Set support flow rate.\r\n")
		fout:write("M221 S" .. support .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of outer perimeter (Kisslicer)
	elseif perim_k then
		fout:write("; Set perimeter flow rate.\r\n")
		fout:write("M221 S" .. perimeter .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of loops (Kisslicer)
	elseif loop_k then
		fout:write("; Set flow rate for loops.\r\n")
		fout:write("M221 S" .. loops .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of solid infill (Kisslicer)
	elseif solid_k then
		fout:write("; Set solid infill flow rate.\r\n")
		fout:write("M221 S" .. solid_infill .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of sparse infill (Kisslicer)
	elseif sparse_k then
		fout:write("; Set sparse infill flow rate.\r\n")
		fout:write("M221 S" .. sparse_infill .. "\r\n;\r\n")
		fout:write(line .. "\r\n")


	-- Cura only
	-- Set new flow rate of support (Cura)
	elseif sup_c then
		fout:write("; Set support flow rate.\r\n")
		fout:write("M221 S" .. support .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of outer perimeter (Cura)
	elseif perim_c then
		fout:write("; Set perimeter flow rate.\r\n")
		fout:write("M221 S" .. perimeter .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of loops (Cura)
	elseif loop_c then
		fout:write("; Set flow rate for loops.\r\n")
		fout:write("M221 S" .. loops .. "\r\n;\r\n")
		fout:write(line .. "\r\n")

	-- Set new flow rate of infill (Cura)
	elseif infill then
		fout:write("; Set infill flow rate.\r\n")
		fout:write("M221 S" .. sparse_infill .. "\r\n;\r\n")
		fout:write(line .. "\r\n")
		
	else
	fout:write( line .. "\n" )
	

  end
end

-- done
fin:close()
fout:close()
print "done"
