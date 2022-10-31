function merge_cols(dt; rows = Nothing(),cols = Nothing())
	
	if isnothing(cols)
		cols = 1:length(dt.property_matrix[1])
	end

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
	return Int(round(j * (leng_inch * inch_twip_ratio / ncol)))
end

function reset_col_width(dt)
	
	ncol         = dt.global_properties["ncol"]
	doc_width    = dt.global_properties["doc_len"]
	col_width    = Int(floor(doc_width * 1440 /ncol))
	set_cell_width(dt,col_width)
	return
end

function set_cell_width(dt,col_width;rows = Nothing(),cols = Nothing())
	
	col_width = col_width * inch_twip_ratio
	
	if isnothing(cols)
		cols = 1:length(dt.property_matrix[1])
	end
	
	if isnothing(rows)
		rows = 1:length(dt.property_matrix)
	end

	if(length(col_width) != length(cols))
		col_width = repeat([col_width],length(cols))
	end

	orig_width = getAll(dt.value_matrix,"cellx")	

	for i = eachindex(rows)
		width_val = 0		
		new_width = map(x->parse(Int64,x),orig_width[rows[i],:])
		prev = 0
		for w = eachindex(new_width)
			tmp = new_width[w]
			new_width[w] = new_width[w] - prev
			prev = tmp
		end
		new_width[cols] = length(col_width) > 1 ? col_width : col_width[1]

		for j = eachindex(dt.property_matrix[1])
			width_val += new_width[j]
			set_values(dt.value_matrix,"cellx",string(width_val),rows[i],j)
		end
	end
	return
end
