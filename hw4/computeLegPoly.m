function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated atthe corresponding x value in the input

z = zeros(size(x));
if Q==5 %hardcode to improve runtime by avoiding recursion
    z = 1/8*(63*x.^5 - 70*x.^3 + 15*x);
elseif Q==10
    z = 1/256*(46189*x.^10 - 109395*x.^8 + 90090*x.^6 - 30030*x.^4 + 3465*x.^2 - 63);
elseif Q==15
elseif Q==0
    z = ones(size(x));
elseif Q==1
    z = x;
elseif Q > 1
    z = ((2*Q-1)*x.*computeLegPoly(x,Q-1) - (Q-1)*computeLegPoly(x,Q-2))/(Q);
end





end

