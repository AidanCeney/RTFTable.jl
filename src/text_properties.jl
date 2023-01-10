"""
	set_font_size!(dt::RTFTable.DataTable,font_size;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

Sets the font size for the text in the provided `DataTable`.

# Arguments
- `dt`: Data Table to set.
- `font_size`: Font size to set must be a positive number and a factor of .5. 
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_font_size!(dt,20)
```
"""
function set_font_size!(dt::RTFTable.DataTable,font_size::Union{Float64,Int};rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

	if mod(font_size * 10,5) != 0
		 error("font_size must be a factor of .5")
	end
	font_size = string(font_size*2)
	value_matrix    = dt.value_matrix
	set_values!(value_matrix,"fs",font_size,rows,cols)
	return
end
"""
	set_font!(dt::RTFTable.DataTable,font;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

Sets the font for the text in the provided `DataTable`.

# Arguments
- `dt`: Data Table to set.
- `font`: Font to set. 
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_font!(dt,"Times",rows = 1)
```
"""
function set_font!(dt::RTFTable.DataTable,font::String;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	if !(font in dt.global_properties["fonts"]) 
		push!(dt.global_properties["fonts"],font)
	end
	value_matrix    = dt.value_matrix
	index = 1
	for f in dt.global_properties["fonts"]
		if font == f
			break
		end
		index = index + 1
	end
	set_values!(value_matrix,"font",string(index),rows,cols)
	return
end
"""
	set_alignment!(dt::RTFTable.DataTable,align;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

Sets the sets alignment for the provided DataTable. Options for alignment include `left`, `right`, `center`, and `justify`.

# Arguments
- `dt`: Data Table to set.
- `align`: Alignment to set must be one of the following: `left`, `right`, `center`, and `justify`. 
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_alignment!(dt,"left")
```
"""
function set_alignment!(dt::RTFTable.DataTable,align::String;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

	property_matrix = dt.property_matrix
	if !(align in ["left","right","center","justify"])
		error("align must be one of the following: left, right, center, justify")
	end
	for a in ["left","right","center","justify"]
		set_properties!(property_matrix,a*"_align",false,rows,cols)
	end
	set_properties!(property_matrix,align*"_align",true,rows,cols)
	return
end
"""
	set_bold!(dt;constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

Sets text boldness for provided `DataTable`.

# Arguments
- `dt`: Data Table to set.
- `constructive`: When `true` sets the property, when `false` removes the property. 
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_bold!(dt)
```
"""
function set_bold!(dt;constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	property_matrix = dt.property_matrix
	set_properties!(property_matrix,"bold",constructive,rows,cols)
	return
end
"""
	set_italic!(dt;constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	

Sets text italicness for provided `DataTable`.

# Arguments
- `dt`: Data Table to set.
- `constructive`: When `true` sets the property, when `false` removes the property. 
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_italic!(dt)
```
"""
function set_italic!(dt;constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	
	property_matrix = dt.property_matrix
	set_properties!(property_matrix,"italic",constructive,rows,cols)
	return
end

"""
	set_font_color!(dt;red::Int = 0,green::Int = 0,blue::Int = 0,constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	

Sets text font color for provided `DataTable` using the provided RGB values.

# Arguments
- `dt`: Data Table to set.
- `red`: Integer between 0 and 255 for how red text the should be.
- `green`: Integer between 0 and 255 for how green the text should be.
- `blue`: Integer between 0 and 255 for how blue the text should be.
- `rows`: Rows to set, when Nothing all rows are selected. 
- `cols`: Cols to set, when Nothing all cols are selected. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.set_font_color!(dt,blue = 255,cols = 2)
```
"""
function set_font_color!(dt;red::Int = 0,green::Int = 0,blue::Int = 0,constructive::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix

	if red > 255 ||  blue > 255 || green > 255 || red < 0 || green < 0 || blue < 0
		error("RGB values must be a value between 0 and 255")
	end
	
	color_string = "\\red" * string(red) * "\\green" * string(green) * "\\blue" * string(blue)
	
	if !(color_string in dt.global_properties["fontcolors"]) 
		push!(dt.global_properties["fontcolors"],color_string)
	end
	
	index = 1
	for f in dt.global_properties["fontcolors"]
		if color_string == f
			break
		end
		index = index + 1
	end
	
	set_properties!(property_matrix,"fontcolor",constructive,rows,cols)
	set_values!(value_matrix,"fontcolor",string(index),rows,cols)
	return
end