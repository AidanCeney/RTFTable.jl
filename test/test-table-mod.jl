@testset "add_df!_pos" begin
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df,position = 3)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B";
            "1"  "M";
            "2"  "F";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M";
            "3"  "F";
            "4"  "M";]
@test aTest == expected
df2 = DataFrame(A=1:5,B = ["A","M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df2,rowwise = false,position = 1)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "1" "A" "B";
            "1"  "2" "M" "M";
            "2"  "3" "F" "F";
            "3"  "4" "F" "F";
            "4"  "5" "M" "M";]
@test aTest == expected
aTest = RTFTable.getAll(dt.value_matrix,"cellx")
expected = ["2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";]
@test aTest == expected
end;

@testset "add_df!" begin
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M"]
@test aTest == expected
df2 = DataFrame(A=1:5,B = ["A","M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df2,rowwise = false)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B" "1"  "A";
            "1"  "M" "2"  "M";
            "2"  "F" "3"  "F";
            "3"  "F" "4"  "F";
            "4"  "M" "5"  "M";]
@test aTest == expected
aTest = RTFTable.getAll(dt.value_matrix,"cellx")
expected = ["2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";]
@test aTest == expected
end;

@testset "add_df!_without_header" begin
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df,header = true)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M";
            "A"  "B";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M"]
@test aTest == expected
df2 = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_df!(dt,df2,header = true,rowwise = false)
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B" "A"  "B";
            "1"  "M" "1"  "M";
            "2"  "F" "2"  "F";
            "3"  "F" "3"  "F";
            "4"  "M" "4"  "M";]
@test aTest == expected
aTest = RTFTable.getAll(dt.value_matrix,"cellx")
expected = ["2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";
            "2340"  "4680" "7020"  "9360";]
@test aTest == expected
end;

@testset "add_row!" begin
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_row!(dt,["A","B"])
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B";
            "1"  "M";
            "2"  "F";
            "3"  "F";
            "4"  "M";
            "A"  "B";]
@test aTest == expected
end;

@testset "add_col!" begin
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
RTFTable.add_col!(dt,["A","1","2","3","4"])
aTest = RTFTable.getAll(dt.value_matrix,"value")
expected = ["A"  "B" "A";
            "1"  "M" "1";
            "2"  "F" "2";
            "3"  "F" "3";
            "4"  "M" "4";]
@test aTest == expected
end;