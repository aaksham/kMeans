function centroids = computeCentroids(X, idx, K)
[m n] = size(X);
centroids = zeros(K, n);
num=zeros(K,1);
for i=1:m
 centroids(idx(i),:)=centroids(idx(i),:)+X(i,:);
 num(idx(i))=num(idx(i))+1;
end
for i=1:n
 centroids(:,i)=centroids(:,i)./num;
end

