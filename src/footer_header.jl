function add_footer_or_title(dt,footer, text, font, font_size)
    
    font = isnothing(font) ? dt.global_properties["fonts"][1] : font
    ncol = length(dt.property_matrix[1])
    row_pos = footer ? length(dt.property_matrix) : 0
    new_row = repeat([""],ncol)
    new_row[1] = text
    add_row(dt,new_row,position = row_pos)
    row_n = footer ? length(dt.property_matrix) : 1
    merge_cols(dt,rows = row_n)
    set_font(dt, font, rows = row_n)
    set_font_size(dt, font_size, rows = row_n)
    return 
end

function add_footer(dt, text; font = Nothing(),font_size = 20)
    add_footer_or_title(dt, true, text, font, font_size)
    return 
end

function add_title(dt, text; font = Nothing(),font_size = 28)
    add_footer_or_title(dt, false, text, font, font_size)
    return 
end