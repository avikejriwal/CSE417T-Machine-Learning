function [ train_set test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

    xTrain = 2*rand([N_train 1])-1;
    xTest = 2*rand([N_test 1])-1;
    
    n = 0:Q_f;
    scaling = sqrt(sum(1./(2*n+1)));
    
    yTrain = computeLegPoly(xTrain, Q_f)*scaling;
    yTest = computeLegPoly(xTest, Q_f)*scaling;
    
    yTrain = yTrain + sigma*normrnd(0,1,[length(yTrain),1]);
    
    train_set = [xTrain yTrain];
    test_set = [xTest yTest];

end

