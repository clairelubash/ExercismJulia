function rotate(shift, input)
    return map(char -> rotate(shift, char), input)
end

function rotate(shift, char::Char)
    if char in 'a':'z'
        'a' + (char + shift - 'a') % 26
    elseif char in 'A':'Z'
        'A' + (char + shift - 'A') % 26
    else
        char
    end
end


## Bonus A

macro R13_str(input::String)
    rotate(13, input)
end

## Bonus B

for i in 0:26
    name = Symbol("R", i, "_str")
    @eval macro $name(input::String)
        rotate($i, input)
    end
end

