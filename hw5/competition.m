function preds=competition(xTr,yTr,xTe);
% function preds=competition(xTr,yTr,xTe);
%
% A classifier that outputs predictions for the data set xTe based on 
% what it has learned from xTr,yTr
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%

% The random classifier is awesome!!! Could you possibly do better?
%un=unique(yTr);
[d,n]=size(xTe);
%preds=randi(length(un),1,n);

%fill in the code here

kMax = 5;
acc = 0;
kBest = 2;

%{
for k = 1:kMax
    acc2 = analyze('acc', yTr,knnclassifier(xTr,yTr,xTr,k));
    if acc2 > acc
        kBest = k;
        acc = acc2;
    end
end
%}

preds = knnclassifier(xTr,yTr,xTe,kBest);