function matching_brackets(input)

    d = Dict('(' => ')', '{' => '}', '[' => ']')
    stack = []

    for i ∈ input
        if i ∈ keys(d)
            push!(stack, i)
        elseif i ∈ values(d)
            if (isempty(stack) || (d[pop!(stack)] != i))
                return false
            end
        end
    end

    return isempty(stack)

end