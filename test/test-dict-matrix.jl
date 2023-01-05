@testset "MakePropMatrix" begin
	propmatrix = RTFTable.make_property_matrix!(10,10)
	@test typeof(propmatrix[1][1]) == OrderedDict{String, Bool}
	@test length(propmatrix) == 10
	@test length(propmatrix[1]) == 10
end;

@testset "MakeValueMatrix" begin
	propmatrix = RTFTable.make_value_matrix!(10,10)
	@test typeof(propmatrix[1][1]) == OrderedDict{String, String}
	@test length(propmatrix) == 10
end

@testset "SetDictMatrix" begin
	propmatrix = RTFTable.make_property_matrix!(10,10)
	RTFTable.set_properties!(propmatrix,"Test",true,Nothing(),Nothing())
	aTest = RTFTable.getAll(propmatrix,"Test")
	@test all(aTest)
	RTFTable.set_properties!(propmatrix,"Test",false,Nothing(),Nothing())
	RTFTable.set_properties!(propmatrix,"Test",true,1,Nothing())
	aTest = RTFTable.getAll(propmatrix,"Test")
	@test all(aTest[1,:])
	RTFTable.set_properties!(propmatrix,"Test",false,Nothing(),Nothing())
	RTFTable.set_properties!(propmatrix,"Test",true,Nothing(),10)
	aTest = RTFTable.getAll(propmatrix,"Test")
	@test all(aTest[:,10])
	RTFTable.set_properties!(propmatrix,"Test",false,5,5)
	aTest = RTFTable.getAll(propmatrix,"Test")
	@test !aTest[5,5]

    valuematrix = RTFTable.make_value_matrix!(10,10)
	RTFTable.set_values!(valuematrix,"Test","Test",Nothing(),Nothing())
	aTest = RTFTable.getAll(valuematrix,"Test")
	@test all(i -> i == "Test",aTest)
	RTFTable.set_values!(valuematrix,"Test","Test2",1,Nothing())
	aTest = RTFTable.getAll(valuematrix,"Test")
	@test all(i -> i == "Test2",aTest[1,:])
	RTFTable.set_values!(valuematrix,"Test","Test3",Nothing(),10)
	aTest = RTFTable.getAll(valuematrix,"Test")
	@test all(i -> i == "Test3",aTest[:,10])
	RTFTable.set_values!(valuematrix,"Test","Test4",5,5)
	aTest = RTFTable.getAll(valuematrix,"Test")
	@test aTest[5,5] == "Test4"
end
