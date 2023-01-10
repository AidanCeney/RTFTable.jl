df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
@testset "dict_matrix_error" begin
    @test_throws ErrorException("rows argument can not have values greater than number of rows") RTFTable.set_bold!(dt,rows = 6)
    @test_throws ErrorException("rows argument can not have values greater than number of rows") RTFTable.set_bold!(dt,rows = [1,2,3,4,5,6])
    @test_throws ErrorException("cols argument can not have values greater than number of columns") RTFTable.set_bold!(dt,cols = 6)
    @test_throws ErrorException("cols argument can not have values greater than number of columns") RTFTable.set_bold!(dt,cols = [1,2,3,4,5,6])
end;

@testset "getAll_error" begin
    @test_throws ErrorException("argument field 'Missing' does not exist in dict_matrix") RTFTable.getAll(dt.property_matrix,"Missing")
end;

@testset "fontsize_error" begin
    @test_throws ErrorException("font_size must be a factor of .5") RTFTable.set_font_size!(dt,20.2)
end;

@testset "alignment_error" begin
    @test_throws ErrorException("align must be one of the following: left, right, center, justify") RTFTable.set_alignment!(dt,"Error")
end;


@testset "border_error" begin
    @test_throws ErrorException("sides argument must be one of the following: b, l, t, r") RTFTable.set_borders!(dt,sides = "Error")
    @test_throws ErrorException("sides argument must be one of the following: b, l, t, r") RTFTable.set_borders!(dt,sides = ["l","Error"])
end;