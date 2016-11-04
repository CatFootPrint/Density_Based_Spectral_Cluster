%signal power-20dbm noise -100dbm
%QAM 30db 0.000375 0.000375 0
%QAM 25db 0.0005 0.000125 0.000125
%QAM 20db 0.000125 0.000125 0.0005
%QAM 20db 0.00075 0.0005 0.000875
%QAM 15db 0.0005 0.0005 0.000875
%QAM 15db 0.0005 0.0005 0.000625
%QAM 10db 0.001 0.001 0.00225
%QAM 10db 0.002 0.00175 0.001875
%QAM 8db 0.077 0.001125 0.001
%QAM 8db 0.083375 0.001375 0.002625
%QAM 6db 0.061625 0.005625 0.004875
%QAM 6db 0.005125 0.0775 0.00475
%QAM 6db 0.057375 0.0675 0.003625
%QAM 6db 0.080125 0.0055 0.006375
%QAM 6db 0.004 0.003625 0.004125
%QAM 5db 0.0065 0.00675 0.00725
%QAM 5db 0.00625 0.0065 0.006625
%QAM 4db 0.08 0.00425 0.003875
%QAM 4db 0.0845 0.01225 0.0105
%QAM 4db 0.16675 0.009625 0.01
%QAM 2db 0.027 0.02775 0.026625
%QAM 2db 0.029 0.1395 0.23788
%QAM 2db 0.025875 0.02525 0.027125
%QAM 2db 0.031875 0.032375 0.52512
%QAM 1db 0.046375 0.097 0.04525
%QAM 1db 0.0475 0.04775 0.047125
%QAM 0db 0.0595 0.061375 0.05925
%QAM 0db 0.07075 0.07175 0.07125
%QAM 0db 0.13988 0.13012 0.069
%QAM 0db 0.071375 0.12762 0.12725
%QAM 0db 0.05825 0.059875 0.128
%QAM -1db 0.08175 0.082375 0.7875
%QAM -1db 0.0935 0.09325 0.0925
%QAM -2db 0.11425 0.119 0.11513
%QAM -2db 0.19137 0.10925 0.10713
%QAM -2db 0.11188 0.1135 0.11188
%QAM -2db 0.11388 0.11255 0.11038
%QAM -4db 0.16813 0.2355 0.16612
%QAM -4db 0.17188 0.17525 0.25
%QAM -4db 0.17988 0.2235 0.19575
%QAM -6db 0.26075 0.28113 0.219
%QAM -6db 0.23388 0.3245 0.24925
%QAM -6db 0.2925 0.24938 0.266
%QAM -8db 0.273 0.2745 0.276
%QAM -8db 0.29175 0.269 0.303
%QAM -8db 0.355 0.3125 0.31612
%QAM -8db 0.30162 0.30038 0.29125
%QAM -10db 0.33975 0.33037 0.36425
%QAM -10db 0.33137 0.31888 0.389
%QAM -10db 0.32075 0.354 0.31825
%QAM -15db 0.36038 0.39025 0.41225

%SNR=10*log10(10e-8+1)-10*log10(10e-6-10e-8);
% diff=abs(length(A1)-length(a4))+abs(length(A2)-length(a8))+abs(length(A3)-length(a3))+abs(length(A4)-length(a1))+abs(length(A5)-length(a7))+abs(length(A6)-length(a6))+abs(length(A7)-length(a5))+abs(length(A8)-length(a2));ratio=diff/8000;fprintf(['ratio is ',num2str(ratio),'\n']);
% diff_ng=abs(length(A1)-length(a1_ng))+abs(length(A2)-length(a7_ng))+abs(length(A3)-length(a6_ng))+abs(length(A4)-length(a5_ng))+abs(length(A5)-length(a2_ng))+abs(length(A6)-length(a4_ng))+abs(length(A7)-length(a8_ng))+abs(length(A8)-length(a3_ng));ratio_ng=diff_ng/8000;fprintf(['ratio of Ng is ',num2str(ratio_ng),'\n']);
% diff_my=abs(length(A1)-length(a5_my))+abs(length(A2)-length(a1_my))+abs(length(A3)-length(a3_my))+abs(length(A4)-length(a8_my))+abs(length(A5)-length(a6_my))+abs(length(A6)-length(a7_my))+abs(length(A7)-length(a4_my))+abs(length(A8)-length(a2_my));ratio_my=diff_my/8000;fprintf(['ratio of me is ',num2str(ratio_my),'\n']);
% 
snr=20;
close all;
signal_recover=signal_recover(1:1000);
po=mean(angle(signal_recover));
signal_last=signal_recover*exp(-1i*(po+pi/2));

% signal_last=[signal_last;signal_last([5;6;10;21;25;29;53;57;58;82;87;88;89;101;112;123;131;132;135;141;153;155;156;157;160;169;176;187;191;210;258;262;263;279;300;312;317;330;338;342;346;371;381;391;397;402]);...
% signal_last([16;19;24;34;54;60;74;98;121;124;134;137;139;145;151;161;162;166;167;174;186;188;197;203;215;233;251]);...
% signal_last([2;18;26;32;43;44;45;46;51;64;65;71;73;75;80;93;99;108;111;125;146;149;164;175;184;185;219]);...
% signal_last([12;15;55;83;85;90;92;94;95;102;107;128;129;159;178;179;181;189;193;194;198;204;205;206;209;216;218;221;228;235;236;245;249;254;281;284;285;290]);...
% signal_last([9;20;31;33;36;39;41;49;50;66;67;70;79;105;110;120;130;133;136;140;150;168;172;190;201;213;222;224;237;239;243;246;250;252;255]);...
% signal_last([3;4;17;23;28;47;59;77;86;96;103;104;114;117;119;126;142;143;148]);...
% signal_last([1;7;8;13;14;22;27;37;42;48;52;56;61;62;63;69;76;84;91;97;100;106;113;127])];
%signal_last=repmat(signal_last,2,1);
signal_last=awgn(signal_last,snr);
%signal_last=repmat((1:8)'+1i*(1:8)',4,1);

QAM=load('signal_8QAM.mat');
PSK=load('signal_8PSK.mat');
QAM=QAM.signal;
PSK=PSK.signal;
%QAM_mod=comm.RectangularQAMModulator('ModulationOrder',M);
%PSK_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
PSK_Demod = comm.PSKDemodulator('ModulationOrder',8);
label_PSK= step(PSK_Demod,PSK);
%QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
%label_QAM= step(QAM_Demod,QAM);
label_QAM=load('label_my.csv','-ascii');
times=10;
ratio_av=0;
ratio_ng_av=0;
ratio_my_av=0;
%for counter=1:times
%fprintf(['The ',num2str(counter),' times iteration.','\n']);
[label,center]=kmeans([real(signal_last),imag(signal_last)],8);
hold on;
h1=scatter(real(signal_last((label==1))),imag(signal_last((label==1))),'yo');
h2=scatter(real(signal_last((label==2))),imag(signal_last((label==2))),'y+');
h3=scatter(real(signal_last((label==3))),imag(signal_last((label==3))),'g*');
h4=scatter(real(signal_last((label==4))),imag(signal_last((label==4))),'gv');
h5=scatter(real(signal_last((label==5))),imag(signal_last((label==5))),'cx');
h6=scatter(real(signal_last((label==6))),imag(signal_last((label==6))),'cs');
h7=scatter(real(signal_last((label==7))),imag(signal_last((label==7))),'md');
h8=scatter(real(signal_last((label==8))),imag(signal_last((label==8))),'mp');
hold on;
axis equal;
h9=scatter((center(:,1)),(center(:,2)),'r');
text(center(1,1),center(1,2),'1');
text(center(2,1),center(2,2),'2');
text(center(3,1),center(3,2),'3');
text(center(4,1),center(4,2),'4');
text(center(5,1),center(5,2),'5');
text(center(6,1),center(6,2),'6');
text(center(7,1),center(7,2),'7');
text(center(8,1),center(8,2),'8');
legend([h1,h9],'Signals','Estimated centers');
grid on;



% figure;
% QAM_mod=comm.RectangularQAMModulator('ModulationOrder',8);
%         QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
%         s_QAM=step(QAM_mod,(0:7)');
% h10=scatter(real(s_QAM),imag(s_QAM),'y.');
% hold on;
% axis equal;
% text(real(s_QAM(1)),imag(s_QAM(1)),'0');
% text(real(s_QAM(2)),imag(s_QAM(2)),'1');
% text(real(s_QAM(3)),imag(s_QAM(3)),'2');
% text(real(s_QAM(4)),imag(s_QAM(4)),'3');
% text(real(s_QAM(5)),imag(s_QAM(5)),'4');
% text(real(s_QAM(6)),imag(s_QAM(6)),'5');
% text(real(s_QAM(7)),imag(s_QAM(7)),'6');
% text(real(s_QAM(8)),imag(s_QAM(8)),'7');



%Ratio
a1=find(label==1);
a2=find(label==2);
a3=find(label==3);
a4=find(label==4);
a5=find(label==5);
a6=find(label==6);
a7=find(label==7);
a8=find(label==8);
A1=find(label_QAM==0);
A2=find(label_QAM==1);
A3=find(label_QAM==2);
A4=find(label_QAM==3);
A5=find(label_QAM==4);
A6=find(label_QAM==5);
A7=find(label_QAM==6);
A8=find(label_QAM==7);
%%%%%%%%%%%%%%%%%%
sigma=2;
[bandwidth_last,density_last,X_last,Y_last]=kde2d([real(signal_last),imag(signal_last)]);
density_last=density_last/max(max(density_last));
w=interp2(X_last, Y_last, density_last, real(signal_last),imag(signal_last), 'spline');
weight=w*transpose(w);
% distance=distance_matrix(signal_last);
% 
% A=exp(-distance.^2/2/sigma^2);
% %save('distance.csv','A','-ascii');
% A=A-eye(length(A));
% 
% %D=diag(A*ones(numel(signal),1));
% 
% A_ng=A;
% %A_my=weight.*A;
% D_ng=diag(A_ng*ones(length(A_ng),1));
% D_my=diag(A_my*ones(length(A_my),1));
% L_ng=eye(length(A_ng))-D_ng^(-1/2)*A_ng*D_ng^(-1/2);
% L_my=eye(length(A_my))-D_my^(-1/2)*A_my*D_my^(-1/2);
% save('L.csv','L_ng','-ascii');
% [u_ng,eigenvalue_ng]=eig(L_ng);
% [u_my,eigenvalue_my]=eig(L_my);
% eigenvalue_ng=diag(eigenvalue_ng);
% eigenvalue_my=diag(eigenvalue_my);
% eigenvalue_ng=sort(eigenvalue_ng);
% eigenvalue_my=sort(eigenvalue_my);
% X_ng=[u_ng(:,length(u_ng)),u_ng(:,length(u_ng)-1),...
%     u_ng(:,length(u_ng)-2),u_ng(:,length(u_ng)-3),...
%     u_ng(:,length(u_ng)-4),u_ng(:,length(u_ng)-5),...
%     u_ng(:,length(u_ng)-6),u_ng(:,length(u_ng)-7)];
% am_ng=sqrt((abs(X_ng)).^2*ones(8,1));
% X_ng=X_ng./repmat(am_ng,1,8);
% X_my=[u_my(:,length(u_my)),u_my(:,length(u_my)-1),...
%     u_my(:,length(u_my)-2),u_my(:,length(u_my)-3),...
%     u_my(:,length(u_my)-4),u_my(:,length(u_my)-5),...
%     u_my(:,length(u_my)-6),u_my(:,length(u_my)-7)];
% am_my=sqrt((abs(X_my)).^2*ones(8,1));
% X_my=X_my./repmat(am_my,1,8);
% [label_ng,~]=kmeans(X_ng,8);
% [label_my,~]=kmeans(X_my,8);

% center_ng=[real(mean(signal_last(a1_ng))),imag(mean(signal_last(a1_ng)));...
%     real(mean(signal_last(a2_ng))),imag(mean(signal_last(a2_ng)));...
%     real(mean(signal_last(a3_ng))),imag(mean(signal_last(a3_ng)));...
%     real(mean(signal_last(a4_ng))),imag(mean(signal_last(a4_ng)));...
%     real(mean(signal_last(a5_ng))),imag(mean(signal_last(a5_ng)));...
%     real(mean(signal_last(a6_ng))),imag(mean(signal_last(a6_ng)));...
%     real(mean(signal_last(a7_ng))),imag(mean(signal_last(a7_ng)));...
%     real(mean(signal_last(a8_ng))),imag(mean(signal_last(a8_ng)))];
% center_my=[real(mean(signal_last(a1_my))),imag(mean(signal_last(a1_my)));...
%     real(mean(signal_last(a2_my))),imag(mean(signal_last(a2_my)));...
%     real(mean(signal_last(a3_my))),imag(mean(signal_last(a3_my)));...
%     real(mean(signal_last(a4_my))),imag(mean(signal_last(a4_my)));...
%     real(mean(signal_last(a5_my))),imag(mean(signal_last(a5_my)));...
%     real(mean(signal_last(a6_my))),imag(mean(signal_last(a6_my)));...
%     real(mean(signal_last(a7_my))),imag(mean(signal_last(a7_my)));...
%     real(mean(signal_last(a8_my))),imag(mean(signal_last(a8_my)))];
% figure;
% scatter(center_ng(:,1),center_ng(:,2),'.');
% hold on;
% scatter(real(signal_last(a1_ng)),imag(signal_last(a1_ng)),'r.');
% hold on;
% scatter(real(signal_last(a2_ng)),imag(signal_last(a2_ng)),'y.');
% hold on;
% scatter(real(signal_last(a3_ng)),imag(signal_last(a3_ng)),'g.');
% hold on;
% scatter(real(signal_last(a4_ng)),imag(signal_last(a4_ng)),'b.');
% hold on;
% scatter(real(signal_last(a5_ng)),imag(signal_last(a5_ng)),'c.');
% hold on;
% scatter(real(signal_last(a6_ng)),imag(signal_last(a6_ng)),'m.');
% hold on;
% scatter(real(signal_last(a7_ng)),imag(signal_last(a7_ng)),'r+');
% hold on;
% scatter(real(signal_last(a8_ng)),imag(signal_last(a8_ng)),'y+');
% hold on;
% grid on;
% axis equal;
% title('Spectral cluster by Ng');
% text(center_ng(1,1),center_ng(1,2),'1');
% text(center_ng(2,1),center_ng(2,2),'2');
% text(center_ng(3,1),center_ng(3,2),'3');
% text(center_ng(4,1),center_ng(4,2),'4');
% text(center_ng(5,1),center_ng(5,2),'5');
% text(center_ng(6,1),center_ng(6,2),'6');
% text(center_ng(7,1),center_ng(7,2),'7');
% text(center_ng(8,1),center_ng(8,2),'8');
% figure;
% scatter(center_my(:,1),center_my(:,2),'.');
% hold on;
% scatter(real(signal_last(a1_my)),imag(signal_last(a1_my)),'r.');
% hold on;
% scatter(real(signal                                                                                                                                                                                                                         _last(a2_my)),imag(signal_last(a2_my)),'y.');
% hold on;
% scatter(real(signal_last(a3_my)),imag(signal_last(a3_my)),'g.');
% hold on;
% scatter(real(signal_last(a4_my)),imag(signal_last(a4_my)),'b.');
% hold on;
% scatter(real(signal_last(a5_my)),imag(signal_last(a5_my)),'c.');
% hold on;
% scatter(real(signal_last(a6_my)),imag(signal_last(a6_my)),'m.');
% hold on;
% scatter(real(signal_last(a7_my)),imag(signal_last(a7_my)),'r+');
% hold on;
% scatter(real(signal_last(a8_my)),imag(signal_last(a8_my)),'y+');
% hold on;
% grid on;
% axis equal;
% title('Spectral cluster by me');
% text(center_my(1,1),center_my(1,2),'1');
% text(center_my(2,1),center_my(2,2),'2');
% text(center_my(3,1),center_my(3,2),'3');
% text(center_my(4,1),center_my(4,2),'4');
% text(center_my(5,1),center_my(5,2),'5');
% text(center_my(6,1),center_my(6,2),'6');
% text(center_my(7,1),center_my(7,2),'7');
% text(center_my(8,1),center_my(8,2),'8');

[label_ng,C_ng,eigenvalue_ng]=spectral([real(signal_last),imag(signal_last)],8);
[label_my,C_my,eigenvalue_my]=myspectral([real(signal_last),imag(signal_last)],8,weight);
a1_ng=find(label_ng==1);
a2_ng=find(label_ng==2);
a3_ng=find(label_ng==3);
a4_ng=find(label_ng==4);
a5_ng=find(label_ng==5);
a6_ng=find(label_ng==6);
a7_ng=find(label_ng==7);
a8_ng=find(label_ng==8);
% A1_ng=find(label_QAM_ng==0);
% A2_ng=find(label_QAM_ng==1);
% A3_ng=find(label_QAM_ng==2);
% A4_ng=find(label_QAM_ng==3);
% A5_ng=find(label_QAM_ng==4);
% A6_ng=find(label_QAM_ng==5);
% A7_ng=find(label_QAM_ng==6);
% A8_ng=find(label_QAM_ng==7);


a1_my=find(label_my==1);
a2_my=find(label_my==2);
a3_my=find(label_my==3);
a4_my=find(label_my==4);
a5_my=find(label_my==5);
a6_my=find(label_my==6);
a7_my=find(label_my==7);
a8_my=find(label_my==8);
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
% order_kmeans=[7,3,1,6,5,8,4,2];
% order_ng=[7,2,3,1,4,5,6,8];
% order_my=[5,4,2,6,8,1,3,7];
% label=(label==order_kmeans(1))+2*(label==order_kmeans(2))+3*(label==order_kmeans(3))+4*(label==order_kmeans(4))+...,
%     5*(label==order_kmeans(5))+6*(label==order_kmeans(6))+7*(label==order_kmeans(7))+8*(label==order_kmeans(8));
% label_ng=(label_ng==order_ng(1))+2*(label_ng==order_ng(2))+3*(label_ng==order_ng(3))+4*(label_ng==order_ng(4))+...
%     5*(label_ng==order_ng(5))+6*(label_ng==order_ng(6))+7*(label_ng==order_ng(7))+8*(label_ng==order_ng(8));
% label_my=(label_my==order_my(1))+2*(label_my==order_my(2))+3*(label_my==order_my(3))+4*(label_my==order_my(4))+...
%     5*(label_my==order_my(5))+6*(label_my==order_my(6))+7*(label_my==order_my(7))+8*(label_my==order_my(8));
% [~,ratio_kmeans]=biterr(label_QAM,label);
% [~,ratio_ng]=biterr(label_QAM,label_ng);
% [~,ratio_my]=biterr(label_QAM,label_my);
% fprintf(['ratio is ',num2str(ratio_kmeans),'\n']);
% fprintf(['ratio of Ng is ',num2str(ratio_ng),'\n']);
% fprintf(['ratio of mine is ',num2str(ratio_my),'\n']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x1=[0.32075;
%     0.29;
%     0.26075;
%     0.20988;
%     0.11425;
%     0.082375;
%     0.07075;
%     0.0595;
%     0.025875;
%     0.016675;
%     0.0061625;
%     0.005125;
%     0.001;
%     0.00075;
%     0.0005125;
%     0.000375;
%     0.00125];
% x2=[0.31888;
%     0.28;
%     0.25;
%     0.19525;
%     0.09325;
%     0.07875;
%     0.059875;
%     0.04775;
%     0.027125;
%     0.009625;
%     0.003625;
%     0.001125;
%     0.0011;
%     0.000625;
%     0.000225;
%     0.000125;
%     0
%     ];
% x3=[0.31125;
% 0.275;
% 0.239;
% 0.15612;
% 0.0925;
% 0.07125;
% 0.0475;
% 0.047125;
% 0.02525;
% 0.00845;
% 0.002625;
% 0.001;
% 0.000875;
% 0.0005;
% 0.000125;
% 0.000125;
% 0
% ];
% figure;plot(t,x1);hold on;plot(t,x2);hold on;plot(t,x3);hold on;scatter(t,x1,'p');hold on;plot(t,x2,'x');hold on;plot(t,x3,'*');hold on;grid on;





% A1_my=find(label_QAM_my==0);
% A2_my=find(label_QAM_my==1);
% A3_my=find(label_QAM_my==2);
% A4_my=find(label_QAM_my==3);
% A5_my=find(label_QAM_my==4);
% A6_my=find(label_QAM_my==5);
% A7_my=find(label_QAM_my==6);
% A8_my=find(label_QAM_my==7);
%QAM_mod.PhaseOffset = phase_offset;
%s_QAM=step(QAM_mod,code);
%signal=s_QAM;