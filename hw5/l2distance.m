function D=l2distance(X,Z)
% function D=l2distance(X,Z)
%	
% Computes the Euclidean distance matrix. 
% Syntax:
% D=l2distance(X,Z)
% Input:
% X: dxn data matrix with n vectors (columns) of dimensionality d
% Z: dxm data matrix with m vectors (columns) of dimensionality d
%
% Output:
% Matrix D of size nxm 
% D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
%
% call with only one input:
% l2distance(X)=l2distance(X,X)
%

if (nargin==1) % case when there is only one input (X)
	%% fill in code here
    [d,n] = size(X);
    %G = X'*X;
    
    if d > 1
        S = ones(n,1)*sum(X.^2);
    elseif d == 1
        S = ones(n,1)*X.^2;
    end
    D = real((S + S' - 2*(X'*X)).^0.5);
    %in theory it's real anyways but might have negligible imaginary components due to rounding, etc.
    %D = D.*(abs(D)>1E-5); %filter out arbitrarily small values

else  % case when there are two inputs (X,Z)
	%% fill in code here
    [d,n] = size(X);
    [~,m] = size(Z);
    %G = X'*Z;
    
    if d > 1
        S = sum(X.^2)'*ones(1,m);
        R = ones(n,1)*sum(Z.^2);
    elseif d == 1
        S = (X.^2)'*ones(1,m);
        R = ones(n,1)*(Z.^2);
    end
    
    D = real((S + R - 2.*(X'*Z)).^0.5);

end;
%



