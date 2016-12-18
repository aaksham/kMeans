X=csvread('kmeans_data.csv');
K=5;
max_iters=50;
runs=15;

[m n] = size(X);
idx = zeros(m, 1);
objfnvals=zeros(runs,max_iters);
minobjfn=0;
mincentroids=0;
time=cputime;
colors=[169 5 71 ; 79 71 73 ; 228 2 107 ; 30 139 92 ; 15 80 245 ; 80 140 173 ; 98 167 28 ; 
242 30 50 ; 229 75 41 ; 32 175 3 ; 207 2 136 ; 
189 52 6 ; 73 109 81 ; 107 50 101 ; 60 1 23 ;]./255;
close all;figure;
for run=1:runs
    randidx=randperm(size(X,1));
    centroids=X(randidx(1:K),:);
    fprintf('run: %d ', run);
	for i=1:max_iters
% 		fprintf('K-Means iteration %d/%d %d...\n', i, max_iters,run);
		if exist('OCTAVE_VERSION')
			fflush(stdout);
		end
		
		idx = findClosestCentroids(X, centroids);
		objfn=0;
		for j=1:m
			d=X(j,:)-centroids(idx(j),:);
			dist=sum(d.*d);
			objfn=objfn+dist;
		end
		objfnvals(run,i)=objfn;
% 		fprintf('%d\n', objfn);
		if exist('OCTAVE_VERSION')
			fflush(stdout);
        end
		centroids = computeCentroids(X, idx, K);
	end
	
	if run==1
		minobjfn=objfnvals(run,i);
		mincentroids=centroids;
	else
		if objfnvals(run,i)<minobjfn
			minobjfn=objfnvals(run,i);
			mincentroids=centroids;
            fprintf('here %d\n',run);
		end
	end
	fprintf('Plotting for run %d...\n', run);
		if exist('OCTAVE_VERSION')
			fflush(stdout);
        end
    p=plot(objfnvals(run,:));
    set(p,'Color',randi(10,1,3)/10);
	%plot(objfnvals(run,:),'LineWidth',2,'color',colors(run,:));
	hold on;
%     pause;
end
totaltime=cputime-time;
totaltime

% h = [];
% h(1) = subplot(3,2,1);
% img1 = mat2gray(reshape(mincentroids(1,:), [19,19]));
% imshow(img1);
% h(2) = subplot(3,2,2);
% img2 = mat2gray(reshape(mincentroids (2,:), [19,19]));
% imshow(img2);
% h(3) = subplot(3,2,3);
% img3 = mat2gray(reshape(mincentroids (3,:), [19,19]));
% imshow(img3);
% h(4) = subplot(3,2,4);
% img4 = mat2gray(reshape(mincentroids (4,:), [19,19]));
% imshow(img4);
% h(5) = subplot(3,2,5);
% img5 = mat2gray(reshape(mincentroids (5,:), [19,19]));
% imshow(img5);