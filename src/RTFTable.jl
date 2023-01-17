module RTFTable

export merge_cols!,set_cell_width!,DataTable,make_data_table,add_footer!,add_title!,set_property_default!,
       get_property_default_constructive,get_property_default_value,delete_property_defaul!,
       set_borders!,update_string_matrix!,add_df!,add_row!,add_col!,set_font_size!,set_font!,
       set_alignment!,set_bold!,set_italic!,set_font_color!,write_table

project_path(parts...) = normpath(joinpath(@__DIR__, "..", parts...))
inch_twip_ratio = 1440

import DataFrames
import YAML
import PrettyTables
using  DataStructures
using Preferences

include("properties_settings.jl")
include("datatable.jl")
include("properties_matrix.jl")
include("string_matrix.jl")
include("table_properties.jl")
include("write_table.jl")
include("set_border.jl")
include("text_properties.jl")
include("cell_properties.jl")
include("table_mod.jl")
include("footer_header.jl")
end
