function set_borders!(dt;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing} = Nothing(),sides= ["b" "l" "t" "r"],border_width::Union{Int, Nothing} = Nothing(),onoff::Bool = true)
	
	
	if any(i -> !(i in ["b","l","t","r"]) , sides)
		error("sides argument must be one of the following: b, l, t, r")
	end
	
	border_map = Dict("b" => "bottom",
			  "l" => "left",
			  "t" => "top",
			  "r" => "right")
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	for border in sides
		set_properties(property_matrix,border_map[border]*"_border",onoff,rows,cols)
		if !isnothing(border_width)
			set_properties(property_matrix,border_map[border]*"_border_width",onoff,rows,cols)
			set_values(value_matrix,border_map[border]*"_border_width",border_width,rows,cols)
		end
	end
	return
end


function write_border(str_matrix::Vector,i::Int,j::Int,border_id::String)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clbrdr" * border_id * "\\brdrs"
	return
end

function write_border_width(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\brdrw" * value
	return
end

