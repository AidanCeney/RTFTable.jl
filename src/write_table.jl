function write_table(dt::jtable.DataTable,rtf_path;update = true)
	
	if update
		update_string_matrix!(dt)
	end
	string_matrix = dt.string_matrix
	touch(rtf_path)
	rtf_file = open(rtf_path,"w")
	write(rtf_file,"{\\rtf1\\ansi\\deff0")
	write(rtf_file,get_font_colors(dt))
	write(rtf_file,get_font_table(dt))
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

function get_font_table(dt)
	
	fonts = dt.global_properties["fonts"]
	ret = "\n{\\fonttbl\n"
	
	for i in eachindex(fonts)
		ret = ret * "{\\f" * string(floor(i)) * " " * fonts[i] * ";}\n"
	end
	ret =  ret * "}\n"
	return ret
end

function get_font_colors(dt)
	
	fontcolors = dt.global_properties["fontcolors"]
	ret = "\n{\\colortbl;"

	for color in fontcolors
		ret = ret * color * ";"
	end
	ret =  ret * "}\n"
	return ret
end

