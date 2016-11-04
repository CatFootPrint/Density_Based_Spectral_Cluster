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
fo_rayl=random('rayl',sqrt(vari/(2-pi/2)),length(s_QAM),1)-sqrt(pi/2)*sqrt(vari/(2-pi/2));
signal_fo_rayl=s_QAM.*exp(1i*fo_rayl.*(0:length(s_QAM)-1)');
signal_last_rayl=awgn(signal_fo_rayl,snr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
[label_rayl,center_rayl]=kmeans([real(signal_last_rayl),imag(signal_last_rayl)],8);
hold on;
h14=scatter(real(signal_last_rayl((label_rayl==1))),imag(signal_last_rayl((label_rayl==1))),'yo');
h24=scatter(real(signal_last_rayl((label_rayl==2))),imag(signal_last_rayl((label_rayl==2))),'y+');
h34=scatter(real(signal_last_rayl((label_rayl==3))),imag(signal_last_rayl((label_rayl==3))),'g*');
h44=scatter(real(signal_last_rayl((label_rayl==4))),imag(signal_last_rayl((label_rayl==4))),'gv');
h54=scatter(real(signal_last_rayl((label_rayl==5))),imag(signal_last_rayl((label_rayl==5))),'cx');
h64=scatter(real(signal_last_rayl((label_rayl==6))),imag(signal_last_rayl((label_rayl==6))),'cs');
h74=scatter(real(signal_last_rayl((label_rayl==7))),imag(signal_last_rayl((label_rayl==7))),'md');
h84=scatter(real(signal_last_rayl((label_rayl==8))),imag(signal_last_rayl((label_rayl==8))),'mp');
hold on;
axis equal;
h94=scatter((center_rayl(:,1)),(center_rayl(:,2)),'kh');
% text(center_rayl(1,1),center_rayl(1,2),'1');
% text(center_rayl(2,1),center_rayl(2,2),'2');
% text(center_rayl(3,1),center_rayl(3,2),'3');
% text(center_rayl(4,1),center_rayl(4,2),'4');
% text(center_rayl(5,1),center_rayl(5,2),'5');
% text(center_rayl(6,1),center_rayl(6,2),'6');
% text(center_rayl(7,1),center_rayl(7,2),'7');
% text(center_rayl(8,1),center_rayl(8,2),'8');
legend(h94,'Estimated centers');
title('kmeans');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bandwidth_last_rayl,density_last_rayl,X_last_rayl,Y_last_rayl]=kde2d([real(signal_last_rayl),imag(signal_last_rayl)]);
density_last_rayl=density_last_rayl/max(max(density_last_rayl));
w_rayl=interp2(X_last_rayl, Y_last_rayl, density_last_rayl, real(signal_last_rayl),imag(signal_last_rayl), 'spline');
weight_rayl=w_rayl*transpose(w_rayl);
figure;
mesh(X_last_rayl,Y_last_rayl,density_last_rayl);
grid on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[label_ng_rayl,C_ng_rayl,eigenvalue_ng_rayl]=spectral([real(signal_last_rayl),imag(signal_last_rayl)],8);
% text(0,0,'rayl');
[label_my_rayl,C_my_rayl,eigenvalue_my_rayl]=myspectral([real(signal_last_rayl),imag(signal_last_rayl)],8,weight_rayl);
% text(0,0,'rayl');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_rayl=[3,8,5,5,2,6,7,1];
% order_ng_rayl=[7,4,5,3,1,6,8,2];
% order_my_rayl=[8,4,2,5,6,3,1,7];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_rayl=(label_rayl==order_kmeans_rayl(1))+2*(label_rayl==order_kmeans_rayl(2))+3*(label_rayl==order_kmeans_rayl(3))+4*(label_rayl==order_kmeans_rayl(4))+...,
%     5*(label_rayl==order_kmeans_rayl(5))+6*(label_rayl==order_kmeans_rayl(6))+7*(label_rayl==order_kmeans_rayl(7))+8*(label_rayl==order_kmeans_rayl(8));
% label_ng_rayl=(label_ng_rayl==order_ng_rayl(1))+2*(label_ng_rayl==order_ng_rayl(2))+3*(label_ng_rayl==order_ng_rayl(3))+4*(label_ng_rayl==order_ng_rayl(4))+...
%     5*(label_ng_rayl==order_ng_rayl(5))+6*(label_ng_rayl==order_ng_rayl(6))+7*(label_ng_rayl==order_ng_rayl(7))+8*(label_ng_rayl==order_ng_rayl(8));
% label_my_rayl=(label_my_rayl==order_my_rayl(1))+2*(label_my_rayl==order_my_rayl(2))+3*(label_my_rayl==order_my_rayl(3))+4*(label_my_rayl==order_my_rayl(4))+...
%     5*(label_my_rayl==order_my_rayl(5))+6*(label_my_rayl==order_my_rayl(6))+7*(label_my_rayl==order_my_rayl(7))+8*(label_my_rayl==order_my_rayl(8));
% [~,ratio_kmeans_rayl]=biterr(label_QAM,label_rayl);
% [~,ratio_ng_rayl]=biterr(label_QAM,label_ng_rayl);
% [~,ratio_my_rayl]=biterr(label_QAM,label_my_rayl);
% fprintf(['rayl ratio is ',num2str(ratio_kmeans_rayl),'\n']);
% fprintf(['rayl ratio of Ng is ',num2str(ratio_ng_rayl),'\n']);
% fprintf(['rayl ratio of mine is ',num2str(ratio_my_rayl),'\n']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%