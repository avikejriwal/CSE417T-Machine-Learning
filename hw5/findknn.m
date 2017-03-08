function [indices,dists]=findknn(xTr,xTe,k);
% function [indices,dists]=findknn(xTr,xTe,k);
%
% Finds the k nearest neighbors of xTe in xTr.
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
% 
% Output:
% indices = kxm matrix, where indices(i,j) is the i^th nearest neighbor of xTe(:,j)
% dists = Euclidean distances to the respective nearest neighbors
%

% output random results, please erase this code
[d,ntr]=size(xTr);
[d,nte]=size(xTe);
%indices=ceil(rand(k,nte)*ntr);
%dists=rand(k,nte);
if k>ntr,k=ntr;end;



%% fill in code here
distTr = l2distance(xTr, xTe);

I = zeros(k, nte);
D = zeros(k,nte);

for s = 1:k
    [minVal, indx] = min(distTr);
    I(s,:) = indx;
    D(s,:) = minVal;
    for n = 1:nte
        distTr(indx(n),n) = inf; %set the distance to infinity
    end
end
        
indices = I;
dists = D;


	
%%	%
	
