df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
@testset "set_font_size!" begin
    RTFTable.set_font_size!(dt,20)
	aTest = RTFTable.getAll(dt.value_matrix,"fs")
    @test all(i -> i == "40",aTest)
end

@testset "set_font!" begin
    RTFTable.set_font!(dt,"Times",rows = 1)
	aTest = RTFTable.getAll(dt.value_matrix,"font")
    @test all(i -> i == "2",aTest[1,:])
    RTFTable.write_table(dt,tempdir() * "/set_font_test.rtf")
	result          = read(tempdir() * "/set_font_test.rtf", String)
	expected_result = read(project_path("test/man/set_font_test.rtf"),String)
    @test result == expected_result
end
@testset "set_align" begin
    RTFTable.set_alignment!(dt,"left")
	aTest = RTFTable.getAll(dt.property_matrix,"left_align")
    @test all(aTest)
    RTFTable.set_alignment!(dt,"right")
	aTest = RTFTable.getAll(dt.property_matrix,"right_align")
    @test all(aTest)
	aTest = RTFTable.getAll(dt.property_matrix,"left_align")
    @test all(i ->  i == false,aTest)
    RTFTable.set_alignment!(dt,"center")
	aTest = RTFTable.getAll(dt.property_matrix,"center_align")
    @test all(aTest)
	aTest = RTFTable.getAll(dt.property_matrix,"right_align")
    @test all(i ->  i == false,aTest)
    RTFTable.set_alignment!(dt,"justify")
	aTest = RTFTable.getAll(dt.property_matrix,"justify_align")
    @test all(aTest)
	aTest = RTFTable.getAll(dt.property_matrix,"center_align")
    @test all(i ->  i == false,aTest)
    RTFTable.set_alignment!(dt,"left")
	aTest = RTFTable.getAll(dt.property_matrix,"justify_align")
    @test all(i ->  i == false,aTest)
end

@testset "set_bold!" begin
    RTFTable.set_bold!(dt)
    aTest = RTFTable.getAll(dt.property_matrix,"bold")
    @test all(aTest)
end
@testset "set_italic!" begin
    RTFTable.set_italic!(dt)
    aTest = RTFTable.getAll(dt.property_matrix,"italic")
    @test all(aTest)
end

