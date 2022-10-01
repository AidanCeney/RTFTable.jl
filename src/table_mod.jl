function add_df(dt,df;position = Nothing(),header = false,rowwise = true)
	
	if isnothing(position)
		if rowwise
			position = length(dt.property_matrix)
		else
			position = length(dt.property_matrix[1])
		end
	end

	new_dt              = make_data_table(df,header = header)
	property_matrix     = dt.property_matrix
	value_matrix        = dt.value_matrix
	
	nrow = length(dt.property_matrix)
	ncol = length(dt.property_matrix[1])
	max_size = 0
	new_add  = 0

	if rowwise
		nrow = nrow + length(new_dt.property_matrix)
		max_size = nrow
		new_add = length(new_dt.property_matrix)
	else
		ncol = ncol + length(new_dt.property_matrix[1])
		max_size = ncol
		new_add  = length(new_dt.property_matrix[1])
	end

	new_property_matrix  = make_property_matrix(nrow,ncol)
	new_value_matrix     = make_value_matrix(nrow,ncol)
	new_string_matrix    = make_string_matrix(nrow,ncol)

	for i = 1:position
		add_row_or_col!(new_property_matrix,dt.property_matrix,i,rowwise,i)
		add_row_or_col!(new_value_matrix,dt.value_matrix,i,rowwise,i)
	end

	for i = (position+1):(position+new_add)
		add_row_or_col!(new_property_matrix,new_dt.property_matrix,i-position,rowwise,i)
		add_row_or_col!(new_value_matrix,new_dt.value_matrix,i-position,rowwise,i)
	end

	for i = (1+position+new_add):max_size
		add_row_or_col!(new_property_matrix,dt.property_matrix,i-new_add,rowwise,i)
		add_row_or_col!(new_value_matrix,dt.value_matrix,i-new_add,rowwise,i)
	end
	dt.property_matrix = new_property_matrix
	dt.value_matrix    = new_value_matrix
	if !rowwise
		reset_col_width(dt)
	end
	
	dt.global_properties["nrow"] = nrow
	dt.global_properties["ncol"] = ncol

	update_string_matrix!(dt)

	
	return dt
end

function add_row(dt,rows;position = Nothing())
	df = DataFrames.DataFrame(reshape(rows,1,:),:auto)
	new_dt = add_df(dt,df,position = position)
	dt.property_matrix = new_dt.property_matrix
	dt.value_matrix    = new_dt.value_matrix
	return dt
end

function add_row_or_col!(matrix,new_matrix,new_vec_pos,add_row,i)
	if add_row
		matrix[i] = new_matrix[new_vec_pos]
		return matrix
	end
	for j = 1:length(matrix)
		matrix[j][i] = new_matrix[j][new_vec_pos]
	end
	return matrix
end

