clear;
close all;
snr_rayl=[-20;
    -15;
    -10;
    -8;
    -6;
    -5;
    -4;
    -3;
    -2;
    -1;
    0;
    1;
    2;
    4;
    6;
    8;
    10;%
    15;
    20;
    25;
    30;
    ];
rayl_kmeans=[0.40;%-20
    0.395;%-15
    0.37525;%%-10:0.3615
    0.3495;%-8
    0.31075;%-6
    0.295759;%-5:0.32975 0.303
    0.28125;%-4
    0.26025;%-3:0.28175
    0.24375;%-2
    0.21925;%-1
    0.193;%0:0.17325
    0.1565;% :0.116
    0.118;%2:0.2155: 0.20975
    0.08075;%4
    0.06175;%6
    0.0545;%8
    0.051;%10
    0.0505;%
    0.050;%
    0.0495;%
    0.049;%
    ];
rayl_ng=[0.4;%-20
    0.395;%-15
    0.37525;%-10:0.35325
    0.34675;%-8
    0.3085;%-6
    0.2915;%-5:0.2915 0.2875
    0.2735;%-4
    0.2505;%-3:0.26275
    0.23125;%-2
    0.20375;%-1
    0.1725;%0:0.1895
    0.13575;%1:0.17925
    0.1015;%2:0.134
    0.073;%4
    0.0565;%6
    0.054;%8
    0.051;%10
        0.0505;%
    0.050;%
    0.0495;%
    0.049;%
    ];
rayl_my=[0.4;%-20
    0.395;%-15
    0.37525;%-10:0.36475
    0.34575;%-8
    0.30425;%-6
    0.2855;%-5:0.2885 0.32625
    0.2635;%-4
    0.24025;%-3:0.3015
    0.215;%-2
    0.18575;%-1
    0.15275;%0:0.165
    0.124;%1:0.124 0.16215
    0.0935;%2:0.1035
    0.07025;%4
    0.05525;%6
    0.05325;%8
    0.051;%10
        0.0505;%
    0.050;%
    0.0495;%
    0.049;%
    ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
snr_norm=[-20;
    -15;
    -10;
    -8;
    -6;
    -5;
    -4;
    -3;
    -2;
    -1;
    0;
    1;
    2;
    3;
    4;
    6;
    8;
    10;%
    15;
    20;
    25;
    30;
    ];
norm_kmeans=[0.40;%-20
    0.385;%-15
    0.34525;%%-10:0.3615
    0.3285;%-8
    0.301;%-6
    0.28175;%-5:0.32975 0.303
    0.26475;%-4 0.28125
    0.23675;%-3:0.28175
    0.21325;%-2
    0.1945;%-1
    0.16825;%0:0.217 0.16825
    0.145;% :1:0.116
    0.12175;%2:0.2155: 0.20975
    0.10775;%3
    0.098;%4
    0.07925;%6
    0.06435;%8
    0.058;%10
    0.0551;%15
    0.0535;%20
    0.0512;%25
    0.0497;%30
    ];
norm_ng=[0.4;%-20
    0.385;%-15
    0.34525;%-10:0.35325
    0.3255;%-8
    0.295;%-6
    0.274;%-5:0.2915 0.2875
    0.254;%-4 0.2735
    0.22675;%-3:0.26275
    0.20375;%-2
    0.18275;%-1
    0.156;%0:0.24375 0.3675 0.199
    0.13475;%1:0.17925
    0.11125;%2:0.134
    0.09725;%3
    0.089;%4
    0.07185;%6
    0.06185;%8
    0.0555;%10
        0.05415;%15
    0.05325;%20
    0.0511;%25
    0.0496;%30
    ];
norm_my=[0.4;%-20
    0.385;%-15
    0.34525;%-10:0.36475
    0.3245;%-8
    0.292;%-6
    0.26875;%-5:0.2885 0.32625
    0.2465;%-4:0.2895
    0.21875;%-3:0.3015
    0.19485;%-2
    0.16875;%-1
    0.141;%0:0.208 0.09675 0.19825
    0.11875;%1:
    0.103;%2:0.1035
    0.09025;%3
    0.0815;%4
    0.0675;%6
    0.06055;%8:0.057
    0.05425;%10
        0.05325;%15
    0.0525;%20
    0.0500;%
    0.0495;%
    ];
snr_chi2=[-20;
    -15;
    -10;
    -8;
    -6;
%     -5;
    -4;
    -3;
    -2;
    -1;
    0;
    1;
    2;
    3;
    4;
    6;
    8;
    10;%
    15;
    20;
    25;
    30;
    ];
chi2_kmeans=[0.4;%-20
    0.3985;%-15
    0.39075;%-10
    0.36755;%-8
    0.326;%-6
    0.28575;%-4
    0.265;%-3
    0.243;%-2:0.249
    0.22225;%-1
    0.199;%0
    0.1755;%1
    0.14775;%2
    0.121;%3
    0.1025;%4
    0.075;%6
    0.06;%8
    0.05375;%10
    0.04625;%15
    0.0455;%
    0.0453;
    0.0452;
    ];
chi2_ng=[0.4;%-20
    0.3985;%-15
    0.39075;%-10
    0.367525;%-8
    0.32575;%-6
    0.28075;%-4
    0.25475;%-3
    0.23025;%-2
    0.20875;%-1
    0.18175;%0
    0.15265;%1
    0.1275;%2
    0.10825;%3
    0.093;%4
    0.07175;%6
    0.0585;%8
    0.053;%10
    0.046;%15
        0.0455;%
    0.0453;
    0.0452;
    ];
chi2_my=[0.4;%-20
    0.3985;%-15
    0.39075;%-10
    0.3675;%-8
    0.32525;%-6
    0.27475;%-4
    0.2485;%-3
    0.22525;%-2:0.27525
    0.19875;%-1
    0.17175;%0
    0.14025;%1
    0.1105;%2
    0.09575;%3
    0.0825;%4
    0.06675;%6
    0.05525;%8
    0.0510;%10
    0.045;%15
        0.0455;%
    0.0453;
    0.0452;
    ];
figure;
subplot(1,3,1);
grid on;
hold on;
x1=xlabel('$\mathrm{SNR(dB)}$');
y1=ylabel('$\mathrm{BER}$');
set(x1,'Interpreter','latex');
set(y1,'Interpreter','latex');
%set(x1,'Interpreter','latex');
%set(y1,'Interpreter','latex');
rayl1=plot(snr_rayl(1:end),rayl_kmeans(1:end),'y-p');
rayl2=plot(snr_rayl(1:end),rayl_ng(1:end),'m-s');
rayl3=plot(snr_rayl(1:end),rayl_my(1:end),'g-d');
t1=text(-4,0.3,'$\leftarrow \left.R\left(\sigma\right)\right|_{\sigma=7.0186\times10^{-4}}$','FontSize',12);
set(t1,'Interpreter','latex');
legend([rayl1,rayl2,rayl3],'k-means','Ng','DIBSC');
% set(gca,'yscale','log');%将Y轴刻度设为对数
subplot(1,3,2);
grid on;
hold on;
norm1=plot(snr_norm(1:end),norm_kmeans(1:end),'y-p');
norm2=plot(snr_norm(1:end),norm_ng(1:end),'m-s');
norm3=plot(snr_norm(1:end),norm_my(1:end),'g-d');
t2=text(-4.5,0.3,'$\leftarrow \left.N\left(\mu,\sigma^2\right)\right|_{\mu=0,\sigma=6.1504\times 10^{-4}}$','FontSize',12);
set(t2,'Interpreter','latex');
x2=xlabel('$\mathrm{SNR(dB)}$');
y2=ylabel('$\mathrm{BER}$');
set(x2,'Interpreter','latex');
set(y2,'Interpreter','latex');
% x2=xlabel('$\mathrm{dB}$');
% y2=ylabel('$\mathrm{BER}$');
% set(x2,'Interpreter','latex');
% set(y2,'Interpreter','latex');
legend([norm1,norm2,norm3],'k-means','Ng','DIBSC');
% set(gca,'yscale','log');%将Y轴刻度设为对数
subplot(1,3,3);
grid on;
hold on;
chi21=plot(snr_chi2(1:end),chi2_kmeans(1:end),'y-p');
chi22=plot(snr_chi2(1:end),chi2_ng(1:end),'m-s');
chi23=plot(snr_chi2(1:end),chi2_my(1:end),'g-d');
t3=text(-4,0.3,'$\leftarrow \left.G\left(\alpha,\beta\right)\right|_{\alpha=0.0113,\beta=2}$','FontSize',12);
set(t3,'Interpreter','latex');
x3=xlabel('$\mathrm{SNR(dB)}$');
y3=ylabel('$\mathrm{BER}$');
set(x3,'Interpreter','latex');
set(y3,'Interpreter','latex');
% x3=xlabel('$\mathrm{dB}$');
% y3=ylabel('$\mathrm{BER}$');
% set(x3,'Interpreter','latex');
% set(y3,'Interpreter','latex');
legend([chi21,chi22,chi23],'k-means','Ng','DIBSC');
% set(gca,'yscale','log');%将Y轴刻度设为对数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
% subplot(1,3,1);
hold on;
rayl1=semilogy(snr_rayl(3:end-3),rayl_kmeans(3:end-3),'y-p');%,snr_rayl(1:end),rayl_ng(1:end),'m-s',snr_rayl(1:end),rayl_my(1:end),'g-d');
rayl2=semilogy(snr_rayl(3:end-3),rayl_ng(3:end-3),'m-s');
rayl3=semilogy(snr_rayl(3:end-3),rayl_my(3:end-3),'g-d');
% set(gca,'yscale','log');%将Y轴刻度设为对数
grid on;
% set(t1,'Interpreter','latex');
% legend([rayl1,rayl2,rayl3],'k-means','Ng','DIBSC');
t1=text(-4,0.3,'$\leftarrow \left.R\left(\sigma\right)\right|_{\sigma=7.0186\times10^{-4}}$','FontSize',12);
legend('k-means','Ng','DIBSC');
x1=xlabel('$\mathrm{SNR(dB)}$');
y1=ylabel('$\mathrm{BER}$');
set(x1,'Interpreter','latex');
set(y1,'Interpreter','latex');
set(t1,'Interpreter','latex');
% set(gca,'yscale','log');%将Y轴刻度设为对数
%subplot(1,3,2);
figure;
grid on;
hold on;
norm1=plot(snr_norm(3:end-3),norm_kmeans(3:end-3),'y-p');
norm2=plot(snr_norm(3:end-3),norm_ng(3:end-3),'m-s');
norm3=plot(snr_norm(3:end-3),norm_my(3:end-3),'g-d');
t2=text(-4.5,0.3,'$\leftarrow \left.N\left(\mu,\sigma^2\right)\right|_{\mu=0,\sigma=6.1504\times 10^{-4}}$','FontSize',12);
set(t2,'Interpreter','latex');
x2=xlabel('$\mathrm{SNR(dB)}$');
y2=ylabel('$\mathrm{BER}$');
set(x2,'Interpreter','latex');
set(y2,'Interpreter','latex');
% x2=xlabel('$\mathrm{dB}$');
% y2=ylabel('$\mathrm{BER}$');
% set(x2,'Interpreter','latex');
% set(y2,'Interpreter','latex');
legend([norm1,norm2,norm3],'k-means','Ng','DIBSC');
% subplot(1,3,3);
% set(gca,'yscale','log');%将Y轴刻度设为对数
figure;
grid on;
hold on;
chi21=plot(snr_chi2(3:end-3),chi2_kmeans(3:end-3),'y-p');
chi22=plot(snr_chi2(3:end-3),chi2_ng(3:end-3),'m-s');
chi23=plot(snr_chi2(3:end-3),chi2_my(3:end-3),'g-d');
t3=text(-4,0.3,'$\leftarrow \left.G\left(\alpha,\beta\right)\right|_{\alpha=0.0113,\beta=2}$','FontSize',12);
set(t3,'Interpreter','latex');
x3=xlabel('$\mathrm{SNR(dB)}$');
y3=ylabel('$\mathrm{BER}$');
set(x3,'Interpreter','latex');
set(y3,'Interpreter','latex');
% x3=xlabel('$\mathrm{dB}$');
% y3=ylabel('$\mathrm{BER}$');
% set(x3,'Interpreter','latex');
% set(y3,'Interpreter','latex');
legend([chi21,chi22,chi23],'k-means','Ng','DIBSC');
% set(gca,'yscale','log');%将Y轴刻度设为对数