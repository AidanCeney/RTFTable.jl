
@testset "add_footer!" begin
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	RTFTable.add_footer!(dt::RTFTable.DataTable,"Test",font = "Times",font_size = 10)
	@test length(dt.property_matrix) == 6
	aTest = RTFTable.getAll(dt.value_matrix,"value")
    aTest = aTest[6,:]
    @test aTest == ["Test", ""]
	aTest = RTFTable.getAll(dt.property_matrix,"clmgf")
    aTest = aTest[6,:]
    @test aTest == [true, false]
	aTest = RTFTable.getAll(dt.property_matrix,"clmrg")
    aTest = aTest[6,:]
    @test aTest == [false, true]
	aTest = RTFTable.getAll(dt.value_matrix,"font")
    aTest = aTest[6,:]
    @test aTest == ["2", "2"]
	aTest = RTFTable.getAll(dt.value_matrix,"fs")
    aTest = aTest[6,:]
    @test aTest == ["20", "20"]
end;

@testset "add_title!" begin
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	RTFTable.add_title!(dt::RTFTable.DataTable,"Test",font = "Times",font_size = 10)
	@test length(dt.property_matrix) == 6
	aTest = RTFTable.getAll(dt.value_matrix,"value")
    aTest = aTest[1,:]
    @test aTest == ["Test", ""]
	aTest = RTFTable.getAll(dt.property_matrix,"clmgf")
    aTest = aTest[1,:]
    @test aTest == [true, false]
	aTest = RTFTable.getAll(dt.property_matrix,"clmrg")
    aTest = aTest[1,:]
    @test aTest == [false, true]
	aTest = RTFTable.getAll(dt.value_matrix,"font")
    aTest = aTest[1,:]
    @test aTest == ["2", "2"]
	aTest = RTFTable.getAll(dt.value_matrix,"fs")
    aTest = aTest[1,:]
    @test aTest == ["20", "20"]
end;

