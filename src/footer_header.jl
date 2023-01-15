function add_footer_or_title(dt::RTFTable.DataTable,footer::Bool, text::String, font::Union{String,Nothing}, font_size::Int)
    
    font = isnothing(font) ? dt.global_properties["fonts"][1] : font
    ncol = length(dt.property_matrix[1])
    row_pos = footer ? length(dt.property_matrix) : 0
    new_row = repeat([""],ncol)
    new_row[1] = text
    add_row!(dt,new_row,position = row_pos)
    row_n = footer ? length(dt.property_matrix) : 1
    merge_cols!(dt,rows = row_n)
    set_font!(dt, font, rows = row_n)
    set_font_size!(dt, font_size, rows = row_n)
    return 
end


"""
	add_footer!(dt::RTFTable.DataTable, text; font::Union{String, Nothing} = Nothing(),font_size::Int = 8)

Adds a footer row to the provided `DataTable` which is a completly merge row at the bottom of the table.

# Arguments
- `dt`: Data Table to set.
- `text`: Text for the new footer. 
- `font`: font for the new footer's text.
- `font_size`: Font size for the new footer's text.
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_footer!(dt::RTFTable.DataTable,"My new FOOTER!",font = "Times",font_size = 10)
```
"""
function add_footer!(dt::RTFTable.DataTable, text; font::Union{String, Nothing} = Nothing(),font_size::Int = 8)
    add_footer_or_title(dt, true, text, font, font_size)
    return 
end
"""
	add_title!(dt::RTFTable.DataTable, text; font::Union{String, Nothing} = Nothing(),font_size::Int = 8)

Adds a title row to the provided `DataTable` which is a completly merge row at the top of the table.

# Arguments
- `dt`: Data Table to set.
- `text`: Text for the new title. 
- `font`: font for the new title's text.
- `font_size`: Font size for the new title's text.
# Example
```julia-repl
using DataFrames
using RTFTable
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_title!(dt::RTFTable.DataTable,"My new TITLE!",font = "Times",font_size = 14)
```
"""
function add_title!(dt::RTFTable.DataTable, text::String; font::Union{String, Nothing} = Nothing(),font_size::Int = 14)
    add_footer_or_title(dt, false, text, font, font_size)
    return 
end