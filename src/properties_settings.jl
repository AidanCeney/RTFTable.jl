function set_property_default!(property::String,constructive::Bool,value::String)
    @set_preferences!(property => [constructive,value])
end

function get_property_default_constructive(property::String)
    if !@has_preference(property)
        return Nothing()
    end
    return @load_preference(property)[1]
end

function get_property_default_value(property::String)
    if !@has_preference(property)
        return Nothing()
    end
    return @load_preference(property)[2]
end

function delete_property_defaul!(property::String)
    @delete_preferences!(property)
end