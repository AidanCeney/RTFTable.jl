
function make_property_matrix(mlen,mht)
	
	property_matrix = Vector{Any}(undef, mlen)
	for i = 1:mlen
		property_matrix[i] = Array{Dict{String,Any}}(undef,mht)
	end

	for i = 1:mlen
		for j = 1:mht
			property_matrix[i][j] = Dict{String, Any}()
		end
	end

	return property_matrix
end

function write_properties(property_matrix, prop, section, rows, cols)
	
	for i = 1:length(rows)
		for j = 1:length(cols)
			property_matrix[rows[i]][cols[j]][prop] = section
		end
	end
	return property_matrix
end

function write_col_properties(property_matrix, prop, section, cols)
	return write_properties(property_matrix, prop, section, 1:length(property_matrix), cols)
end

function write_row_properties(property_matrix, prop, section, rows)
	return write_properties(property_matrix, prop, section, rows, 1:length(property_matrix[1]))
end
