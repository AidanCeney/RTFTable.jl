
function make_string_matrix(df, properties_matrix,value_matrix)
	string_matrix = init_string_matrix(size(df,1),size(df,2))
	for i = 1:size(df,1)
		for j = 1:size(df,2)
			write_properties(string_matrix,properties_matrix[i][j],value_matrix[i][j],df[i,j],i,j) 
		end
	end
	return string_matrix
end

function init_string_matrix(nrow_string_matrix,ncol_string_matrix)

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

function write_properties(string_matrix,properties_cell,df_cell,i,j)
	for (property_func, property_used) in properties_cell
		    if property_used
			    getfield(Main, Symbol(property_func))(string_matrix,value_matrix[i][j][property_func],df_cell,i,j)
		    end
	end
end
