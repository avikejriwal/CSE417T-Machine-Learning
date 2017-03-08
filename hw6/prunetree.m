function T=prunetree(T,xTe,y)
% function T=prunetree(T,xTe,y)
%
% Prunes a tree to minimal size such that performance on data xTe,y does not
% suffer.
%
% Input:
% T = tree
% xTe = validation data x (dxn matrix)
% y = labels (1xn matrix)
%
% Output:
% T = pruned tree
%

%% fill in code here

[d,n] = size(xTe);

[a q] = size(T);

for m = q:-1:2
    TNext = T;

    parent = T(6,m);
    if parent > 0
        if TNext(4,parent) == m
            TNext(4,parent) = 0;
        elseif TNext(5,parent) == m
            TNext(5,parent) = 0;
        end
    end
    if analyze('acc', y, evaltree(T,xTe)) <= analyze('acc',y,evaltree(TNext,xTe))
        T = TNext; %accept the change if it reduces the validation error
    end
end

