[bandwidth_last_norm,density_last_norm,X_last_norm,Y_last_norm]=kde2d([real(signal_last_norm),imag(signal_last_norm)]);
density_last_norm=density_last_norm/max(max(density_last_norm));
w_norm=interp2(X_last_norm, Y_last_norm, density_last_norm, real(signal_last_norm),imag(signal_last_norm), 'spline');
weight_norm=w_norm*transpose(w_norm);
figure;
mesh(X_last_norm, Y_last_norm, density_last_norm);
grid on;
title('density of norm');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[label_ng_norm,C_ng_norm,eigenvalue_ng_norm]=spectral([real(signal_last_norm),imag(signal_last_norm)],8);
% text(0,0,'norm');
[label_my_norm,C_my_norm,eigenvalue_my_norm]=myspectral([real(signal_last_norm),imag(signal_last_norm)],8,weight_norm);
% text(0,0,'norm');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_norm=[5,2,1,8,3,7,6,4];
% order_ng_norm=[4,4,2,8,6,5,7,1];
% order_my_norm=[5,3,1,8,6,7,4,2];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_norm=(label_norm==order_kmeans_norm(1))+2*(label_norm==order_kmeans_norm(2))+3*(label_norm==order_kmeans_norm(3))+4*(label_norm==order_kmeans_norm(4))+...,
%     5*(label_norm==order_kmeans_norm(5))+6*(label_norm==order_kmeans_norm(6))+7*(label_norm==order_kmeans_norm(7))+8*(label_norm==order_kmeans_norm(8));
% label_ng_norm=(label_ng_norm==order_ng_norm(1))+2*(label_ng_norm==order_ng_norm(2))+3*(label_ng_norm==order_ng_norm(3))+4*(label_ng_norm==order_ng_norm(4))+...
%     5*(label_ng_norm==order_ng_norm(5))+6*(label_ng_norm==order_ng_norm(6))+7*(label_ng_norm==order_ng_norm(7))+8*(label_ng_norm==order_ng_norm(8));
% label_my_norm=(label_my_norm==order_my_norm(1))+2*(label_my_norm==order_my_norm(2))+3*(label_my_norm==order_my_norm(3))+4*(label_my_norm==order_my_norm(4))+...
%     5*(label_my_norm==order_my_norm(5))+6*(label_my_norm==order_my_norm(6))+7*(label_my_norm==order_my_norm(7))+8*(label_my_norm==order_my_norm(8));
% [~,ratio_kmeans_norm]=biterr(label_QAM,label_norm);
% [~,ratio_ng_norm]=biterr(label_QAM,label_ng_norm);
% [~,ratio_my_norm]=biterr(label_QAM,label_my_norm);
% fprintf(['norm ratio is ',num2str(ratio_kmeans_norm),'\n']);
% fprintf(['norm ratio of Ng is ',num2str(ratio_ng_norm),'\n']);
% fprintf(['norm ratio of mine is ',num2str(ratio_my_norm),'\n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
