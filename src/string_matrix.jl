
function update_string_matrix!(dt)
	

	properties_matrix = dt.property_matrix
	value_matrix      = dt.value_matrix	
	nrow              = dt.global_properties["nrow"]
	ncol              = dt.global_properties["ncol"]
	string_matrix     = make_string_matrix(nrow,ncol) 

	for i = 1:nrow
		for j = 1:ncol
			write_properties(string_matrix,properties_matrix[i][j],value_matrix[i][j],i,j) 
		end
	end
	dt.string_matrix = string_matrix
	return 
end

function make_string_matrix(nrow_string_matrix,ncol_string_matrix)

	str_matrix = Vector{Any}(undef, nrow_string_matrix)
	for i = 1:nrow_string_matrix
		str_matrix[i] = Array{Array}(undef,ncol_string_matrix)
	end

	for i = 1:nrow_string_matrix
		for j = 1:ncol_string_matrix
			str_matrix[i][j] = ["" ""]
		end
	end
	return str_matrix 

end

function write_properties(string_matrix,properties_cell,values_cell,i,j)
	for (property_func, property_used) in properties_cell
		    if property_used
			    getfield(jtable, Symbol(property_func))(string_matrix,values_cell[property_func],i,j)
		    end
	end
end
