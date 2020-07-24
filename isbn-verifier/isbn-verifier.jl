struct ISBN <: AbstractString
    
    isbn::AbstractString

    function ISBN(isbn::AbstractString)

        isbn = replace(isbn, "-" => "")
        !isvalid(ISBN, isbn) && throw(ArgumentError("Invalid ISBN"))
        new(isbn)

    end
end

function isvalid(::Type{ISBN}, isbn::AbstractString)

    isbn = replace(isbn, "-" => "")

    length(isbn) != 10 && return false
    !occursin(r"\d{9}[\dXx]", isbn) && return false

    digits = parse.(Int, collect(filter(x -> isdigit(x), isbn)))

    if length(digits) == 9 && isbn[end] == 'X'
        push!(digits, 10)
    end

    return collect(10:-1:1)' * digits % 11 == 0

end

function string(s::ISBN)
    return s.isbn 
end

macro isbn_str(isbn)
    ISBN(isbn)
end
