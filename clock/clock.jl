import Base: +, -, ==, show
import Dates: Minute, value
using Printf

struct Clock

    hrs::Int
    mins::Int
    
    function Clock(hrs, mins)
        m = mod(mins, 60)
        h = mod(hrs + ((mins - m) / 60), 24)
        new(h, m)
    end

end

+(c::Clock, minute::Minute) = Clock(c.hrs, c.mins + value(minute))

-(c::Clock, minute::Minute) = Clock(c.hrs, c.mins - value(minute))

==(c::Clock, c2::Clock) = ((c.hrs == c2.hrs) && (c.mins == c2.mins))

show(io::IO, c::Clock) = @printf(io, "\"%02d:%02d\"", c.hrs, c.mins)