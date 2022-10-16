function add_footer(dt,footer;font = Nothing(),font_size = Nothing())
	dt.global_properties["footer"] = footer

	if !isnothing(font)
		dt.global_properties["font"] = font
	end
	if !isnothing(font_size)
		dt.global_properties["font_size"] = font_size
	end
	return dt
end

function get_footer(dt)
	ret = ""
	if "font" in keys(dt.global_properties)
		ret = ret * "b
end
