function set_font_size(dt::jtable.DataTable,font_size;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

	if mod(font_size * 10,5) != 0
		 error("font_size must be a factor of .5")
	end
	font_size = string(font_size*2)
	value_matrix    = dt.value_matrix
	set_values(value_matrix,"fs",font_size,rows,cols)
	return
end

function set_font(dt::jtable.DataTable,font;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
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
	set_values(value_matrix,"font",string(index),rows,cols)
	return
end

function set_alignment(dt::jtable.DataTable,align;rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())

	property_matrix = dt.property_matrix
	if !(align in ["left","right","center","justify"])
		error("align must be one of the following: left, right, center, justify")
	end
	for a in ["left","right","center","justify"]
		set_properties(property_matrix,a*"_align",false,rows,cols)
	end
	set_properties(property_matrix,align*"_align",true,rows,cols)
	return
end

function set_bold(dt;onoff::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	property_matrix = dt.property_matrix
	set_properties(property_matrix,"bold",onoff,rows,cols)
	return
end

function set_italic(dt;onoff::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	
	property_matrix = dt.property_matrix
	set_properties(property_matrix,"italic",onoff,rows,cols)
	return
end


function set_font_color(dt;red::Int = 0,green::Int = 0,blue::Int = 0,onoff::Bool = true,rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())	
	
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
	
	set_properties(property_matrix,"fontcolor",onoff,rows,cols)
	set_values(value_matrix,"fontcolor",string(index),rows,cols)
	return
end