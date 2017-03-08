function [avg_acc,total,accs]=cart_tictoc(filename);
if exist('filename')~=1
    filename='heart';
end

load(['../data/',filename]); % assumes all datasets are stored in data


if min([yTr, yTe])<1
    yTr = yTr+1;
    yTe = yTe+1;
end

tic;
T=id3tree(xTr,yTr);
te=analyze('acc',yTe,evaltree(T,xTe));
tr=analyze('acc',yTr,evaltree(T,xTr));
tx=toc;
fprintf('Tree: Time: %2.2fs Training accuracy %2.2f, Testing accuracy %2.2f \n',tx,tr,te);
accs=[tr;te];

% make train /validation split
itr=ismember(1:length(yTr),randsample(1:length(yTr),ceil(0.8*length(yTr))));

tic;
T=prunetree(id3tree(xTr(:,itr),yTr(:,itr)),xTr(:,~itr),yTr(~itr));
te=analyze('acc',yTe,evaltree(T,xTe));
tr=analyze('acc',yTr,evaltree(T,xTr));
tp=toc;
fprintf('Pruned: Time: %2.2fs Training accuracy %2.2f, Testing accuracy %2.2f \n',tp,tr,te);
accs=[accs [tr;te]];


tic;
F=forest(xTr,yTr,50);
tr=analyze('acc',yTr,evalforest(F,xTr));
te=analyze('acc',yTe,evalforest(F,xTe));
tf=toc;
fprintf('Forest: Time: %2.2fs Training accuracy %2.2f, Testing accuracy %2.2f\n',tf,tr,te);
accs=[accs [tr;te]];


tic;
BDT=boosttree(xTr,yTr,25,4);
tr=analyze('acc',yTr,evalboost(BDT,xTr));
te=analyze('acc',yTe,evalboost(BDT,xTe));
tb=toc;
fprintf('Boost : Time: %2.2fs Training accuracy %2.2f, Testing accuracy %2.2f\n',tb,tr,te);
accs=[accs [tr;te]];

total=tx+tp+tf+tb;


if strcmp(filename,'iris') && total>10 
    fprintf('Your code is currently too slow.\n')
else
    if total>60
        fprintf('Your code is currently probably too slow.\n')
    end
end
avg_acc=mean(accs(2,:));
