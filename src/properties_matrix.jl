
function make_dict_matrix(mlen,mht,type)
	
	property_matrix = Vector{Any}(undef, mlen)
	for i = 1:mlen
		property_matrix[i] = Array{OrderedDict{String,type}}(undef,mht)
	end

	for i = 1:mlen
		for j = 1:mht
			property_matrix[i][j] = OrderedDict{String, type}()
		end
	end

	return property_matrix
end

function set_dict_matrix(dict_matrix,prop,set,rows,cols)
	
	if isnothing(rows)
		rows = 1:length(dict_matrix)
	end

	if isnothing(cols)
		cols = 1:length(dict_matrix[1])
	end

	for i = 1:length(rows)
		for j = 1:length(cols)
			dict_matrix[rows[i]][cols[j]][prop] = set
		end
	end
	return dict_matrix
end

function getAll(dict_matrix,field)
	
	ret = []
	tmp = []
	nrow = length(dict_matrix)
	ncol = length(dict_matrix[1])
	
	for i = 1:nrow
		for j = 1:ncol
			if j == 1
				tmp  = [dict_matrix[i][j][field]]
			else
				tmp = [tmp dict_matrix[i][j][field]]
			end
		end
		if i == 1
			ret = tmp
		else
			ret = [ret;tmp]
		end
		tmp = []
	end
	return ret
end

function make_property_matrix(mlen,mht)
	return make_dict_matrix(mlen,mht,Bool)
end

function set_properties(property_matrix,prop,onoff,rows,cols)
	return set_dict_matrix(property_matrix,prop,onoff,rows,cols)
end


function make_value_matrix(mlen,mht)
	return make_dict_matrix(mlen,mht,String)
end

function set_values(value_matrix,prop,value,rows,cols)
	return set_dict_matrix(value_matrix,prop,value,rows,cols)
end

