function set_property_default(property::String,onoff::Bool,value::String)
    @set_preferences!(property => [onoff,value])
end

function get_property_default_onoff(property::String)
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

function delete_property_default(property::String)
    @delete_preferences!(property)
end