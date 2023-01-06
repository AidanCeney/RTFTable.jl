# RTFTable

The `RTFTable` package provides a easy way to convert julia `DataFrames` into publication ready tables in the `rtf` format. Start by generating a `DataTable` struct by providing a `DataFrame` to `make_data_tabl()`. After this you are free to modify the table with various table settings such as font with `set_font!()`, borders with `set_borders!()`, alignment with `set_alignment!()`, etc. Once all settings have been set write the `DataTable` to a `rtf` file using the `write_table()` function. `RTFTable` uses the `Preferences` package to allow users to set default table settings by ussing the `set_property_default!()` function. This can be very usefull if there is always a praticular setting you want set for evrey table generated. Finally if there is any rtf feature that was not implemented by `RTFTable` the package has been setup to be easily programatically manipulated by the user. The basic text output of the table is stored in the `string_matrix` field of the `DataTable` struct. To manualy update it after setting have been set run the `update_string_matrix!()` function. Once the `string_matrix` has been edited you can generate the `rtf` using the `write_table()` function with `update` argument set to `false`.

```julia
    using DataFrames
    using RTFTable
	df = DataFrame(Scale=["BAS-T","SR","BD1","ASRM","M-SRM"],High = ["42.15 (3.48)","20.36 (1.66)","5.14 (4.42)","6.39 (4.72)","13.20 (6.86)"],Moderate = ["23.45 (7.82)","18.29 (3.21)","9.76 (4.44)","20.48 (8.22)","12.88 (3.27)"],p = ["< .001","< .001",".120","348","< .001"])
	dt = RTFTable.make_data_table(df)
    RTFTable.set_borders!(dt,sides = ["b"],rows = [1,6])
 	RTFTable.set_borders!(dt,sides = ["t"],rows = [1])
	RTFTable.set_italic!(dt,rows = [2])
	RTFTable.set_font_color!(dt,blue = 255,cols = [2])
	RTFTable.add_footer!(dt,"This is an example footer")
	RTFTable.add_title!(dt,"A Title")
	RTFTable.write_table(dt,"example.rtf")
```