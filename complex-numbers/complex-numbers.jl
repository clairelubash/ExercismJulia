import Base: +, -, *, /

struct ComplexNumber <: Number
    real
    imag
end

real(num::ComplexNumber) = num.real
imag(num::ComplexNumber) = num.imag

function +(x::ComplexNumber, y::ComplexNumber)
    ComplexNumber(x.real + y.real, x.imag + y.imag)
end

function -(x::ComplexNumber, y::ComplexNumber)
    ComplexNumber(x.real - y.real, x.imag - y.imag)
end

function *(x::ComplexNumber, y::ComplexNumber)
    ComplexNumber(x.real*y.real - x.imag*y.imag, x.imag*y.real + x.real*y.imag)
end

function /(x::ComplexNumber, y::ComplexNumber)
    numer1 = x.real*y.real + x.imag*y.imag
    numer2 = x.imag*y.real - x.real*y.imag
    denom = y.real^2 + y.imag^2

    denom == 0 && throw(DivideError())

    ComplexNumber(numer1 % denom == 0 ? div(numer1, denom) : numer1/denom, numer2 % denom == 0 ? div(numer2, denom) : numer2/denom)
end

function abs(x::ComplexNumber)
    sqrt(x.real^2 + x.imag^2)
end

function conj(x::ComplexNumber)
    ComplexNumber(x.real, -x.imag)
end

function Base.isapprox(x::ComplexNumber, y::ComplexNumber)
    isapprox(x.real, y.real) && isapprox(x.imag, y.imag)
end

function exp(x::ComplexNumber)
    ComplexNumber(exp(x.real) * cos(x.imag), exp(x.real) * sin(x.imag))
end

const jm = ComplexNumber(0, 1)
