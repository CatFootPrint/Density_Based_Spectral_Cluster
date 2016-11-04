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
fo_norm=normrnd(0,vari,length(s_QAM),1);
fo_exp=random('exp',vari^2,length(s_QAM),1)-vari;
fo_chi2=random('gam',vari/2,2,length(s_QAM),1)-vari/2;
% fo_rayl=random('rayl',sqrt(vari/(2-pi/2)),length(s_QAM),1)-sqrt(pi/2)*sqrt(vari/(2-pi/2));
fo_geo=random('geo',(-1+sqrt(1+4*vari))/2/vari,length(s_QAM),1)+1-1/((-1+sqrt(1+4*vari))/2/vari);
signal_fo_norm=s_QAM.*exp(1i*fo_norm.*(0:length(s_QAM)-1)');
% signal_fo_exp=s_QAM.*exp(1i*fo_exp.*(0:length(s_QAM)-1)');
% signal_fo_chi2=s_QAM.*exp(1i*fo_chi2.*(0:length(s_QAM)-1)');
% signal_fo_rayl=s_QAM.*exp(1i*fo_rayl.*(0:length(s_QAM)-1)');
% signal_fo_geo=s_QAM.*exp(1i*fo_geo.*(0:length(s_QAM)-1)');
% po_fo_norm=mean(angle(signal_fo_norm));
% po_fo_exp=mean(angle(signal_fo_exp));
% po_fo_chi2=mean(angle(signal_fo_chi2));
% po_fo_geo=mean(angle(signal_fo_geo));
% signal_fo_norm=signal_fo_norm.*exp(-1i*po_fo_norm);
% signal_fo_exp=signal_fo_exp.*exp(-1i*po_fo_exp);
% signal_fo_chi2=signal_fo_chi2.*exp(-1i*po_fo_chi2);
% signal_fo_geo=signal_fo_geo.*exp(-1i*po_fo_geo);
signal_last_norm=awgn(signal_fo_norm,snr);
% po=mean(angle(signal_last_norm));
% signal_last_norm=signal_last_norm*exp(-1i*(po-pi/2));
% signal_last_exp=awgn(signal_fo_exp,snr);
% signal_last_chi2=awgn(signal_fo_chi2,snr);
% signal_last_rayl=awgn(signal_fo_rayl,snr);
% signal_last_geo=awgn(signal_fo_geo,snr);
figure(1);
[label_norm,center_norm]=kmeans([real(signal_last_norm),imag(signal_last_norm)],8);
hold on;
h11=scatter(real(signal_last_norm((label_norm==1))),imag(signal_last_norm((label_norm==1))),'yo');
h21=scatter(real(signal_last_norm((label_norm==2))),imag(signal_last_norm((label_norm==2))),'y+');
h31=scatter(real(signal_last_norm((label_norm==3))),imag(signal_last_norm((label_norm==3))),'g*');
h41=scatter(real(signal_last_norm((label_norm==4))),imag(signal_last_norm((label_norm==4))),'gv');
h51=scatter(real(signal_last_norm((label_norm==5))),imag(signal_last_norm((label_norm==5))),'cx');
h61=scatter(real(signal_last_norm((label_norm==6))),imag(signal_last_norm((label_norm==6))),'cs');
h71=scatter(real(signal_last_norm((label_norm==7))),imag(signal_last_norm((label_norm==7))),'md');
h81=scatter(real(signal_last_norm((label_norm==8))),imag(signal_last_norm((label_norm==8))),'mp');
hold on;
axis equal;
h91=scatter((center_norm(:,1)),(center_norm(:,2)),'kh');
% text(center_norm(1,1),center_norm(1,2),'1');
% text(center_norm(2,1),center_norm(2,2),'2');
% text(center_norm(3,1),center_norm(3,2),'3');
% text(center_norm(4,1),center_norm(4,2),'4');
% text(center_norm(5,1),center_norm(5,2),'5');
% text(center_norm(6,1),center_norm(6,2),'6');
% text(center_norm(7,1),center_norm(7,2),'7');
% text(center_norm(8,1),center_norm(8,2),'8');
legend(h91,'Estimated centers');
title('kmeans');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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