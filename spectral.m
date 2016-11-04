function [IDX,center,eigenvalue]=spectral(data,k)
affinity = CalculateAffinity(data);
%save('distance_ ng.csv','affinity','-ascii');
%figure,imshow(affinity,[]), title('Affinity Matrix')
% compute the degree matrix
% fprintf(['Total distance is ',num2str(sum(sum(affinity))),'\n']);
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
%save('L_ng.csv','NL2','-ascii');
% compute the normalized laplacian (method 2)  eye command is used to
% obtain the identity matrix of size m x n
 
 

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

% plot the eigen vector corresponding to the largest eigen value
%figure,plot(IDX)
figure;
hold on;
a1_my=find(IDX == 1);
a2_my=find(IDX == 2);
a3_my=find(IDX == 3);
a4_my=find(IDX == 4);
a5_my=find(IDX == 5);
a6_my=find(IDX == 6);
a7_my=find(IDX == 7);
a8_my=find(IDX == 8);
data_c=data*[1;1i];
center=[real(mean(data_c(a1_my))),imag(mean(data_c(a1_my)));...
    real(mean(data_c(a2_my))),imag(mean(data_c(a2_my)));...
    real(mean(data_c(a3_my))),imag(mean(data_c(a3_my)));...
    real(mean(data_c(a4_my))),imag(mean(data_c(a4_my)));...
    real(mean(data_c(a5_my))),imag(mean(data_c(a5_my)));...
    real(mean(data_c(a6_my))),imag(mean(data_c(a6_my)));...
    real(mean(data_c(a7_my))),imag(mean(data_c(a7_my)));...
    real(mean(data_c(a8_my))),imag(mean(data_c(a8_my)))];
% for i=1:size(IDX,1)
%     if IDX(i,1) == 1
%         plot(data(i,1),data(i,2),'ro');
%     elseif IDX(i,1) == 2
%         plot(data(i,1),data(i,2),'y+');
%     elseif IDX(i,1) == 3
%         plot(data(i,1),data(i,2),'g*'); 
%     elseif IDX(i,1) == 4
%         plot(data(i,1),data(i,2),'b.'); 
%         elseif IDX(i,1) == 5
%         plot(data(i,1),data(i,2),'cx'); 
%         elseif IDX(i,1) == 6
%         plot(data(i,1),data(i,2),'ms');
%         elseif IDX(i,1) == 7
%         plot(data(i,1),data(i,2),'rd');
%         elseif IDX(i,1) == 8
%         plot(data(i,1),data(i,2),'yp');
%     end
% end
scatter(real(data_c(a1_my)),imag(data_c(a1_my)),'yo');
scatter(real(data_c(a2_my)),imag(data_c(a2_my)),'y+');
scatter(real(data_c(a3_my)),imag(data_c(a3_my)),'g*');
scatter(real(data_c(a4_my)),imag(data_c(a4_my)),'gv');
scatter(real(data_c(a5_my)),imag(data_c(a5_my)),'cx');
scatter(real(data_c(a6_my)),imag(data_c(a6_my)),'cs');
scatter(real(data_c(a7_my)),imag(data_c(a7_my)),'md');
scatter(real(data_c(a8_my)),imag(data_c(a8_my)),'mp');
%hold off;
% text(center(1,1),center(1,2),'1');
% text(center(2,1),center(2,2),'2');
% text(center(3,1),center(3,2),'3');
% text(center(4,1),center(4,2),'4');
% text(center(5,1),center(5,2),'5');
% text(center(6,1),center(6,2),'6');
% text(center(7,1),center(7,2),'7');
% text(center(8,1),center(8,2),'8');
hs=scatter(center(1,1),center(1,2),'kh');
scatter(center(2,1),center(2,2),'kh');
scatter(center(3,1),center(3,2),'kh');
scatter(center(4,1),center(4,2),'kh');
scatter(center(5,1),center(5,2),'kh');
scatter(center(6,1),center(6,2),'kh');
scatter(center(7,1),center(7,2),'kh');
scatter(center(8,1),center(8,2),'kh');
title('Ng''s Algorithm ');
legend(hs,'cluster centers');
axis equal;
grid on;