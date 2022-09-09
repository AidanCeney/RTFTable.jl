
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




function make_values_matrix(mlen,mht)
	
	values_matrix = Vector{Any}(undef, mlen)
	for i = 1:mlen
		values_matrix[i] = Array{Dict{String,Bool}}(undef,mht)
	end

	for i = 1:mlen
		for j = 1:mht
			values_matrix[i][j] = Dict{String, String}()
		end
	end

	return values_matrix
end

function set_values(value_matrix,prop,value,rows,cols)
	
	for i = 1:length(rows)
		for j = 1:length(cols)
			value_matrix[rows[i]][cols[j]][prop] = value
		end
	end
	return value_matrix
end

function set_col_values(value_matrix,prop,value,cols)
	return set_properties(value_matrix, prop, value, 1:length(value_matrix), cols)
end

function set_row_value(value_matrix, prop,value,rows)
	return set_properties(value_matrix, prop, value, rows, 1:length(value_matrix[1]))
end

