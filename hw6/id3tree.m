function T=id3tree2(xTr,yTr,maxdepth,weights)
% function T=id3tree(xTr,yTr,maxdepth,weights)
%
% The maximum tree depth is defined by "maxdepth" (maxdepth=2 means one split).
% Each example can be weighted with "weights".
%
% Builds an id3 tree
%
% Input:
% xTr | dxn input matrix with n column-vectors of dimensionality d
% yTr | 1xn input matrix
% maxdepth = maximum tree depth
% weights = 1xn vector where weights(i) is the weight of example i
%
% Output:
% T = decision tree
%

%% fill in code here
[d,n] = size(xTr);

if nargin < 4
    weights = ones(1,n)./n;
end
if nargin < 3
    maxdepth = 10;
end

if maxdepth < inf
    q = 2^maxdepth;
end
    
T = zeros([6 q]);

rootNode = [0; 0; 0; 0; 0; 0];

[feature,cut,Hbest] = entropysplit(xTr, yTr, weights);

rootNode(1) = mode(yTr);
rootNode(2) = feature;
rootNode(3) = cut;
rootNode(4) = 2;
rootNode(5) = 3;

ind = 1;

Q = {};
Q{1,1} = xTr;
Q{1,2} = yTr;
Q{1,3} = ind;


while length(Q) > 0
    node = zeros([6 1]);
    xDat = Q{1,1};
    yDat = Q{1,2};
    ind = Q{1,3};
    
    [feature,cut,Hbest] = entropysplit(xDat, yDat, weights);
    
    %build the node
    node(1) = mode(yDat);
    node(2) = feature;
    node(3) = cut;
    node(4) = 0;
    node(5) = 0;
    node(6) = floor(ind/2);
    
    if feature > 0
        
        xLeft = (xDat(feature,:) <= cut);
        xRight = (xDat(feature,:) > cut);
        
        xDatLeft = xDat(:,xLeft);
        xDatRight = xDat(:,xRight);
        yDatLeft = yDat(:,xLeft);
        yDatRight = yDat(:,xRight);
        
        if (length(yDat) == length(yDatLeft) || length(yDatLeft) == 0)
            node(4) = 0;
            node(5) = 0;
        elseif floor(log2(ind)) > (maxdepth-1)
            node(4) = 0;
            node(5) = 0;
        else
            
            node(4) = 2*ind;
            node(5) = 2*ind+1;
            [n,~] = size(Q);
            Q{n+1,1} = xDatLeft;
            Q{n+1,2} = yDatLeft;
            Q{n+1,3} = 2*ind;
            
            Q{n+2,1} = xDatRight;
            Q{n+2,2} = yDatRight;
            Q{n+2,3} = 2*ind+1;
        end
    else
        node(2) = 0;
        node(3) = 0;
        node(4) = 0;
        node(5) = 0;
    end
    
    Q(1,:) = [];
    T(:,ind) = node;
end

end

