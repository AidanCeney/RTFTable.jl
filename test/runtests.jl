using Test
using DataFrames
using jtable
using DataStructures
include("test-dict-matrix.jl")
include("test-cell-properties.jl")
@testset "BasicTests" begin
	project_path(parts...) = normpath(joinpath(@__DIR__, "..", parts...))
	df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
	dt = jtable.make_data_table(df)
	jtable.set_borders!(dt)
	jtable.set_alignment(dt,"center")
	jtable.set_italic(dt,rows = 1)
	jtable.set_bold(dt,rows = 1)
	jtable.write_table(dt,"/tmp/basic_test.rtf")
	result          = read("/tmp/basic_test.rtf")
	expected_result = read(project_path("test/man/basic_test.rtf"))
	@test result == expected_result
end;
