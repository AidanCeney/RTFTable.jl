
function make_property_matrix(mlen,mht)
	
	property_matrix = Vector{Any}(undef, mlen)
	for i = 1:mlen
		property_matrix[i] = Array{Dict{String,Bool}}(undef,mht)
	end

	for i = 1:mlen
		for j = 1:mht
			property_matrix[i][j] = Dict{String, Bool}()
		end
	end

	return property_matrix
end

function set_properties(property_matrix,prop,onoff,rows,cols)
	
	for i = 1:length(rows)
		for j = 1:length(cols)
			property_matrix[rows[i]][cols[j]][prop] = onoff
		end
	end
	return property_matrix
end

function set_col_properties(property_matrix,prop,onoff,cols)
	return set_properties(property_matrix, prop, onoff, 1:length(property_matrix), cols)
end

function set_row_properties(property_matrix, prop,onoff,rows)
	return set_properties(property_matrix, prop, onoff, rows, 1:length(property_matrix[1]))
end

