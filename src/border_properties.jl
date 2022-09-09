
function write_border(str_matrix,df_cell,i,j,border_id)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clbrdr" * border_id * "\\brdrs"
	return
end

function bottom_border(str_matrix,value,df_cell,i,j)
	write_border(str_matrix,df_cell,i,j,"b")
end


function top_border(str_matrix,value,df_cell,i,j)
	write_border(str_matrix,df_cell,i,j,"t")
end


function right_border(str_matrix,value,df_cell,i,j)
	write_border(str_matrix,df_cell,i,j,"r")
end

function left_border(str_matrix,value,df_cell,i,j)
	write_border(str_matrix,df_cell,i,j,"l")
end

function write_border_width(str_matrix,value,df_cell,i,j)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\brdrw" * value
	return
end

function bottom_border_width(str_matrix,value,df_cell,i,j)
	write_border_width(str_matrix,value,df_cell,i,j)
end

function top_border_width(str_matrix,value,df_cell,i,j)
	write_border_width(str_matrix,value,df_cell,i,j)
end

function right_border_width(str_matrix,value,df_cell,i,j)
	write_border_width(str_matrix,value,df_cell,i,j)
end

function left_border_width(str_matrix,value,df_cell,i,j)
	write_border_width(str_matrix,value,df_cell,i,j)
end


