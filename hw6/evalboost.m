function preds=evalboost(BDT,xTe);
% function preds=evalboost(BDT,xTe);
%
% Evaluates a boosted decision tree on a test set xTe.
%
% input:
% BDT | Boosted Decision Trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

%% fill in code here

[d, m] = size(xTe);

[a b] = size(BDT);

if size(BDT{2,1}) > 0
    yVals = unique(evaltree(BDT{2,1},xTe)); 
    %need to know the distinct labels to process the data
    %assume that:
    %1) the BDT has at least one valid decision tree
    %2) that tree contains every relevant label
end

tot = ones([length(yVals) m]);
preds = zeros([1 m]);

for t = 1:b
    T = BDT{2,t};
    if size(T) > 0
        for k = 1:length(yVals)
            tot(k,:) = tot(k,:) + BDT{1,t}*(evaltree(T, xTe) == yVals(k));
        end
    end
end

for n = 1:m
    maxInd = find(tot(:,n) == max(tot(:,n))); %return the yValue with the highest total sum
    preds(n) = yVals(maxInd);
end