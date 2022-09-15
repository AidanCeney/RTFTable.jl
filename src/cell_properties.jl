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


function clmgf(str_matrix,value,i,j)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clmgf"
end

function clmrg(str_matrix,value,i,j)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clmrg"
end
