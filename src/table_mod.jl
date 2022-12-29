function add_df!(dt::jtable.DataTable,df;position::Union{Nothing,Int} = Nothing(),header::Bool = false,rowwise::Bool = true)	
	
	if rowwise
		if(DataFrames.ncol(df) != length(dt.property_matrix[1]))
			error("When adding new rows number of columns must match")
		end
	else
		if(DataFrames.nrow(df) != length(dt.property_matrix))
			error("When adding new columns number of rows must match")
		end
	end

	if isnothing(position)
		if rowwise
			position = length(dt.property_matrix)
		else
			position = length(dt.property_matrix[1])
		end
	end

	new_dt              = make_data_table(df,header = header)
	
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

function add_row(dt::jtable.DataTable,row::Vector;position::Union{Nothing,Int} = Nothing())
	df = DataFrames.DataFrame(reshape(row,1,:),:auto)
	new_dt = add_df!(dt::jtable.DataTable,df,position = position)
	dt.property_matrix = new_dt.property_matrix
	dt.value_matrix    = new_dt.value_matrix
	return dt
end

function add_col(dt::jtable.DataTable,col::Vector;position::Union{Nothing,Int} = Nothing())
	df = DataFrames.DataFrame(reshape(col,:,1),:auto)
	new_dt = add_df!(dt::jtable.DataTable,df,position = position,rowwise = false)
	dt.property_matrix = new_dt.property_matrix
	dt.value_matrix    = new_dt.value_matrix
	return dt
end

function add_row_or_col!(matrix::Vector,new_matrix::Vector,new_vec_pos::Int,add_row::Bool,i::Int)
	if add_row
		matrix[i] = new_matrix[new_vec_pos]
		return matrix
	end
	for j = 1:length(matrix)
		matrix[j][i] = new_matrix[j][new_vec_pos]
	end
	return matrix
end

