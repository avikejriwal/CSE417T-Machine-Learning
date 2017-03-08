function BDT=boosttree(X,y,nt,maxdepth)
% function BDT=boosttree(x,y,nt,maxdepth)
%
% Learns a boosted decision tree on data X with labels y.
% It performs at most nt boosting iterations. Each decision tree has maximum depth "maxdepth".
%
% INPUT:
% X  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees (default = 100)
% maxdepth | depth of each tree (default = 3)
%
% OUTPUT:
% BDT | Boosted DTree
%


%% fill in code here

[d,n] = size(X);

if nargin < 4
    maxdepth = 3;
end
if nargin < 3
    nt = 100;
end

BDT = cell([2 nt]);

w = ones([1 n])./n;

K = length(unique(y));

for t = 1:nt
    T = id3tree(X,y,maxdepth,w);
    e = sum(w(y ~= evaltree(T,X)));
    if (e <= 0 || e >= (1-1/K))
        return;
    end
    a = 1/2*log((1-e)/e) + log(K-1);
    yPred = evaltree(T,X);
    posRes = (yPred == y);
    negRes = (yPred ~= y);
    %Z = 2*sqrt(e*(1-e));
    Z = 1;
    w(posRes) = w(posRes)*exp(-a)/Z;
    w(negRes) = w(negRes)*exp(a)/Z;
    w = w./sum(w);
    BDT{1, t} = a;
    BDT{2, t} = T;
end
