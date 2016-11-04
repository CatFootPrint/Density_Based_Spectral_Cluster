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
fo_norm=normrnd(0,vari,length(s_QAM),1);
fo_exp=random('exp',vari^2,length(s_QAM),1)-vari;
fo_chi2=random('gam',vari/2,2,length(s_QAM),1)-vari/2;
% fo_rayl=random('rayl',sqrt(vari/(2-pi/2)),length(s_QAM),1)-sqrt(pi/2)*sqrt(vari/(2-pi/2));
fo_geo=random('geo',(-1+sqrt(1+4*vari))/2/vari,length(s_QAM),1)+1-1/((-1+sqrt(1+4*vari))/2/vari);
signal_fo_norm=s_QAM.*exp(1i*fo_norm.*(0:length(s_QAM)-1)');
signal_fo_exp=s_QAM.*exp(1i*fo_exp.*(0:length(s_QAM)-1)');
signal_fo_chi2=s_QAM.*exp(1i*fo_chi2.*(0:length(s_QAM)-1)');
% signal_fo_rayl=s_QAM.*exp(1i*fo_rayl.*(0:length(s_QAM)-1)');
signal_fo_geo=s_QAM.*exp(1i*fo_geo.*(0:length(s_QAM)-1)');
% po_fo_norm=mean(angle(signal_fo_norm));
% po_fo_exp=mean(angle(signal_fo_exp));
% po_fo_chi2=mean(angle(signal_fo_chi2));
% po_fo_geo=mean(angle(signal_fo_geo));
% signal_fo_norm=signal_fo_norm.*exp(-1i*po_fo_norm);
% signal_fo_exp=signal_fo_exp.*exp(-1i*po_fo_exp);
% signal_fo_chi2=signal_fo_chi2.*exp(-1i*po_fo_chi2);
% signal_fo_geo=signal_fo_geo.*exp(-1i*po_fo_geo);
signal_last_norm=awgn(signal_fo_norm,snr);
signal_last_exp=awgn(signal_fo_exp,snr);
signal_last_chi2=awgn(signal_fo_chi2,snr);
% signal_last_rayl=awgn(signal_fo_rayl,snr);
signal_last_geo=awgn(signal_fo_geo,snr);
figure(1);
[label_norm,center_norm]=kmeans([real(signal_last_norm),imag(signal_last_norm)],8);
hold on;
h11=scatter(real(signal_last_norm((label_norm==1))),imag(signal_last_norm((label_norm==1))),'yo');
h21=scatter(real(signal_last_norm((label_norm==2))),imag(signal_last_norm((label_norm==2))),'y+');
h31=scatter(real(signal_last_norm((label_norm==3))),imag(signal_last_norm((label_norm==3))),'g*');
h41=scatter(real(signal_last_norm((label_norm==4))),imag(signal_last_norm((label_norm==4))),'g.');
h51=scatter(real(signal_last_norm((label_norm==5))),imag(signal_last_norm((label_norm==5))),'cx');
h61=scatter(real(signal_last_norm((label_norm==6))),imag(signal_last_norm((label_norm==6))),'cs');
h71=scatter(real(signal_last_norm((label_norm==7))),imag(signal_last_norm((label_norm==7))),'md');
h81=scatter(real(signal_last_norm((label_norm==8))),imag(signal_last_norm((label_norm==8))),'mp');
hold on;
axis equal;
h91=scatter((center_norm(:,1)),(center_norm(:,2)),'r');
text(center_norm(1,1),center_norm(1,2),'1');
text(center_norm(2,1),center_norm(2,2),'2');
text(center_norm(3,1),center_norm(3,2),'3');
text(center_norm(4,1),center_norm(4,2),'4');
text(center_norm(5,1),center_norm(5,2),'5');
text(center_norm(6,1),center_norm(6,2),'6');
text(center_norm(7,1),center_norm(7,2),'7');
text(center_norm(8,1),center_norm(8,2),'8');
legend([h11,h91],'Signals','Estimated centers');
title('norm kmeans');
grid on;
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
figure(3);
[label_chi2,center_chi2]=kmeans([real(signal_last_chi2),imag(signal_last_chi2)],8);
hold on;
h13=scatter(real(signal_last_chi2((label_chi2==1))),imag(signal_last_chi2((label_chi2==1))),'yo');
h23=scatter(real(signal_last_chi2((label_chi2==2))),imag(signal_last_chi2((label_chi2==2))),'y+');
h33=scatter(real(signal_last_chi2((label_chi2==3))),imag(signal_last_chi2((label_chi2==3))),'g*');
h43=scatter(real(signal_last_chi2((label_chi2==4))),imag(signal_last_chi2((label_chi2==4))),'g.');
h53=scatter(real(signal_last_chi2((label_chi2==5))),imag(signal_last_chi2((label_chi2==5))),'cx');
h63=scatter(real(signal_last_chi2((label_chi2==6))),imag(signal_last_chi2((label_chi2==6))),'cs');
h73=scatter(real(signal_last_chi2((label_chi2==7))),imag(signal_last_chi2((label_chi2==7))),'md');
h83=scatter(real(signal_last_chi2((label_chi2==8))),imag(signal_last_chi2((label_chi2==8))),'mp');
hold on;
axis equal;
h93=scatter((center_chi2(:,1)),(center_chi2(:,2)),'r');
text(center_chi2(1,1),center_chi2(1,2),'1');
text(center_chi2(2,1),center_chi2(2,2),'2');
text(center_chi2(3,1),center_chi2(3,2),'3');
text(center_chi2(4,1),center_chi2(4,2),'4');
text(center_chi2(5,1),center_chi2(5,2),'5');
text(center_chi2(6,1),center_chi2(6,2),'6');
text(center_chi2(7,1),center_chi2(7,2),'7');
text(center_chi2(8,1),center_chi2(8,2),'8');
legend([h13,h93],'Signals','Estimated centers');
title('chi2 kmeans');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(4);
% [label_rayl,center_rayl]=kmeans([real(signal_last_rayl),imag(signal_last_rayl)],8);
% hold on;
% h14=scatter(real(signal_last_rayl((label_rayl==1))),imag(signal_last_rayl((label_rayl==1))),'yo');
% h24=scatter(real(signal_last_rayl((label_rayl==2))),imag(signal_last_rayl((label_rayl==2))),'y+');
% h34=scatter(real(signal_last_rayl((label_rayl==3))),imag(signal_last_rayl((label_rayl==3))),'g*');
% h44=scatter(real(signal_last_rayl((label_rayl==4))),imag(signal_last_rayl((label_rayl==4))),'g.');
% h54=scatter(real(signal_last_rayl((label_rayl==5))),imag(signal_last_rayl((label_rayl==5))),'cx');
% h64=scatter(real(signal_last_rayl((label_rayl==6))),imag(signal_last_rayl((label_rayl==6))),'cs');
% h74=scatter(real(signal_last_rayl((label_rayl==7))),imag(signal_last_rayl((label_rayl==7))),'md');
% h84=scatter(real(signal_last_rayl((label_rayl==8))),imag(signal_last_rayl((label_rayl==8))),'mp');
% hold on;
% axis equal;
% h94=scatter((center_rayl(:,1)),(center_rayl(:,2)),'r');
% text(center_rayl(1,1),center_rayl(1,2),'1');
% text(center_rayl(2,1),center_rayl(2,2),'2');
% text(center_rayl(3,1),center_rayl(3,2),'3');
% text(center_rayl(4,1),center_rayl(4,2),'4');
% text(center_rayl(5,1),center_rayl(5,2),'5');
% text(center_rayl(6,1),center_rayl(6,2),'6');
% text(center_rayl(7,1),center_rayl(7,2),'7');
% text(center_rayl(8,1),center_rayl(8,2),'8');
% legend([h14,h94],'Signals','Estimated centers');
% title('rayl kmeans');
% grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bandwidth_last_norm,density_last_norm,X_last_norm,Y_last_norm]=kde2d([real(signal_last_norm),imag(signal_last_norm)]);
density_last_norm=density_last_norm/max(max(density_last_norm));
w_norm=interp2(X_last_norm, Y_last_norm, density_last_norm, real(signal_last_norm),imag(signal_last_norm), 'spline');
weight_norm=w_norm*transpose(w_norm);
figure;
mesh(X_last_norm, Y_last_norm, density_last_norm);
grid on;
title('density of norm');
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
[bandwidth_last_chi2,density_last_chi2,X_last_chi2,Y_last_chi2]=kde2d([real(signal_last_chi2),imag(signal_last_chi2)]);
density_last_chi2=density_last_chi2/max(max(density_last_chi2));
w_chi2=interp2(X_last_chi2, Y_last_chi2, density_last_chi2, real(signal_last_chi2),imag(signal_last_chi2), 'spline');
weight_chi2=w_chi2*transpose(w_chi2);
figure;
mesh(X_last_chi2, Y_last_chi2, density_last_chi2);
grid on;
title('density of chi2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [bandwidth_last_rayl,density_last_rayl,X_last_rayl,Y_last_rayl]=kde2d([real(signal_last_rayl),imag(signal_last_rayl)]);
% density_last_rayl=density_last_rayl/max(max(density_last_rayl));
% w_rayl=interp2(X_last_rayl, Y_last_rayl, density_last_rayl, real(signal_last_rayl),imag(signal_last_rayl), 'spline');
% weight_rayl=w_rayl*transpose(w_rayl);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bandwidth_last_geo,density_last_geo,X_last_geo,Y_last_geo]=kde2d([real(signal_last_geo),imag(signal_last_geo)]);
density_last_geo=density_last_geo/max(max(density_last_geo));
w_geo=interp2(X_last_geo, Y_last_geo, density_last_geo, real(signal_last_geo),imag(signal_last_geo), 'spline');
weight_geo=w_geo*transpose(w_geo);
figure;
mesh(X_last_geo, Y_last_geo, density_last_geo);
grid on;
title('density of geo');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[label_ng_norm,C_ng_norm,eigenvalue_ng_norm]=spectral([real(signal_last_norm),imag(signal_last_norm)],8);
text(0,0,'norm');
[label_my_norm,C_my_norm,eigenvalue_my_norm]=myspectral([real(signal_last_norm),imag(signal_last_norm)],8,weight_norm);
text(0,0,'norm');
[label_ng_exp,C_ng_exp,eigenvalue_ng_exp]=spectral([real(signal_last_exp),imag(signal_last_exp)],8);
text(0,0,'exp');
[label_my_exp,C_my_exp,eigenvalue_my_exp]=myspectral([real(signal_last_exp),imag(signal_last_exp)],8,weight_exp);
text(0,0,'exp');
[label_ng_chi2,C_ng_chi2,eigenvalue_ng_chi2]=spectral([real(signal_last_chi2),imag(signal_last_chi2)],8);
text(0,0,'chi2');
[label_my_chi2,C_my_chi2,eigenvalue_my_chi2]=myspectral([real(signal_last_chi2),imag(signal_last_chi2)],8,weight_chi2);
text(0,0,'chi2');
% [label_ng_rayl,C_ng_rayl,eigenvalue_ng_rayl]=spectral([real(signal_last_rayl),imag(signal_last_rayl)],8);
% text(0,0,'rayl');
% [label_my_rayl,C_my_rayl,eigenvalue_my_rayl]=myspectral([real(signal_last_rayl),imag(signal_last_rayl)],8,weight_rayl);
% text(0,0,'rayl');
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
% order_kmeans_norm=[2,4,8,3,1,7,6,5];
% order_ng_norm=[3,4,1,6,7,5,8,8];
% order_my_norm=[1,6,3,5,4,2,8,7];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_exp=[1,2,7,6,4,5,3,5];
% order_ng_exp=[3,8,2,1,7,4,5,5];
% order_my_exp=[8,1,4,5,3,2,6,6];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_chi2=[6,5,2,5,1,8,4,3];
% order_ng_chi2=[4,8,1,2,6,5,7,3];
% order_my_chi2=[3,8,4,2,7,1,6,5];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% order_kmeans_geo=[1,8,3,7,2,5,4,7];
% order_ng_geo=[3,2,5,4,6,8,6,1];
% order_my_geo=[4,3,4,1,8,6,5,7];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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