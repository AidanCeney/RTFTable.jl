
@testset "add_footer" begin
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	jtable.add_footer(dt,"Test",font = "Times",font_size = 10)
	@test length(dt.property_matrix) == 6
	aTest = jtable.getAll(dt.value_matrix,"value")
    aTest = aTest[6,:]
    @test aTest == ["Test", ""]
	aTest = jtable.getAll(dt.property_matrix,"clmgf")
    aTest = aTest[6,:]
    @test aTest == [true, false]
	aTest = jtable.getAll(dt.property_matrix,"clmrg")
    aTest = aTest[6,:]
    @test aTest == [false, true]
	aTest = jtable.getAll(dt.value_matrix,"font")
    aTest = aTest[6,:]
    @test aTest == ["2", "2"]
	aTest = jtable.getAll(dt.value_matrix,"fs")
    aTest = aTest[6,:]
    @test aTest == ["20", "20"]
end;

@testset "add_header" begin
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	jtable.add_title(dt,"Test",font = "Times",font_size = 10)
	@test length(dt.property_matrix) == 6
	aTest = jtable.getAll(dt.value_matrix,"value")
    aTest = aTest[1,:]
    @test aTest == ["Test", ""]
	aTest = jtable.getAll(dt.property_matrix,"clmgf")
    aTest = aTest[1,:]
    @test aTest == [true, false]
	aTest = jtable.getAll(dt.property_matrix,"clmrg")
    aTest = aTest[1,:]
    @test aTest == [false, true]
	aTest = jtable.getAll(dt.value_matrix,"font")
    aTest = aTest[1,:]
    @test aTest == ["2", "2"]
	aTest = jtable.getAll(dt.value_matrix,"fs")
    aTest = aTest[1,:]
    @test aTest == ["20", "20"]
end;

