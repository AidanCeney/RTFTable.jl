function set_font_size(dt,font_size;rows = Nothing(),cols = Nothing())
	
	font_size = string(font_size*2)
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_values(value_matrix,"fs",font_size,rows,cols)
	return
end

function set_alignment(dt,align;rows = Nothing(),cols = Nothing())

	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	for a in ["left","right","center","justify"]
		set_properties(property_matrix,a*"_align",false,rows,cols)
	end
	set_properties(property_matrix,align*"_align",true,rows,cols)
end

function set_bold(dt;onoff = true,rows = Nothing(),cols = Nothing())
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties(property_matrix,"bold",onoff,rows,cols)
	set_properties(property_matrix,"close_bold",onoff,rows,cols)
	return
end

function set_italic(dt;onoff = true,rows = Nothing(),cols = Nothing())
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties(property_matrix,"italic",onoff,rows,cols)
	set_properties(property_matrix,"close_italic",onoff,rows,cols)
	return
end

