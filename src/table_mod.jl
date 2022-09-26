function add_df(dt,df;position = Nothing(),header = false)
	if isnothing(position)
		position = length(dt.property_matrix)
	end
	new_dt              = make_data_table(df,header = header)
	print(new_dt.property_matrix)
	property_matrix     = dt.property_matrix
	value_matrix        = dt.value_matrix
	new_property_matrix = make_property_matrix(length(dt.property_matrix)+length(new_dt.property_matrix),length(dt.property_matrix[1]))
	new_value_matrix    = make_value_matrix(length(dt.property_matrix)+length(new_dt.property_matrix),length(dt.property_matrix[1]))
	new_string_matrix    = make_string_matrix(length(dt.property_matrix)+length(new_dt.property_matrix),length(dt.property_matrix[1]))
	
	for i = 1:position 
		new_property_matrix[i] = dt.property_matrix[i]
		new_value_matrix[i] = dt.value_matrix[i]
		new_string_matrix[i] = dt.string_matrix[i]
	end

	for i = (position+1):(position+length(new_dt.property_matrix))
		new_property_matrix[i] = new_dt.property_matrix[i-position]
		new_value_matrix[i] = new_dt.value_matrix[i-position]
		new_string_matrix[i] = new_dt.string_matrix[i-position]
	end

	for i = (1+position+length(new_dt.property_matrix)):(length(new_property_matrix))
		new_property_matrix[i] = dt.property_matrix[i-length(new_dt.property_matrix)]
		new_value_matrix[i] = dt.value_matrix[i-length(new_dt.property_matrix)]
		new_string_matrix[i] = dt.string_matrix[i-length(new_dt.property_matrix)]
	end
	dt.property_matrix = new_property_matrix
	dt.value_matrix    = new_value_matrix
	dt.string_matrix    = new_string_matrix
	return dt
end

function add_row(dt,rows;position = Nothing())
	df = DataFrames.DataFrame(reshape(rows,1,:),:auto)
	new_dt = add_df(dt,df,position = position)
	dt.property_matrix = new_dt.property_matrix
	dt.value_matrix    = new_dt.value_matrix
	return dt
end
