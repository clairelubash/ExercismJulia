mutable struct CircularBuffer{T} <: AbstractVector{T}

	data::Vector{T}
	idx::Int
	size::Int

    function CircularBuffer{T}(capacity::Integer) where {T}
    	new(Vector{T}(undef, capacity), 1, 0)
    end

end

Base.size(cb::CircularBuffer) = cb.size
Base.isempty(cb::CircularBuffer) = size(cb) == 0
capacity(cb::CircularBuffer) = length(cb.data)
isfull(cb::CircularBuffer) = size(cb) == capacity(cb)
Base.mod(I, cb::CircularBuffer) = (I - 1) % capacity(cb) + 1

function Base.push!(cb::CircularBuffer, item; overwrite::Bool = false)

	size(cb) + 1 <= capacity(cb) || (!overwrite && throw(BoundsError()))
    cb.data[mod(cb.idx + size(cb), cb)] = item
    
	if size(cb) == capacity(cb)
		cb.idx = mod(cb.idx + 1, cb)
	else
		cb.size += 1
    end
    
    return cb
    
end

function Base.popfirst!(cb::CircularBuffer)

	!isempty(cb) || throw(BoundsError())
	ans = cb.data[cb.idx]
	cb.idx = mod(cb.idx + 1, cb)
	cb.size -= 1
    return ans
    
end

function Base.empty!(cb::CircularBuffer)
    
	cb.size = 0
    return cb
    
end