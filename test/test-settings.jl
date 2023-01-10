
@testset "settings_constructive" begin
    RTFTable.set_property_default!("bold",true,"")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	aTest = RTFTable.getAll(dt.property_matrix,"bold")
    @test all(aTest)
    RTFTable.delete_property_defaul!("bold")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	aTest = RTFTable.getAll(dt.property_matrix,"bold")
    @test all(i -> i == false,aTest)
end;

@testset "settings_value" begin
    RTFTable.set_property_default!("fs",true,"22")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	aTest = RTFTable.getAll(dt.value_matrix,"fs")
    @test all(i -> i == "22", aTest)
    RTFTable.delete_property_defaul!("fs")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = RTFTable.make_data_table(df)
	aTest = RTFTable.getAll(dt.value_matrix,"fs")
    @test all(i -> i == "20", aTest)
end;





