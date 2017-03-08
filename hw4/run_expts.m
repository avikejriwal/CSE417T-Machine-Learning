%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.
clc
clear

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_mat = zeros(length(Q_f), length(N), length(var));
expt_data_mat2 = zeros(length(Q_f), length(N), length(var));

num_expts = 500;
n = 0;

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            err_dat = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),num_expts);
            expt_data_mat(ii,jj,kk) = median(err_dat);
            expt_data_mat2(ii,jj,kk) = mean(err_dat);
            n = n+1
        end
    end
    
    fprintf('.');
end

expt_data_mat2 - expt_data_mat

%%

figure(1)
plot(Q_f, expt_data_mat(:,1,1), 'r')
hold on
plot(Q_f, expt_data_mat2(:,1,1), 'g')
plot(Q_f, expt_data_mat(:,2,1), 'b')
plot(Q_f, expt_data_mat2(:,2,1), 'y')
plot(Q_f, expt_data_mat(:,3,1), 'm')
plot(Q_f, expt_data_mat2(:,3,1), 'k')
hold off
xlabel('True polynomial order Q_f')
ylabel('overfit measure')
legend('median overfit, N = 40', 'mean overfit, N = 40', 'median overfit, N = 80', 'mean overfit, N =80', 'median overfit, N=120', 'mean overfit, N=120')
title('Testing overfit versus Q_f and N')

figure(2)
expt_med = zeros(size(var));
expt_mean = zeros(size(var));

for n = 1:length(var)
    expt_med(n) = expt_data_mat(1,1,n);
    expt_mean(n) = expt_data_mat2(1,1,n);
end

plot(var, log(expt_med+1), 'r')
hold on
plot(var, log(expt_mean+1), 'g')
xlabel('stochastic noise variance')
title('Overfit as a function of stochastic noise variance)')
ylabel('Overfit measure (log scale)')
legend('median overfit', 'mean overfit')
hold off
