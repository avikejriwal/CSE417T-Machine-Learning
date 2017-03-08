function [ w iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for
    
    x = data_in(:,1:(end-1));
    y = data_in(:,end);
    t = 0;
    
    [nSamp, dim] = size(x);
    
    w_test = zeros([dim 1])';
    
    done = 0;
    
    while not(done)
        done = 1;
        for n = 1:nSamp
            h = sign(w_test*x');
            if h(n) ~= y(n)
                w_test2 = w_test + x(n,:)*y(n);
                done = 0;
            end
        end
        w_test = w_test2;
        t = t + 1;
    end
    w = w_test;
    iterations = t;
end

