
@testset "settings_onoff" begin
    jtable.set_property_default!("bold",true,"")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.property_matrix,"bold")
    @test all(aTest)
    jtable.delete_property_defaul!("bold")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.property_matrix,"bold")
    @test all(i -> i == false,aTest)
end;

@testset "settings_value" begin
    jtable.set_property_default!("fs",true,"22")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.value_matrix,"fs")
    @test all(i -> i == "22", aTest)
    jtable.delete_property_defaul!("fs")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.value_matrix,"fs")
    @test all(i -> i == "20", aTest)
end;





