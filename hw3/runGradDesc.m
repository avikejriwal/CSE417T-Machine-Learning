clc
clear

labels = textread('clevelandtrain.csv', '%s', 1);
labels = strsplit(labels{1}, ',');

testSet = csvread('clevelandtest.csv',2);
x_test = testSet(:, 1:(end-1));
y_test = testSet(:,end);

trainSet = csvread('clevelandtrain.csv', 2);
x = trainSet(:, 1:(end-1));
y = trainSet(:,end);
y(y == 0) = -1;
y_test(y_test == 0) = -1;

%%

[m,n] = size(x);

for L = 1:n
    x(:,n) = zscore(x(:,n));
end

w_init = [0; rand([n 1])-0.5];

%{
w_init =  [0
   -0.0348
    0.4950
    0.4175
    0.0149
    0.0006
   -0.1746
    0.3283
   -0.0232
    0.4620
    0.2166
    0.0907
    0.8734
    0.6389];
%}


w_init = [0
   -0.0344
    0.3958
    0.4073
    0.0161
    0.0003
   -0.4062
    0.3293
   -0.0229
    0.5264
    0.2414
    0.0620
    0.8940
    0.6481];


%set the initial weight vector close to the local min to minimize total
%iteration time

eta = 12E-5;
max_its = 200000;

[w, e_in] = logistic_reg(x,y,w_init, max_its, eta);

class_train = find_test_error(w,x,y)
class_test = find_test_error(w,x_test,y_test);


%%
y(y == -1) = 0;
y_test(y_test == -1) = 0;


b = glmfit(x,[y 1*ones([length(y) 1])], 'binomial');

find_test_error(b,x,y)
