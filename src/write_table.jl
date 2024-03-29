"""
	write_table(dt::RTFTable.DataTable,rtf_path;update = true,append = false)

Writes DataTable to an provided rtf file.
	
# Arguments
- `dt::DataTable`: Data Table to write.
- `rtf_path::String`: Path to write to.
- `update::Bool`: Updates String Matrix when true, set to `false` when String Matrix has been updated manualy. 
- `append::Bool`: Appends to existing file if true, previous file must have been generate by RTFTable and have the same Font Table and Font Color table to work properly.

# Example
```julia-repl
RTFTable.write_table(dt,"example.rtf")
```
"""
function write_table(dt::RTFTable.DataTable,rtf_path::String;update::Bool = true,append::Bool = false)
	
	if update
		update_string_matrix!(dt)
	end
	string_matrix = dt.string_matrix
	
	if !append
		touch(rtf_path)
		rtf_file = open(rtf_path,"w")
		write(rtf_file,"{\\rtf1\\ansi\\deff0")
		write(rtf_file,get_font_colors(dt))
		write(rtf_file,get_font_table(dt))
	else
		prev_rtf_file    = split(read(rtf_path,String),"\n")
	    prev_rtf_file    = prev_rtf_file[1:(length(prev_rtf_file)-1)]
		prev_rtf_file    = join(prev_rtf_file,"\n")
		rm(rtf_path,force = true)
		touch(rtf_path)
		rtf_file = open(rtf_path,"w")
		write(rtf_file,prev_rtf_file)
		write(rtf_file,"\n\\page\n")
	end

	for i = 1:size(string_matrix,1) 
		write(rtf_file,"\n{\n\\trowd\n")
		for j = 1:2
			for k = 1:length(string_matrix[1])
				write(rtf_file,string_matrix[i][k][j])
				write(rtf_file,"\n")
			end
		end
		write(rtf_file,"\\row\n}")
	end
	write(rtf_file,"\n}")
	if "footer" in keys(dt.global_properties)
		write(rtf_file,get_foobte(dt))
	end
	close(rtf_file)
	return 
end
"""
	get_font_table(dt::RTFTable.DataTable)

Returns a string of the font table for the provided DataTable.
	
# Arguments
- `dt::DataTable`: Data Table to write.

# Example
```julia-repl
write(rtf_file,get_font_table(dt))
```
"""
function get_font_table(dt)
	
	fonts = dt.global_properties["fonts"]
	ret = "\n{\\fonttbl\n"
	
	for i in eachindex(fonts)
		ret = ret * "{\\f" * string(floor(i)) * " " * fonts[i] * ";}\n"
	end
	ret =  ret * "}\n"
	return ret
end
"""
	get_font_colors(dt::RTFTable.DataTable)

Returns a string of the font color table for the provided DataTable.
	
# Arguments
- `dt::DataTable`: Data Table to write.

# Example
```julia-repl
write(rtf_file,get_font_colors(dt))
```
"""
function get_font_colors(dt)
	
	fontcolors = dt.global_properties["fontcolors"]
	ret = "\n{\\colortbl;"

	for color in fontcolors
		ret = ret * color * ";"
	end
	ret =  ret * "}\n"
	return ret
end

