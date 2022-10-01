function merge_cols(dt,rows,cols)
	
	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties(property_matrix,"clmgf",true,rows,cols[1])
	set_properties(property_matrix,"clmrg",true,rows,cols[2:length(cols)])
	for i = 1:length(rows)
		set_values(value_matrix,"value",value_matrix[i][cols[1]]["value"],i,cols[2:length(cols)])
	end
	return
end

function init_cellx(j,ncol,leng_inch)
	return Int(round(j * (leng_inch * 1440 / ncol)))
end

function reset_col_width(dt)
	
	ncol         = dt.global_properties["ncol"]
	doc_width    = dt.global_properties["doc_len"]
	col_width    = Int(floor(doc_width * 1440 /ncol))
	set_cell_width(dt,col_width)
	return
end

function set_cell_width(dt,col_width;rows = Nothing(),cols = Nothing())
	
	if isnothing(cols)
		cols = 1:length(dt.property_matrix[1])
	end


	if(length(col_width) != length(cols))
		col_width = repeat([col_width],length(cols))
	end
	
	width_val = 0
	for i = 1:length(cols)
		width_val += col_width[i]
		set_values(dt.value_matrix,"cellx",string(width_val),rows,cols[i])
	end
	return
end
