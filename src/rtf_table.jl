

mutable struct DataTable
	property_matrix::Vector{Any}
	value_matrix::Vector{Any}
	string_matrix::Vector{Any}
end

function make_data_table(df)
	
	nrow = size(df,1)
	ncol = size(df,2)

	dt = DataTable(make_property_matrix(nrow,ncol),make_value_matrix(nrow,ncol),make_string_matrix(nrow,ncol))

	init_property_matrix!(dt.property_matrix,nrow,ncol)
	init_value_matrix!(dt.value_matrix,df,nrow,ncol)
	update_string_matrix!(dt)
	
	return dt
end


function init_property_matrix!(property_matrix,nrow,ncol)
	ls_properties = ["clmgf",           "clmrg",
			 "left_border"  ,  "left_border_width",
			 "top_border"   ,  "top_border_width",
			 "right_border" ,  "right_border_width",
			 "bottom_border",  "bottom_border_width",
			 "fs",
			 "value",          "cellx"]
	for i = 1:nrow
		for j = 1:ncol
			for prop = ls_properties
				set_properties(property_matrix,prop,prop in ["value" "cellx" "fs"],i,j)
			end
		end
	end
	return
end

function init_value_matrix!(property_matrix,df,nrow,ncol;leng_inch = 8.5)
	ls_properties = ["clmgf"          => "",  "clmrg"                => "",
			 "left_border"   => "",  "left_border_width"   => "10",
			 "top_border"    => "",  "top_border_width"    => "10",
			 "right_border"  => "",  "right_border_width"  => "10",
			 "bottom_border" => "",  "bottom_border_width" => "10",
			 "fs"            => 20,
			 "value" => "",          "cellx"               => "" ]
	for i = 1:nrow
		for j = 1:ncol
			for (prop, val) in ls_properties
				if prop == "value"
					set_values(property_matrix,prop,string(df[i,j]),i,j)
				elseif prop == "cellx"
					set_values(property_matrix,prop,string(init_cellx(j,ncol,leng_inch)),i,j)
				else
					set_values(property_matrix,prop,string(val),i,j)
				end
			end
		end
	end
	return
end

function init_cellx(j,ncol,leng_inch)
	return Int(round(j * (leng_inch * 1440 / ncol)))
end
