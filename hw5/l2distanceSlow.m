function D=l2distanceSlow(X,Z)
% function D=l2distanceSlow(X,Z)
%	
% Computes the Euclidean distance matrix. 
% Syntax:
% D=l2distanceSlow(X,Z)
% Input:
% X: dxn data matrix with n vectors (columns) of dimensionality d
% Z: dxm data matrix with m vectors (columns) of dimensionality d
%
% Output:
% Matrix D of size nxm 
% D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
%
%

[d,n]=size(X); % dimension of X
[~,m]=size(Z); % number of input vectors in Z
D=zeros(n,m); % allocate memory for the output matrix
for i=1:n % loop over vectors in X
	for j=1:m % loop over vectors in Z
		D(i,j)=0.0; 
		for k=1:d % loop over dimensions
			D(i,j)=D(i,j)+(X(k,i)-Z(k,j))^2; % compute l2-distance between the ith and jth vector
		end;
		D(i,j)=sqrt(D(i,j)); % take square root
	end;
end;

