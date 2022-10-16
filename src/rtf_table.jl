mutable struct DataTable
	property_matrix::Vector{Any}
	value_matrix::Vector{Any}
	string_matrix::Vector{Any}
	global_properties::Dict{String, Any}
end

function make_data_table(df;header = true,len = 6.5)
	
	nrow = size(df,1)
	ncol = size(df,2)

	global_properties = Dict{String,Any}()
	global_properties["nrow"] = nrow 
	global_properties["ncol"] = ncol
	global_properties["doc_len"] = len
	global_properties["fonts"] = Vector{String}()
	dt = DataTable(make_property_matrix(nrow,ncol),make_value_matrix(nrow,ncol),make_string_matrix(nrow,ncol),global_properties)

	init_property_matrix!(dt,nrow,ncol)
	init_value_matrix!(dt,df,nrow,ncol,len)
	update_string_matrix!(dt)
	
	if(header)
		add_row(dt,names(df),position = 0);
		dt.global_properties["nrow"] = nrow + 1
	end
	return dt
end


function init_property_matrix!(dt,nrow,ncol)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)

	for i = 1:nrow
		for j = 1:ncol
			for (prop,dict)  = config_properties
				set_properties(dt.property_matrix,prop,dict["onoff"],i,j)
			end
		end
	end
	return
end

function init_value_matrix!(dt,df,nrow,ncol,len)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)
	
	for i = 1:nrow
		for j = 1:ncol
			for (prop, dict) in config_properties 	
				if prop == "value"
					set_values(dt.value_matrix,prop,string(df[i,j]),i,j)
				elseif prop == "cellx"
					set_values(dt.value_matrix,prop,string(init_cellx(j,ncol,len)),i,j)
				elseif prop == "font"
					set_values(dt.value_matrix,prop,"1",i,j)
					if length(dt.global_properties["fonts"]) == 0
						push!(dt.global_properties["fonts"],string(dict["value"]))
					end
				else
					set_values(dt.value_matrix,prop,string(dict["value"]),i,j)
				end
			end
		end
	end
	return
end

function Base.show(io::IO, z::DataTable)


	Values = getAll(z.value_matrix,"value")
	header = Values[1,:]
	Values = Values[2:size(Values,1),:]

	Borders_bottom = getAll(z.property_matrix,"bottom_border")
	Borders_top    = getAll(z.property_matrix,"top_border")
	Borders_right  = getAll(z.property_matrix,"left_border")
	Borders_left   = getAll(z.property_matrix,"right_border")


	
	print(io,PrettyTables.pretty_table(Values,header = header))
end
