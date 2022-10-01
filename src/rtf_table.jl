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
	global_properties["nrow"] = nrow + header
	global_properties["ncol"] = ncol
	global_properties["doc_len"] = len
	
	dt = DataTable(make_property_matrix(nrow,ncol),make_value_matrix(nrow,ncol),make_string_matrix(nrow,ncol),global_properties)

	init_property_matrix!(dt.property_matrix,nrow,ncol)
	init_value_matrix!(dt.value_matrix,df,nrow,ncol,len)
	update_string_matrix!(dt)
	
	if(header)
		add_row(dt,names(df),position = 0)
	end
	return dt
end


function init_property_matrix!(property_matrix,nrow,ncol)
	
	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)

	for i = 1:nrow
		for j = 1:ncol
			for (prop,dict)  = config_properties
				set_properties(property_matrix,prop,dict["onoff"],i,j)
			end
		end
	end
	return
end

function init_value_matrix!(property_matrix,df,nrow,ncol,len)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)
	
	for i = 1:nrow
		for j = 1:ncol
			for (prop, dict) in config_properties 	
				if prop == "value"
					set_values(property_matrix,prop,string(df[i,j]),i,j)
				elseif prop == "cellx"
					set_values(property_matrix,prop,string(init_cellx(j,ncol,len)),i,j)
				else
					set_values(property_matrix,prop,string(dict["value"]),i,j)
				end
			end
		end
	end
	return
end

