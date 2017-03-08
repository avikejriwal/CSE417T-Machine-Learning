function [ test_error ] = find_test_error( w, X, y )
%FIND_TEST_ERROR Find the test error of a linear separator
%   This function takes as inputs the weight vector representing a linear
%   separator (w), the test examples in matrix form with each row
%   representing an example (X), and the labels for the test data as a
%   column vector (y). X does not have a column of 1s as input, so that 
%   should be added. The labels are assumed to be plus or minus one. 
%   The function returns the error on the test examples as a fraction. The
%   hypothesis is assumed to be of the form (sign ( [1 x(n,:)] * w )

%x = M*N
%w = N*1
%y = M*1

    [m n] = size(X);
    pad = ones([m 1]);
    
    h = [pad X]*w;
    
    y_test = sign(h);
   
    %sigm = exp(h)./(1 + exp(h));
    y_test2 = double(exp(h)./(1 + exp(h)) >= 0.5);
    y_test2(y_test2 == 0) = -1;
    
    test_error = sum(y_test2 ~= y)/length(y);
    

end

