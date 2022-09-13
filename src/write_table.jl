
function write_table(dt,rtf_path)
	string_matrix = dt.string_matrix
	touch(rtf_path)
	rtf_file = open(rtf_path,"w")
	for i = 1:size(string_matrix,1) 
		write(rtf_file,"\n{\n")
		for j = 1:2
			for k = 1:size(string_matrix,2)
				write(rtf_file,string_matrix[i,k][j])
				write(rtf_file,"\n")
			end
		end
		write(rtf_file,"\\row\n}")
	end
	close(rtf_file)
	return 
end

