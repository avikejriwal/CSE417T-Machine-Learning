function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2
    
    for k = 1:num_expts
        k
        [train_set, test_set] = generate_dataset(true_Q_f, N_train, N_test, sqrt(var));
        trainVec10 = zeros([N_train,11]);
        trainVec2 = zeros([N_train,3]);
        
        testVec10 = zeros([N_test,11]);
        testVec2 = zeros([N_test,3]);
        
        for n = 1:11
            trainVec10(:,n) = train_set(:,1).^(n-1);
            testVec10(:,n) = test_set(:,1).^(n-1);
        end

        for n = 1:3
            trainVec2(:,n) = train_set(:,1).^(n-1);
            testVec2(:,n) = test_set(:,1).^(n-1);
        end
    
        g10 = glmfit(trainVec10, train_set(:,2), 'normal', 'constant', 'off');
        g2 = glmfit(trainVec2, train_set(:,2), 'normal', 'constant', 'off');
    
        eOut_10 = sum((testVec10*g10 - test_set(:,2)).^2)/N_test;
        eOut_2 = sum((testVec2*g2 - test_set(:,2)).^2)/N_test;
    
        overfit_m(k) = eOut_10 - eOut_2;
    end

end

