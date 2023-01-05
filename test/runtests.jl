using Test
using DataFrames
using RTFTable
using DataStructures

project_path(parts...) = normpath(joinpath(@__DIR__, "..", parts...))

include("test-dict-matrix.jl")
include("test-cell-properties.jl")
include("test-text-properties.jl")
include("test-title-footer.jl")
include("test-error.jl")
include("test-settings.jl")

@testset "BasicTests" begin
	df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
	dt = RTFTable.make_data_table(df)
	RTFTable.set_borders!(dt)
	RTFTable.set_alignment!(dt,"center")
	RTFTable.set_italic!(dt,rows = 1)
	RTFTable.set_bold!(dt,rows = 1)
	RTFTable.write_table(dt,"/tmp/basic_test.rtf")
	result          = read("/tmp/basic_test.rtf")
	expected_result = read(project_path("test/man/basic_test.rtf"))
	@test result == expected_result
end;
