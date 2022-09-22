
function write_table(dt,rtf_path;update = true)
	
	if update
		update_string_matrix!(dt)
	end
	string_matrix = dt.string_matrix
	touch(rtf_path)
	rtf_file = open(rtf_path,"w")
	write(rtf_file,"{\\rtf1\\ansi\\deff0")
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
	close(rtf_file)
	return 
end

