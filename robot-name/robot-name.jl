using Random: shuffle!
using Base.Iterators: product

mutable struct Robot
    name::String
    function Robot()
        new(new_name())
    end
end

const names_list = let x = 'A':'Z', y = '0':'9'
    shuffle!(vec(join.(product(x, x, y, y, y))))
end

function new_name()
    isempty(names_list) ? error("There are no more unique robot names") : pop!(names_list)
end

function reset!(instance::Robot)
    instance.name = new_name()
    return instance
end

function name(instance::Robot)
    return instance.name
end