function maxn=l2dist_tictoc(MAXTIME)
% function maxn=hw0tictoc()
% 
% Performs simple binary search to find how many distances can be computed within 1s.
% 
if nargin<1,
    MAXTIME=1
end;
more off; % put output immediately onto the screen
M=20;
times=zeros(1,M);
good=1;bad=0;
while 1,
    if bad==0,
        i=good*2;
    else,
        i=floor((bad+good)/2);
    end;
    fprintf('Testing %ix%i ...',i,i);
    tic;
    X=rand(100,i);
    D=l2distance(X,X);
    t=toc;
    fprintf(' done (%2.2fs)\n',t);
    if toc>MAXTIME,% too slow
        bad=i;
    else,
        good=i;
    end;
    if bad~=0 && good>=bad-1, break;end;
end;

fprintf('Your code can compute %ix%i=%i distances in less than %.2fs.\n',good,good,good*good,MAXTIME);
maxn=good;


