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
include("test-table-mod.jl")

@testset "BasicTests" begin
	df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
	dt = RTFTable.make_data_table(df)
	RTFTable.set_borders!(dt)
	RTFTable.set_alignment!(dt,"center")
	RTFTable.set_italic!(dt,rows = 1)
	RTFTable.set_bold!(dt,rows = 1)
	RTFTable.write_table(dt, tempdir() * "/basic_test.rtf")
	result          = read(tempdir() * "/basic_test.rtf",String)
	expected_result = read(project_path("test/man/basic_test.rtf"),String)
	expected_result = replace(expected_result, "\r\n" => "\n") #Added for windows tests
	@test result == expected_result
end;

@testset "ModerateTests" begin
	df = DataFrame(Scale=["BAS-T","SR","BD1","ASRM","M-SRM"],High = ["42.15 (3.48)","20.36 (1.66)","5.14 (4.42)","6.39 (4.72)","13.20 (6.86)"],Moderate = ["23.45 (7.82)","18.29 (3.21)","9.76 (4.44)","20.48 (8.22)","12.88 (3.27)"],p = ["< .001","< .001",".120","348","< .001"])
	dt = RTFTable.make_data_table(df)
    RTFTable.set_borders!(dt,sides = ["b"],rows = [1,6])
 	RTFTable.set_borders!(dt,sides = ["t"],rows = [1])
	RTFTable.set_italic!(dt,rows = [2])
	RTFTable.set_font_color!(dt,blue = 255,cols = [2])
	RTFTable.add_footer!(dt,"This is an example footer")
	RTFTable.add_title!(dt,"A Title")
	RTFTable.write_table(dt, tempdir() * "/moderate_test.rtf")
	result          = read(tempdir() * "/moderate_test.rtf",String)
	expected_result = read(project_path("test/man/moderate_test.rtf"),String)
	expected_result = replace(expected_result, "\r\n" => "\n") #Added for windows tests
	@test result == expected_result
end;

@testset "AlignTests" begin
	df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
	dt = RTFTable.make_data_table(df)
	RTFTable.set_alignment!(dt,"left",rows = 1)
	RTFTable.set_alignment!(dt,"right",rows = 2)
	RTFTable.set_alignment!(dt,"center",rows = 3)
	RTFTable.set_alignment!(dt,"justify",rows = 4)
	RTFTable.write_table(dt, tempdir() * "/align_test.rtf")
	result          = read(tempdir() * "/align_test.rtf",String)
	expected_result = read(project_path("test/man/align_test.rtf"),String)
	expected_result = replace(expected_result, "\r\n" => "\n") #Added for windows tests
	@test result == expected_result
end