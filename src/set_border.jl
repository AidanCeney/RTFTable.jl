function set_borders!(dt;rows = Nothing(),cols = Nothing(),which_border = ["b" "l" "t" "r"],border_width = Nothing(),onoff = true)
	border_map = Dict("b" => "bottom",
			  "l" => "left",
			  "t" => "top",
			  "r" => "right")
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	for border in which_border
		set_properties(property_matrix,border_map[border]*"_border",onoff,rows,cols)
		if !isnothing(border_width)
			set_properties(property_matrix,border_map[border]*"_border_width",onoff,rows,cols)
			set_values(value_matrix,border_map[border]*"_border_width",border_width,rows,cols)
		end
	end
	return
end


function write_border(str_matrix,i,j,border_id)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clbrdr" * border_id * "\\brdrs"
	return
end

function write_border_width(str_matrix,value,i,j)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\brdrw" * value
	return
end

