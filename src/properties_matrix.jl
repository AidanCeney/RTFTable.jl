
function make_dict_matrix(mlen::Int,mht::Int,type::Type)
	
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

function set_dict_matrix(dict_matrix::Vector,prop::String,set::Union{Bool,String},rows::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}},cols::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}})

	if length(dict_matrix) == 0
		error("dict_matrix is empty")
	end
	
	if isnothing(rows)
		rows = 1:length(dict_matrix)
	end

	if isnothing(cols)
		cols = 1:length(dict_matrix[1])
	end
	
	if any(i -> i > length(dict_matrix),rows)
		error("rows argument can not have values greater than number of rows")
	end

	if any(i -> i > length(dict_matrix[1]),cols)
		error("cols argument can not have values greater than number of columns")
	end

	for i = eachindex(rows)
		for j = eachindex(cols)
			dict_matrix[rows[i]][cols[j]][prop] = set
		end
	end
	return dict_matrix
end

function getAll(dict_matrix::Vector,field::String)
	
	
	if (length(dict_matrix) == 0)
		error("dict_matrix is empty")
	end
	
	if !(field in keys(dict_matrix[1][1]))
		error("argument field '" * field * "' does not exist in dict_matrix")
	end
	
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

function make_property_matrix(mlen::Int64,mht::Int64)
	return make_dict_matrix(mlen,mht,Bool)
end

function set_properties(property_matrix::Vector,prop::String,onoff::Bool,rows::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}},cols::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}})
	return set_dict_matrix(property_matrix,prop,onoff,rows,cols)
end


function make_value_matrix(mlen::Int64,mht::Int64)
	return make_dict_matrix(mlen,mht,String)
end

function set_values(value_matrix::Vector,prop::String,value::String,rows::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}},cols::Union{Vector{Int}, Int, Nothing, UnitRange{Int64}})
	return set_dict_matrix(value_matrix,prop,value,rows,cols)
end

