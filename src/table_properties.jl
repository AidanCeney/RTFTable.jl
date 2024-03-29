function bottom_border(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border(str_matrix,i,j,"b")
	return
end

function top_border(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border(str_matrix,i,j,"t")
	return
end

function right_border(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border(str_matrix,i,j,"r")
	return
end

function left_border(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border(str_matrix,i,j,"l")
	return
end

function bottom_border_width(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border_width(str_matrix,value,i,j)
	return
end

function top_border_width(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border_width(str_matrix,value,i,j)
	return
end

function right_border_width(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border_width(str_matrix,value,i,j)
	return
end

function left_border_width(str_matrix::Vector,value::String,i::Int,j::Int)
	write_border_width(str_matrix,value,i,j)
	return
end

function left_padding(str_matrix::Vector,value::String,i::Int,j::Int)
	write_padding(str_matrix, i, j, "l", value) 
end

function right_padding(str_matrix::Vector,value::String,i::Int,j::Int)
	write_padding(str_matrix, i, j, "r", value) 
end

function bottom_padding(str_matrix::Vector,value::String,i::Int,j::Int)
	write_padding(str_matrix, i, j, "b", value) 
end

function top_padding(str_matrix::Vector,value::String,i::Int,j::Int)
	write_padding(str_matrix, i, j, "t", value) 
end

function value(str_matrix::Vector,value::String,i::Int,j::Int)

	str_matrix[i][j][2] = str_matrix[i][j][2] * "{" *  value * "}" 
	return
end

function bracket_open(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "{" 
	return
end

function bracket_close(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "}" 
	return
end

function cellx(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\cellx" *  value
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\cell" 
	return
end

function clmgf(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clmgf"
	return
end

function clmrg(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clmrg"
	return
end

function fs(str_matrix,value,i,j)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\fs" * value
	return
end

function fontcolor(str_matrix,value,i,j)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\cf" * value
	return
end

function left_align(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\ql"  
	return
end

function right_align(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\qr" 
	return
end

function center_align(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\qc"
	return
end

function justify_align(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\qj"
	return
end

function bold(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\b"
	return
end

function italic(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\i"
	return
end

function font(str_matrix::Vector,value::String,i::Int,j::Int)
	str_matrix[i][j][2] = str_matrix[i][j][2] * "\\f" * value
end

