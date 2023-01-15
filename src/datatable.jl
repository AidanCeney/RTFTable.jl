"""
	DataTable

`DataTable` scrut that holds table properties, values, and current string output, as well as global properties.  

# Fields
- `properties_matrix`: A 2d vector, with dimensions corresponding to the num`ber of rows and columns of the table, that holds a dictionary of booleans that sets if property should be used.
- `value_matrix`: A 2d vector, with dimensions corresponding to the num`ber of rows and columns of the table, that holds a dictionary of Strings that stores values for properties that need it(for example font).
- `string_matrix`: A 2d vector, with dimensions corresponding to the num`ber of rows and columns of the table, that holds a length 2 String vector that holds the current `RTFTable` string output. The first entry corresponds with the header line for the cell while the second entry corresponds to the value line. Function `update_string_matrix!` updates this field based on `properties_matrix` and `value_matrix`. 
- `global_properties`: The global options for the `RTFTable` such as table width or fonts.
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
```
"""
mutable struct DataTable
	property_matrix::Vector{Any}
	value_matrix::Vector{Any}
	string_matrix::Vector{Any}
	global_properties::Dict{String, Any}
end
"""
	make_data_table(df::DataFrames.AbstractDataFrame;header::Bool = true,len::Float64 = 6.5)

Creates a `DataTable` which is used to create the custom rtf file.

# Arguments
- `df`: `DataFrame` to create `DataTable` from.
- `header`: When `true` adds the `DataFrames` headers to the `DataTable`. 
- `width`: Table width in inches. 
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
```
"""
function make_data_table(df::DataFrames.AbstractDataFrame;header::Bool = true,width::Float64 = 6.5)
	
	nrow = size(df,1)
	ncol = size(df,2)

	global_properties = Dict{String,Any}()
	global_properties["nrow"] = nrow 
	global_properties["ncol"] = ncol
	global_properties["doc_width"] = width
	global_properties["fonts"] = Vector{String}()
	global_properties["fontcolors"] = Vector{String}()
	push!(global_properties["fontcolors"],"\\red0\\green0\\blue0")
	dt = DataTable(make_property_matrix!(nrow,ncol),make_value_matrix!(nrow,ncol),make_string_matrix!(nrow,ncol),global_properties)

	init_property_matrix!(dt::RTFTable.DataTable)
	init_value_matrix!(dt::RTFTable.DataTable,df,width)
	update_string_matrix!(dt)
	
	if(header)
		add_row!(dt::RTFTable.DataTable,names(df),position = 0);
		dt.global_properties["nrow"] = nrow + 1
	end
	return dt
end


function init_property_matrix!(dt::RTFTable.DataTable)

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

function init_value_matrix!(dt::RTFTable.DataTable,df::DataFrames.AbstractDataFrame,width::Float64)

	config_properties = YAML.load_file(project_path("config/init_properties.yaml"),dicttype=OrderedDict)
	ncol = length(dt.property_matrix[1])
		
	for (prop, dict) in config_properties 	
		if prop == "value"
			for i in eachindex(dt.property_matrix)
				for j in eachindex(dt.property_matrix[1])
					set_values!(dt.value_matrix,prop,string(df[i,j]),i,j)
				end
			end
		elseif prop == "cellx"
			for j in eachindex(dt.property_matrix[1])
				set_values!(dt.value_matrix,prop,string(init_cellx(j,ncol,width)),Nothing(),j)
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
