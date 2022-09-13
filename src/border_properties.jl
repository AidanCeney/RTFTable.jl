
function write_border(str_matrix,i,j,border_id)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clbrdr" * border_id * "\\brdrs"
	return
end

function bottom_border(str_matrix,value,i,j)
	write_border(str_matrix,i,j,"b")
end


function top_border(str_matrix,value,i,j)
	write_border(str_matrix,i,j,"t")
end


function right_border(str_matrix,value,i,j)
	write_border(str_matrix,i,j,"r")
end

function left_border(str_matrix,value,i,j)
	write_border(str_matrix,i,j,"l")
end

function write_border_width(str_matrix,value,i,j)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\brdrw" * value
	return
end

function bottom_border_width(str_matrix,value,i,j)
	write_border_width(str_matrix,value,i,j)
end

function top_border_width(str_matrix,value,i,j)
	write_border_width(str_matrix,value,i,j)
end

function right_border_width(str_matrix,value,i,j)
	write_border_width(str_matrix,value,i,j)
end

function left_border_width(str_matrix,value,i,j)
	write_border_width(str_matrix,value,i,j)
end

function value(str_matrix,value,i,j)
	str_matrix[i][j][2] = str_matrix[i][j][2] * value
end

function cellx(str_matrix,value,i,j)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\cellx" *  value
end
