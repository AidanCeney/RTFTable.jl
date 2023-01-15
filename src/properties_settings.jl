"""
	set_property_default!(property::String,constructive::Bool,value::String)

Sets the default properties for a new  `DataTable` using the `Preferences` package. These defaults are stored with the package information so they do not need to be reset with new julia instances.

# Arguments
- `property`: A string naming the property set default for.
- `constructive`: When `true` property will be set by default, when `false` the property will be turned off by default. 
- `value`: The default value to set for a property that needs a value. When value is not needed set to "". 
# Example
```julia-repl
using DataFrames
using RTFTable
RTFTable.set_property_default!("bold",true,"")
df = DataFrame(A=1:4,B = ["M", "F", "F", "M"])
dt = RTFTable.make_data_table(df)
```
"""
function set_property_default!(property::String,constructive::Bool,value::String)
    @set_preferences!(property => [constructive,value])
end
"""
	get_property_default_constructive(property::String)

Gets the default constructive properties for a new  `DataTable` using the `Preferences` package.

# Arguments
- `property`: A string naming the property to get defaults for.
```julia-repl
using DataFrames
using RTFTable
RTFTable.set_property_default!("bold",true,"")
RTFTable.get_property_default_constructive("bold")
```
"""
function get_property_default_constructive(property::String)
    if !@has_preference(property)
        return Nothing()
    end
    return @load_preference(property)[1]
end
"""
	get_property_default_value(property::String)

Gets the default property value for a new  `DataTable` using the `Preferences` package.

# Arguments
- `property`: A string naming the property to get defaults for.
```julia-repl
using DataFrames
using RTFTable
RTFTable.set_property_default!("bold",true,"")
RTFTable.get_property_default_value("bold")
```
"""
function get_property_default_value(property::String)
    if !@has_preference(property)
        return Nothing()
    end
    return @load_preference(property)[2]
end
"""
	delete_property_defaul!(property::String)

Deletes the default property for a new  `DataTable` using the `Preferences` package.

# Arguments
- `property`: A string naming the property to get defaults for.
```julia-repl
using DataFrames
using RTFTable
RTFTable.set_property_default!("bold",true,"")
RTFTable.delete_property_default!("bold")
```
"""
function delete_property_defaul!(property::String)
    @delete_preferences!(property)
end