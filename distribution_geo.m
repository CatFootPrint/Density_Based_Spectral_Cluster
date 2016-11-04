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
fo_geo=random('geo',(-1+sqrt(1+4*vari))/2/vari,length(s_QAM),1)+1-1/((-1+sqrt(1+4*vari))/2/vari);
signal_fo_geo=s_QAM.*exp(1i*fo_geo.*(0:length(s_QAM)-1)');
signal_last_geo=awgn(signal_fo_geo,snr);
figure(5);
[label_geo,center_geo]=kmeans([real(signal_last_geo),imag(signal_last_geo)],8);
hold on;
h15=scatter(real(signal_last_geo((label_geo==1))),imag(signal_last_geo((label_geo==1))),'yo');
h25=scatter(real(signal_last_geo((label_geo==2))),imag(signal_last_geo((label_geo==2))),'y+');
h35=scatter(real(signal_last_geo((label_geo==3))),imag(signal_last_geo((label_geo==3))),'g*');
h45=scatter(real(signal_last_geo((label_geo==4))),imag(signal_last_geo((label_geo==4))),'g.');
h55=scatter(real(signal_last_geo((label_geo==5))),imag(signal_last_geo((label_geo==5))),'cx');
h65=scatter(real(signal_last_geo((label_geo==6))),imag(signal_last_geo((label_geo==6))),'cs');
h75=scatter(real(signal_last_geo((label_geo==7))),imag(signal_last_geo((label_geo==7))),'md');
h85=scatter(real(signal_last_geo((label_geo==8))),imag(signal_last_geo((label_geo==8))),'mp');
hold on;
axis equal;
h95=scatter((center_geo(:,1)),(center_geo(:,2)),'r');
text(center_geo(1,1),center_geo(1,2),'1');
text(center_geo(2,1),center_geo(2,2),'2');
text(center_geo(3,1),center_geo(3,2),'3');
text(center_geo(4,1),center_geo(4,2),'4');
text(center_geo(5,1),center_geo(5,2),'5');
text(center_geo(6,1),center_geo(6,2),'6');
text(center_geo(7,1),center_geo(7,2),'7');
text(center_geo(8,1),center_geo(8,2),'8');
legend([h15,h95],'Signals','Estimated centers');
title('Geo kmeans');
grid on;
[bandwidth_last_geo,density_last_geo,X_last_geo,Y_last_geo]=kde2d([real(signal_last_geo),imag(signal_last_geo)]);
density_last_geo=density_last_geo/max(max(density_last_geo));
w_geo=interp2(X_last_geo, Y_last_geo, density_last_geo, real(signal_last_geo),imag(signal_last_geo), 'spline');
weight_geo=w_geo*transpose(w_geo);
figure;
mesh(X_last_geo, Y_last_geo, density_last_geo);
grid on;
title('density of geo');
[label_ng_geo,C_ng_geo,eigenvalue_ng_geo]=spectral([real(signal_last_geo),imag(signal_last_geo)],8);
text(0,0,'Geo');
[label_my_geo,C_my_geo,eigenvalue_my_geo]=myspectral([real(signal_last_geo),imag(signal_last_geo)],8,weight_geo);
text(0,0,'Geo');
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_geo=[1,8,3,7,2,5,4,7];
% order_ng_geo=[3,2,5,4,6,8,6,1];
% order_my_geo=[4,3,4,1,8,6,5,7];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_geo=(label_geo==order_kmeans_geo(1))+2*(label_geo==order_kmeans_geo(2))+3*(label_geo==order_kmeans_geo(3))+4*(label_geo==order_kmeans_geo(4))+...,
%     5*(label_geo==order_kmeans_geo(5))+6*(label_geo==order_kmeans_geo(6))+7*(label_geo==order_kmeans_geo(7))+8*(label_geo==order_kmeans_geo(8));
% label_ng_geo=(label_ng_geo==order_ng_geo(1))+2*(label_ng_geo==order_ng_geo(2))+3*(label_ng_geo==order_ng_geo(3))+4*(label_ng_geo==order_ng_geo(4))+...
%     5*(label_ng_geo==order_ng_geo(5))+6*(label_ng_geo==order_ng_geo(6))+7*(label_ng_geo==order_ng_geo(7))+8*(label_ng_geo==order_ng_geo(8));
% label_my_geo=(label_my_geo==order_my_geo(1))+2*(label_my_geo==order_my_geo(2))+3*(label_my_geo==order_my_geo(3))+4*(label_my_geo==order_my_geo(4))+...
%     5*(label_my_geo==order_my_geo(5))+6*(label_my_geo==order_my_geo(6))+7*(label_my_geo==order_my_geo(7))+8*(label_my_geo==order_my_geo(8));
% [~,ratio_kmeans_geo]=biterr(label_QAM,label_geo);
% [~,ratio_ng_geo]=biterr(label_QAM,label_ng_geo);
% [~,ratio_my_geo]=biterr(label_QAM,label_my_geo);
% fprintf(['Geo ratio is ',num2str(ratio_kmeans_geo),'\n']);
% fprintf(['Geo ratio of Ng is ',num2str(ratio_ng_geo),'\n']);
% fprintf(['Geo ratio of mine is ',num2str(ratio_my_geo),'\n']);
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