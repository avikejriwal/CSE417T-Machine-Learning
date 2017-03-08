function preds=knnclassifier(xTr,yTr,xTe,k)
% function preds=knnclassifier(xTr,yTr,xTe,k);
%
% k-nn classifier 
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%


% output random result as default (you can erase this code)
[d,n]=size(xTe);
[d,ntr]=size(xTr);
if k>ntr,k=ntr;end;

%currently assigning random predictions
%un=unique(yTr);
%preds=un(ceil(rand(1,n)*length(un)));

% fill in code here

[ind, ~] = findknn(xTr, xTe, k);

preds = ones([1 n]);

for t = 1:n
    vecInt = yTr(ind(:,t));
    [predic, cnt] = mode(vecInt);
    preds(1,t) = predic;
    
    y2 = vecInt(vecInt ~= predic);
    cnt2 = -1;
    if ~isempty(y2)
        [~, cnt2] = mode(y2);
    end
    
    if cnt == cnt2
        preds(1,t) = knnclassifier(xTr,yTr,xTe(:,t),k-1);
    end
    
end   
%preds = preds;
