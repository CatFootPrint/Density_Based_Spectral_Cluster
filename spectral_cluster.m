function [IDX,center,eigenvalue]=spectral_cluster(data,k)
affinity = CalculateAffinity(data);
D=zeros(length(affinity));
NL1=Inf*ones(length(affinity));
U=Inf*ones(length(affinity),k);
for i=1:size(affinity,1)
    D(i,i) = sum(affinity(i,:));
end

% compute the normalized laplacian / affinity matrix (method 1)
%NL1 = D^(-1/2) .* L .* D^(-1/2);
for i=1:size(affinity,1)
    for j=1:size(affinity,2)
        NL1(i,j) = affinity(i,j) / (sqrt(D(i,i)) * sqrt(D(j,j)));  
%        NL2 (i,j)= eye(size(affinity,1),size(affinity,2)) - (D^(-1/2) .* affinity .* D^(-1/2));
    end
end

NL2=eye(length(NL1))-NL1;
% perform the eigen value decomposition
[eigVectors,~] = eig(NL1);
[~,eigenvalue] = eig(NL2);
eigenvalue=sort(diag(eigenvalue));
% select k largest eigen vectors
%k = 3;
nEigVec = eigVectors(:,(size(eigVectors,1)-(k-1)): size(eigVectors,1));

% construct the normalized matrix U from the obtained eigen vectors
for i=1:size(nEigVec,1)
    n = sqrt(sum(nEigVec(i,:).^2));    
    U(i,:) = nEigVec(i,:) ./ n; 
end

% perform kmeans clustering on the matrix U
[IDX,C] = kmeans(U,k); 