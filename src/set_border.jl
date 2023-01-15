"""
	set_borders!(dt;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing} = Nothing(),sides= ["b" "l" "t" "r"],border_width::Union{Int, Nothing} = Nothing(),constructive::Bool = true)

Sets the borders for the provided `dt`. Border width can also be set for the given border.

# Arguments
- `dt`: Data Table to set.
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
- `sides`: A `String` `Vector` that selects for which borders to set. `Sides` `b` corresponds to bottom, `l` corresponds to left, `t` corresponds to top, and `r` corresponds to right. 
- `constructive`: When `true` sets the property, when `false` removes the property. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_borders!(dt,sides = ["b"],rows = [1,3])
RTFTable.set_borders!(dt,sides = ["t"],cols = [1])
```
"""
function set_borders!(dt;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing} = Nothing(),sides::Vector{String} = ["b","l","t","r"],border_width::Union{Int, Nothing} = Nothing(),constructive::Bool = true)
	
	
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
		set_properties!(property_matrix,border_map[border]*"_border",constructive,rows,cols)
		if !isnothing(border_width)
			set_properties!(property_matrix,border_map[border]*"_border_width",constructive,rows,cols)
			set_values!(value_matrix,border_map[border]*"_border_width",border_width,rows,cols)
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

