function preds=evalforest(F,xTe)
% function preds=evalforest(F,xTe);
%
% Evaluates a random forest on a test set xTe.
%
% input:
% F   | Forest of decision trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%



%% fill in code here

nt = length(F);

[d,m] = size(xTe);

ypred = zeros([nt m]);
for t = 1:nt
    T = F{t};
    ypred(t,:) = evaltree(T,xTe);
end
preds = mode(ypred);