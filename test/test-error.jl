df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = jtable.make_data_table(df)
@testset "dict_matrix_error" begin
    @test_throws ErrorException("rows argument can not have values greater than number of rows") jtable.set_bold!(dt,rows = 6)
    @test_throws ErrorException("rows argument can not have values greater than number of rows") jtable.set_bold!(dt,rows = [1,2,3,4,5,6])
    @test_throws ErrorException("cols argument can not have values greater than number of columns") jtable.set_bold!(dt,cols = 6)
    @test_throws ErrorException("cols argument can not have values greater than number of columns") jtable.set_bold!(dt,cols = [1,2,3,4,5,6])
end;

@testset "getAll_error" begin
    @test_throws ErrorException("argument field 'Missing' does not exist in dict_matrix") jtable.getAll(dt.property_matrix,"Missing")
end;

@testset "fontsize_error" begin
    @test_throws ErrorException("font_size must be a factor of .5") jtable.set_font!_size!(dt,20.2)
end;

@testset "alignment_error" begin
    @test_throws ErrorException("align must be one of the following: left, right, center, justify") jtable.set_alignment!(dt,"Error")
end;


@testset "border_error" begin
    @test_throws ErrorException("sides argument must be one of the following: b, l, t, r") jtable.set_borders!(dt,sides = "Error")
    @test_throws ErrorException("sides argument must be one of the following: b, l, t, r") jtable.set_borders!(dt,sides = ["l","Error"])
end;