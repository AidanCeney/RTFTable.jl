
function make_string_matrix(df, properties_matrix)
	string_matrix = init_string_matrix(size(df,1),size(df,2)*2)
	for i = 1:size(df,1)
		for j = 1:size(df,2)
			write_properties(string_matrix,properties_matrix[i][j],df[i,j],i,j) 
		end
	end
	return string_matrix
end

function init_string_matrix(nrow_string_matrix,ncol_string_matrix)
	string_matrix = ""
	for i in 1:nrow_string_matrix
		tmp_vec = ""
		for j in 1:ncol_string_matrix
			if j == 1
				tmp_vec = [""]
			else
				tmp_vec = [tmp_vec ""]
			end
		end
		if i == 1 
			string_matrix = tmp_vec
		else
			string_matrix = [string_matrix;tmp_vec]
		end
	end
	return string_matrix
end

function write_properties(string_matrix,properties_cell,df_cell,i,j)
	for (property_func, property_used) in properties_cell
		    if property_used
			getfield(Main, Symbol(property_func))(string_matrix,df_cell,i,j)
		    end
	end
end
