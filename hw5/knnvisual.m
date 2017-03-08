function knnvisual(dataset,k,r)

%% Visual interface for homework 0
%% Performing k-nearest neighbor classification on digits
%%

flip=@(M) M;
%flip=@(M) flipud(M);


%% set parameters
if nargin<1,dataset='digits',end;
if nargin<2,k=3,end;
if nargin<3,r=4,end;
%k=3; % number of nearest neighbors
%r=5; % number of rows in display
%dataset='faces'; 
%dataset='digits';

%% load data
% HANDWRITTEN DIGIT RECOGNITION
switch dataset
case 'digits'
	load('../data/digits');
	dx=16;
	dy=16;

% FACE IDENTIFICATION
case 'faces'
	load('../data/faces');
	dx=31;
	dy=38;
end;

%% Set number of training examples
ntr=length(yTr); % number of training data points (Must be smaller than length(yTr))
% ntr=100;
xTr=xTr(:,1:ntr);
  


%% Initialization
% create new figure
figure(1);
clf;
c=k+1; % number of columns (function of k)



for i=1:r*c
 subplot(r,c,i);
 M(i).image=imagesc(zeros(dy,dx));
 colormap gray;
 as=axis();
% T(i)=text((as(4)-as(3))/2,(as(2)-as(1))/2,[' ' num2str(i)],'FontSize',18,'FontWeight','bold','FontName','Times','Color',[0,1,1]);
 T(i)=text(5,0,[' ' num2str(i)],'FontSize',18,'FontWeight','bold','FontName','Times','Color',[0,1,1],'VerticalAlignment','top');
 set(gca,'XTick',[],'YTick',[],'FontWeight','bold');
 S(i)=gca;
 if i>k*r+1,
  xlabel(['Neighbor ' num2str(i-k*r-1)]);
 end;
 if i==k*r+1,
     xlabel('TEST');
 end;
end;


% do the classification
for n=1:r:length(yTe) % iterate over test points
	for nj=1:r
		ex=n+nj-1;
		% draw the new test image
		set(M((nj-1)*c+1).image,'CData',flip(reshape(xTe(:,ex),dy,dx)));
		set(get(S((nj-1)*c+1),'Ylabel'),'String',num2str(yTe(ex)),'FontWeight','bold');
		% draw k-nearest neighbors
        
        [b h] = size(xTr);
        shuffle = randperm(h); % Shuffle the training data
		
        inds=findknn(xTr(:,shuffle),xTe(:,ex),k);
		for m=1:k
			set(M((nj-1)*c+1+m).image,'CData',flip(reshape(xTr(:,inds(m)),dy,dx)));
			set(T((nj-1)*c+1+m),'String',num2str(yTr(inds(m))));
		end;
		% set classification accuracy
		pred=knnclassifier(xTr,yTr,xTe(:,ex),k);
		set(T((nj-1)*c+1),'String',num2str(pred));
		if pred==yTe(ex),set(T((nj-1)*c+1),'Color',[0 1 0]); else,set(T((nj-1)*c+1),'Color',[1 0 0]);end;
	 end;
		drawnow;
	pause;
end;
