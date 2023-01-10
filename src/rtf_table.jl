mutable struct DataTable
	property_matrix::Vector{Any}
	value_matrix::Vector{Any}
	string_matrix::Vector{Any}
	global_properties::Dict{String, Any}
end

function make_data_table(df::DataFrames.AbstractDataFrame;header::Bool = true,len::Float64 = 6.5)
	
	nrow = size(df,1)
	ncol = size(df,2)

	global_properties = Dict{String,Any}()
	global_properties["nrow"] = nrow 
	global_properties["ncol"] = ncol
	global_properties["doc_len"] = len
	global_properties["fonts"] = Vector{String}()
	global_properties["fontcolors"] = Vector{String}()
	push!(global_properties["fontcolors"],"\\red0\\green0\\blue0")
	dt = DataTable(make_property_matrix!(nrow,ncol),make_value_matrix!(nrow,ncol),make_string_matrix!(nrow,ncol),global_properties)

	init_property_matrix!(dt::RTFTable.DataTable,nrow,ncol)
	init_value_matrix!(dt::RTFTable.DataTable,df,nrow,ncol,len)
	update_string_matrix!(dt)
	
	if(header)
		add_row(dt::RTFTable.DataTable,names(df),position = 0);
		dt.global_properties["nrow"] = nrow + 1
	end
	return dt
end


function init_property_matrix!(dt::RTFTable.DataTable,nrow::Int,ncol::Int)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)

	for (prop,dict)  = config_properties
		if !isnothing(get_property_default_constructive(prop))
			set_properties!(dt.property_matrix,prop,get_property_default_constructive(prop),Nothing(),Nothing())
		else
			set_properties!(dt.property_matrix,prop,dict["constructive"],Nothing(),Nothing())
		end
	end
	return
end

function init_value_matrix!(dt::RTFTable.DataTable,df::DataFrames.AbstractDataFrame,nrow::Int,ncol::Int,len::Float64)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)
		
	for (prop, dict) in config_properties 	
		if prop == "value"
			for i in eachindex(dt.property_matrix)
				for j in eachindex(dt.property_matrix[1])
					set_values!(dt.value_matrix,prop,string(df[i,j]),i,j)
				end
			end
		elseif prop == "cellx"
			for j in eachindex(dt.property_matrix[1])
				set_values!(dt.value_matrix,prop,string(init_cellx(j,ncol,len)),Nothing(),j)
			end
		elseif prop == "font"
			set_values!(dt.value_matrix,prop,"1",Nothing(),Nothing())
			if !isnothing(get_property_default_value(prop))
				push!(dt.global_properties["fonts"],get_property_default_value(prop))					
			else
				push!(dt.global_properties["fonts"],string(dict["value"]))
			end
		else
			if !isnothing(get_property_default_value(prop))
				set_values!(dt.value_matrix,prop,get_property_default_value(prop),Nothing(),Nothing())
			else
				set_values!(dt.value_matrix,prop,string(dict["value"]),Nothing(),Nothing())
			end
		end
	end
	return
end

function Base.show(io::IO, z::DataTable)


	Values = getAll(z.value_matrix,"value")
	header = Values[1,:]
	Values = Values[2:size(Values,1),:]

	print(io,PrettyTables.pretty_table(Values,header = header))
end
