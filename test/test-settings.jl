
@testset "settings" begin
    jtable.set_property_default("bold",true,"")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.property_matrix,"bold")
    @test all(aTest)
    jtable.delete_property_default("bold")
    df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
    dt = jtable.make_data_table(df)
	aTest = jtable.getAll(dt.property_matrix,"bold")
    @test all(i -> i == false,aTest)
end;


