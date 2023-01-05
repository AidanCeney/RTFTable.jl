df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
@testset "merge_cols!" begin
	RTFTable.merge_cols!(dt::RTFTable.DataTable,rows = [1])
	aTest = RTFTable.getAll(dt.property_matrix,"clmrg")
    @test aTest[1,2]
	aTest = RTFTable.getAll(dt.property_matrix,"clmgf")
	@test aTest[1,1]
    @test !aTest[1,2]
end;

@testset "cell_width" begin
	RTFTable.set_cell_width!(dt::RTFTable.DataTable,1.0)
	aTest = RTFTable.getAll(dt.value_matrix,"cellx")
	@test aTest[1,1] == "1440"
	@test aTest[1,2] == "2880"
	RTFTable.set_cell_width!(dt::RTFTable.DataTable,[2.0, 4.0],rows = [2])
	aTest = RTFTable.getAll(dt.value_matrix,"cellx")
	@test aTest[2,1] == "2880"
	@test aTest[2,2] == "8640"
	RTFTable.set_cell_width!(dt::RTFTable.DataTable,2.0,rows = [2, 3],cols = [2])
	aTest = RTFTable.getAll(dt.value_matrix,"cellx")
	@test aTest[3,1] == "1440"
	@test aTest[3,2] == "4320"
	@test aTest[2,2] == "5760"
	RTFTable.set_cell_width!(dt::RTFTable.DataTable,2.0,rows = [4],cols = [1])
	aTest = RTFTable.getAll(dt.value_matrix,"cellx")
	@test aTest[4,1] == "2880"
	@test aTest[4,2] == "4320"
end