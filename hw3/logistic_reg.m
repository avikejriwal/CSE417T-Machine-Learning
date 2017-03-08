function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

    [N M] = size(X);
    
    grad = zeros([N M]);
    
    w(:,1) = w_init;
    
    for t = 1:max_its
        for n = 1:N
            grad(n,1:M) = -1/N*y(n)*X(n,:)/(1 + exp(y(n)*[1 X(n,:)]*w(:,1)));
        end
        gradSum = sum(grad);
        mean(abs(gradSum))*1000
        if mean(abs(gradSum)) <= 1E-6 %terminate the algorithm
            t %get the number of iterations
            break;
        end
        %[0 gradSum]'
        w(:, 1) = w(:, 1) - eta*[0 gradSum]';
    end
    
    e = 0;
    for n = 1:N
        e = e + log(1 + exp(-y(n)*[1 X(n,:)]*w));
    end
    e_in = e/N;
    
    
end

