function merge_cols!(dt::RTFTable.DataTable; rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	
	if isnothing(cols)
		cols = 1:length(dt.property_matrix[1])
	end

	property_matrix = dt.property_matrix
	value_matrix    = dt.value_matrix
	set_properties!(property_matrix,"clmgf",true,rows,cols[1])
	set_properties!(property_matrix,"clmrg",true,rows,cols[2:length(cols)])
	for i in rows
		set_values!(value_matrix,"value","",i,cols[2:length(cols)])
	end
	return
end

function init_cellx(j::Int,ncol::Int,leng_inch::Float64)
	return Int(round(j * (leng_inch * inch_twip_ratio / ncol)))
end

function reset_col_width(dt::RTFTable.DataTable)
	
	ncol         = dt.global_properties["ncol"]
	doc_width    = dt.global_properties["doc_len"]
	col_width    = Int(floor(doc_width * 1440 /ncol))
	set_cell_width!(dt::RTFTable.DataTable,col_width)
	return
end

function set_cell_width!(dt::RTFTable.DataTable,col_width::Union{Float64,Vector{Float64}};rows::Union{Vector{Int}, Int, Nothing}= Nothing(),cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	
	col_width = col_width * inch_twip_ratio
	
	if isnothing(cols)
		cols = 1:length(dt.property_matrix[1])
	end
	
	if isnothing(rows)
		rows = 1:length(dt.property_matrix)
	end

	if(length(col_width) != length(cols))
		col_width = repeat([col_width],length(cols))
	end

	orig_width = getAll(dt.value_matrix,"cellx")	

	for i = eachindex(rows)
		width_val = 0		
		new_width = map(x->parse(Int64,x),orig_width[rows[i],:])
		prev = 0
		for w = eachindex(new_width)
			tmp = new_width[w]
			new_width[w] = new_width[w] - prev
			prev = tmp
		end
		new_width[cols] .= col_width 

		for j = eachindex(dt.property_matrix[1])
			width_val += new_width[j]
			set_values!(dt.value_matrix,"cellx",string(width_val),rows[i],j)
		end
	end
	return
end

function add_padding!(dt::RTFTable.DataTable, onoff::Bool, value::Int;sides::Vector{String} = ["b" "l" "t" "r"], rows::Union{Vector{Int}, Int, Nothing}= Nothing(), cols::Union{Vector{Int}, Int, Nothing}= Nothing())
	
	border_map = Dict("b" => "bottom",
			  		  "l" => "left",
			  		  "t" => "top",
			  		  "r" => "right")
	for side in sides
		set_properties!(dt.property_matrix,border_map[side] * "_padding", onoff, rows, cols)
		set_values!(dt.value_matrix, border_map[side] * "_padding", string(value), rows, cols)
	end
	return
end

function write_padding(str_matrix::Array, i::Int, j::Int, border_id::String, value::String)
	str_matrix[i][j][1] = str_matrix[i][j][1] * "\\clpadf" * border_id * "3\\clpad" * border_id * value
	return
end