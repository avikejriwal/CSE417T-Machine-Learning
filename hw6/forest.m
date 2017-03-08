function F=forest(X,y,nt)
% function F=forest(x,y,nt)
%
% INPUT:
% X  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees
%
% OUTPUT:
% F | Forest
%

%% fill in code here
[d,n] = size(X);

F = cell([nt 1]); %builds trees in a cell array

for m = 1:nt
    samps = randsample(n, n,true);    
    T = id3tree(X(:,samps),y(samps),4);
    F{m} = T;
end

