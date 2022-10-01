module jtable


project_path(parts...) = normpath(joinpath(@__DIR__, "..", parts...))

import DataFrames
import YAML
import PrettyTables
using  DataStructures

include("rtf_table.jl")
include("properties_matrix.jl")
include("string_matrix.jl")
include("table_properties.jl")
include("write_table.jl")
include("set_border.jl")
include("text_properties.jl")
include("cell_properties.jl")
include("table_mod.jl")
end
