"""
	add_df!(dt::RTFTable.DataTable,df;position::Union{Nothing,Int} = Nothing(),header::Bool = false,rowwise::Bool = true)	

Appends the provided `DataFrame` to the provided `DataTable`. Can be used to add columns or rows to the `DataTable` but the corresponding number of rows or columns must match. For the new row or columns the default settings will be used.

# Arguments
- `dt`: Data Table to set.
- `df`: `DatFrame` to add.
- `position`: Index of where the to add the `DataFrame`. When 0 adds at the beginning while n or `Nothing` adds to the end.
- `header`: When `true` also adds the `DataFrame` header. 
- `rowwise`: When `true` adds new rows, when `false` adds columns. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df)
```
"""
function add_df!(dt::RTFTable.DataTable,df::DataFrames.AbstractDataFrame;position::Union{Nothing,Int} = Nothing(),header::Bool = false,rowwise::Bool = true)	
	
	if rowwise
		if(DataFrames.ncol(df) != length(dt.property_matrix[1]))
			error("When adding new rows number of columns must match")
		end
	else
		if((DataFrames.nrow(df) + header) != length(dt.property_matrix))
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

	new_dt = make_data_table(df,header = header)
	
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

	new_property_matrix  = make_property_matrix!(nrow,ncol)
	new_value_matrix     = make_value_matrix!(nrow,ncol)
	new_string_matrix    = make_string_matrix!(nrow,ncol)

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
"""
	add_row!(dt::RTFTable.DataTable,row::Vector;position::Union{Nothing,Int} = Nothing())

Adds a row to provided `DataTable` based on provided `row` vector 

# Arguments
- `dt`: Data Table to set.
- `row`: Row you want to add
- `position`: Index of where the to add the row. When 0 adds at the beginning while n or `Nothing` adds to the end.
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_row!(dt,["A","B"])
```
"""
function add_row!(dt::RTFTable.DataTable,row::Vector;position::Union{Nothing,Int} = Nothing())
	df = DataFrames.DataFrame(reshape(row,1,:),:auto)
	new_dt = add_df!(dt::RTFTable.DataTable,df,position = position)
	dt.property_matrix = new_dt.property_matrix
	dt.value_matrix    = new_dt.value_matrix
	return dt
end
"""
	add_col!(dt::RTFTable.DataTable,col::Vector;position::Union{Nothing,Int} = Nothing())

Adds a row to provided `DataTable` based on provided `col` vector 

# Arguments
- `dt`: Data Table to set.
- `col`: Column you want to add
- `position`: Index of where the to add the column. When 0 adds at the beginning while n or `Nothing` adds to the end.
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_col!(dt,["A","1","2","3","4"])
```
"""
function add_col!(dt::RTFTable.DataTable,col::Vector;position::Union{Nothing,Int} = Nothing())
	df = DataFrames.DataFrame(reshape(col,:,1),:auto)
	new_dt = add_df!(dt::RTFTable.DataTable,df,position = position,rowwise = false)
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

