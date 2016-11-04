close all;
clear;
snr=30;
sigma=0.035;
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
fo_exp=random('exp',vari^2,length(s_QAM),1)-vari;
signal_fo_exp=s_QAM.*exp(1i*fo_exp.*(0:length(s_QAM)-1)');
signal_last_exp=awgn(signal_fo_exp,snr);
po=mean(angle(signal_last_exp));
signal_last_exp=signal_last_exp*exp(-1i*(po-pi/2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
[label_exp,center_exp]=kmeans([real(signal_last_exp),imag(signal_last_exp)],8);
hold on;
h12=scatter(real(signal_last_exp((label_exp==1))),imag(signal_last_exp((label_exp==1))),'yo');
h22=scatter(real(signal_last_exp((label_exp==2))),imag(signal_last_exp((label_exp==2))),'y+');
h32=scatter(real(signal_last_exp((label_exp==3))),imag(signal_last_exp((label_exp==3))),'g*');
h42=scatter(real(signal_last_exp((label_exp==4))),imag(signal_last_exp((label_exp==4))),'g.');
h52=scatter(real(signal_last_exp((label_exp==5))),imag(signal_last_exp((label_exp==5))),'cx');
h62=scatter(real(signal_last_exp((label_exp==6))),imag(signal_last_exp((label_exp==6))),'cs');
h72=scatter(real(signal_last_exp((label_exp==7))),imag(signal_last_exp((label_exp==7))),'md');
h82=scatter(real(signal_last_exp((label_exp==8))),imag(signal_last_exp((label_exp==8))),'mp');
hold on;
axis equal;
h92=scatter((center_exp(:,1)),(center_exp(:,2)),'r');
text(center_exp(1,1),center_exp(1,2),'1');
text(center_exp(2,1),center_exp(2,2),'2');
text(center_exp(3,1),center_exp(3,2),'3');
text(center_exp(4,1),center_exp(4,2),'4');
text(center_exp(5,1),center_exp(5,2),'5');
text(center_exp(6,1),center_exp(6,2),'6');
text(center_exp(7,1),center_exp(7,2),'7');
text(center_exp(8,1),center_exp(8,2),'8');
legend([h12,h92],'Signals','Estimated centers');
title('exp kmeans');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bandwidth_last_exp,density_last_exp,X_last_exp,Y_last_exp]=kde2d([real(signal_last_exp),imag(signal_last_exp)]);
density_last_exp=density_last_exp/max(max(density_last_exp));
w_exp=interp2(X_last_exp, Y_last_exp, density_last_exp, real(signal_last_exp),imag(signal_last_exp), 'spline');
weight_exp=w_exp*transpose(w_exp);
figure;
mesh(X_last_exp, Y_last_exp, density_last_exp);
grid on;
title('density of exp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[label_ng_exp,C_ng_exp,eigenvalue_ng_exp]=spectral([real(signal_last_exp),imag(signal_last_exp)],8);
text(0,0,'exp');
[label_my_exp,C_my_exp,eigenvalue_my_exp]=myspectral([real(signal_last_exp),imag(signal_last_exp)],8,weight_exp);
text(0,0,'exp');
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
% order_kmeans_exp=[1,2,7,6,4,5,3,5];
% order_ng_exp=[3,8,2,1,7,4,5,5];
% order_my_exp=[8,1,4,5,3,2,6,6];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_exp=(label_exp==order_kmeans_exp(1))+2*(label_exp==order_kmeans_exp(2))+3*(label_exp==order_kmeans_exp(3))+4*(label_exp==order_kmeans_exp(4))+...,
%     5*(label_exp==order_kmeans_exp(5))+6*(label_exp==order_kmeans_exp(6))+7*(label_exp==order_kmeans_exp(7))+8*(label_exp==order_kmeans_exp(8));
% label_ng_exp=(label_ng_exp==order_ng_exp(1))+2*(label_ng_exp==order_ng_exp(2))+3*(label_ng_exp==order_ng_exp(3))+4*(label_ng_exp==order_ng_exp(4))+...
%     5*(label_ng_exp==order_ng_exp(5))+6*(label_ng_exp==order_ng_exp(6))+7*(label_ng_exp==order_ng_exp(7))+8*(label_ng_exp==order_ng_exp(8));
% label_my_exp=(label_my_exp==order_my_exp(1))+2*(label_my_exp==order_my_exp(2))+3*(label_my_exp==order_my_exp(3))+4*(label_my_exp==order_my_exp(4))+...
%     5*(label_my_exp==order_my_exp(5))+6*(label_my_exp==order_my_exp(6))+7*(label_my_exp==order_my_exp(7))+8*(label_my_exp==order_my_exp(8));
% [~,ratio_kmeans_exp]=biterr(label_QAM,label_exp);
% [~,ratio_ng_exp]=biterr(label_QAM,label_ng_exp);
% [~,ratio_my_exp]=biterr(label_QAM,label_my_exp);
% fprintf(['exp ratio is ',num2str(ratio_kmeans_exp),'\n']);
% fprintf(['exp ratio of Ng is ',num2str(ratio_ng_exp),'\n']);
% fprintf(['exp ratio of mine is ',num2str(ratio_my_exp),'\n']);
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