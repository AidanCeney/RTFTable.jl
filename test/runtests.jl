using Test
using DataFrames
using jtable
using DataStructures

project_path(parts...) = normpath(joinpath(@__DIR__, "..", parts...))

include("test-dict-matrix.jl")
include("test-cell-properties.jl")
include("test-text-properties.jl")
include("test-title-footer.jl")
include("test-error.jl")

@testset "BasicTests" begin
	df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
	dt = jtable.make_data_table(df)
	jtable.set_borders!(dt)
	jtable.set_alignment(dt::jtable.DataTable,"center")
	jtable.set_italic(dt::jtable.DataTable,rows = 1)
	jtable.set_bold(dt::jtable.DataTable,rows = 1)
	jtable.write_table(dt::jtable.DataTable,"/tmp/basic_test.rtf")
	result          = read("/tmp/basic_test.rtf")
	expected_result = read(project_path("test/man/basic_test.rtf"))
	@test result == expected_result
end;
