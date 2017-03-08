function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bound_minus_ni is the difference between the theoretical bound
%               and the actual number of iterations
%      (both the outputs should be num_samples long)

    for n = 1:num_samples
        w_star = [0 rand([1 d])]';
        train_set = 2*rand([d N])-1;
    
        output = sign(w_star(2:end,:)'*train_set);
 
        data = [train_set; output]';
        
        [w, iterations] = perceptron_learn(data);
        num_iters(n) = iterations;
        
        R = 0;
        p = 100;
        for m = 1:N
            if R < norm(train_set(:,m))
                R = norm(train_set(:,m));
            end
            if p > output(m)*(w*train_set(:,m))
                p = output(m)*(w*train_set(:,m));
            end
        end
        upperLim(n) = R^2*norm(w)^2/p^2;
        bounds(n) = upperLim(n) - iterations;    
    end
    
    figure(1)
    hist(num_iters)
    title('Histogram for PLA number of iterations')
    
    figure(2)
    hist(log10(bounds))
    title(['Histogram for logarithmic difference', 10, 'between number of iterations and theoretical bound']) 
    
end

