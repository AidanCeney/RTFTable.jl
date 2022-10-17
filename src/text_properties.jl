function set_font_size(dt,font_size;rows = Nothing(),cols = Nothing())
	
	font_size = string(font_size*2)
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_values(value_matrix,"fs",font_size,rows,cols)
	return
end

function set_font(dt,font;rows = Nothing(),cols = Nothing())
	if !(font in dt.global_properties["fonts"]) 
		push!(dt.global_properties["fonts"],font)
	end
	property_matrix = dt.property_matrix
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

function set_alignment(dt,align;rows = Nothing(),cols = Nothing())

	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	for a in ["left","right","center","justify"]
		set_properties(property_matrix,a*"_align",false,rows,cols)
	end
	set_properties(property_matrix,align*"_align",true,rows,cols)
	return
end

function set_bold(dt;onoff = true,rows = Nothing(),cols = Nothing())
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties(property_matrix,"bold",onoff,rows,cols)
	return
end

function set_italic(dt;onoff = true,rows = Nothing(),cols = Nothing())
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties(property_matrix,"italic",onoff,rows,cols)
	return
end

