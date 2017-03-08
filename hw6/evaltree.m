function [ypredict]=evaltree(T,xTe)
% function [ypredict]=evaltree(T,xTe);
%
% input:
% T0  | tree structure
% xTe | Test data (dxn matrix)
%
% output:
%
% ypredict : predictions of labels for xTe
%

%% fill in code here

[d,n] = size(xTe);
ypredict = zeros([1 n]);

for m = 1:n
    fin = false;
    currentNode = T(:,1);
    while ~fin
        nextNode = currentNode;
        if currentNode(4,1) == 0 && currentNode(5,1) == 0
            ypredict(m) = currentNode(1,1);
            fin = true;
        elseif currentNode(2,1) > 0
            if xTe(currentNode(2,1),m) <= currentNode(3,1)
                if currentNode(4,1) == 0
                    ypredict(m) = currentNode(1,1);
                    fin = true;
                else
                    nextNode = T(:,currentNode(4,1));
                end
            elseif xTe(currentNode(2,1),m) >= currentNode(3,1)
                if currentNode(5,1) == 0
                    ypredict(m) = currentNode(1,1);
                    fin = true;
                else
                    nextNode = T(:,currentNode(5,1));
                end
            end
        end
        currentNode = nextNode;
    end    
end