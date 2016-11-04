close all;
clear;
snr=5;
sigma=0.05;
times=10;
ratio_av=0;
ratio_ng_av=0;
ratio_my_av=0;
number=125;
vari=sigma^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
QAM_mod=comm.RectangularQAMModulator('ModulationOrder',8);
QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
s_QAM=step(QAM_mod,repmat((0:7)',number,1));
label_QAM=repmat((0:7)',number,1)+1;
fo_chi2=random('gam',vari/2,2,length(s_QAM),1)-vari/2;
signal_fo_chi2=s_QAM.*exp(1i*fo_chi2.*(0:length(s_QAM)-1)');
signal_last_chi2=awgn(signal_fo_chi2,snr);
po=mean(angle(signal_last_chi2));
signal_last_chi2=signal_last_chi2*exp(-1i*(po-pi/2));
% signal_last_chi2=load('signal_last_chi2.csv');
% signal_last_chi2=signal_last_chi2*[1;1i];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
[label_chi2,center_chi2]=kmeans([real(signal_last_chi2),imag(signal_last_chi2)],8);
hold on;
h13=scatter(real(signal_last_chi2((label_chi2==1))),imag(signal_last_chi2((label_chi2==1))),'yo');
h23=scatter(real(signal_last_chi2((label_chi2==2))),imag(signal_last_chi2((label_chi2==2))),'y+');
h33=scatter(real(signal_last_chi2((label_chi2==3))),imag(signal_last_chi2((label_chi2==3))),'g*');
h43=scatter(real(signal_last_chi2((label_chi2==4))),imag(signal_last_chi2((label_chi2==4))),'gv');
h53=scatter(real(signal_last_chi2((label_chi2==5))),imag(signal_last_chi2((label_chi2==5))),'cx');
h63=scatter(real(signal_last_chi2((label_chi2==6))),imag(signal_last_chi2((label_chi2==6))),'cs');
h73=scatter(real(signal_last_chi2((label_chi2==7))),imag(signal_last_chi2((label_chi2==7))),'md');
h83=scatter(real(signal_last_chi2((label_chi2==8))),imag(signal_last_chi2((label_chi2==8))),'mp');
hold on;
axis equal;
h93=scatter((center_chi2(:,1)),(center_chi2(:,2)),'kh');
% text(center_chi2(1,1),center_chi2(1,2),'1');
% text(center_chi2(2,1),center_chi2(2,2),'2');
% text(center_chi2(3,1),center_chi2(3,2),'3');
% text(center_chi2(4,1),center_chi2(4,2),'4');
% text(center_chi2(5,1),center_chi2(5,2),'5');
% text(center_chi2(6,1),center_chi2(6,2),'6');
% text(center_chi2(7,1),center_chi2(7,2),'7');
% text(center_chi2(8,1),center_chi2(8,2),'8');
legend(h93,'Estimated centers');
title('kmeans');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bandwidth_last_chi2,density_last_chi2,X_last_chi2,Y_last_chi2]=kde2d([real(signal_last_chi2),imag(signal_last_chi2)]);
density_last_chi2=density_last_chi2/max(max(density_last_chi2));
w_chi2=interp2(X_last_chi2, Y_last_chi2, density_last_chi2, real(signal_last_chi2),imag(signal_last_chi2), 'spline');
weight_chi2=w_chi2*transpose(w_chi2);
figure;
mesh(X_last_chi2, Y_last_chi2, density_last_chi2);
grid on;
title('density of chi2');
[label_ng_chi2,C_ng_chi2,eigenvalue_ng_chi2]=spectral([real(signal_last_chi2),imag(signal_last_chi2)],8);
% text(0,0,'chi2');
[label_my_chi2,C_my_chi2,eigenvalue_my_chi2]=myspectral([real(signal_last_chi2),imag(signal_last_chi2)],8,weight_chi2);
% text(0,0,'chi2');
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_chi2=[1,4,1,4,2,8,6,7];
% order_ng_chi2=[3,5,8,7,6,1,4,2];
% order_my_chi2=[6,7,5,2,3,1,5,4];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_chi2=(label_chi2==order_kmeans_chi2(1))+2*(label_chi2==order_kmeans_chi2(2))+3*(label_chi2==order_kmeans_chi2(3))+4*(label_chi2==order_kmeans_chi2(4))+...,
%     5*(label_chi2==order_kmeans_chi2(5))+6*(label_chi2==order_kmeans_chi2(6))+7*(label_chi2==order_kmeans_chi2(7))+8*(label_chi2==order_kmeans_chi2(8));
% label_ng_chi2=(label_ng_chi2==order_ng_chi2(1))+2*(label_ng_chi2==order_ng_chi2(2))+3*(label_ng_chi2==order_ng_chi2(3))+4*(label_ng_chi2==order_ng_chi2(4))+...
%     5*(label_ng_chi2==order_ng_chi2(5))+6*(label_ng_chi2==order_ng_chi2(6))+7*(label_ng_chi2==order_ng_chi2(7))+8*(label_ng_chi2==order_ng_chi2(8));
% label_my_chi2=(label_my_chi2==order_my_chi2(1))+2*(label_my_chi2==order_my_chi2(2))+3*(label_my_chi2==order_my_chi2(3))+4*(label_my_chi2==order_my_chi2(4))+...
%     5*(label_my_chi2==order_my_chi2(5))+6*(label_my_chi2==order_my_chi2(6))+7*(label_my_chi2==order_my_chi2(7))+8*(label_my_chi2==order_my_chi2(8));
% [~,ratio_kmeans_chi2]=biterr(label_QAM,label_chi2);
% [~,ratio_ng_chi2]=biterr(label_QAM,label_ng_chi2);
% [~,ratio_my_chi2]=biterr(label_QAM,label_my_chi2);
% fprintf(['chi2 ratio is ',num2str(ratio_kmeans_chi2),'\n']);
% fprintf(['chi2 ratio of Ng is ',num2str(ratio_ng_chi2),'\n']);
% fprintf(['chi2 ratio of mine is ',num2str(ratio_my_chi2),'\n']);
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