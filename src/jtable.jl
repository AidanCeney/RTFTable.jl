module jtable

import DataFrames, DataFramesMeta

struct mutable Data_Table
	df::DataFrames.AbstractDataFrame
	a::Int
 	b::Int
end

greet() = print("Hello World!")

end # module jtable
