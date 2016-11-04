%test the received signal from E4438C
%ksdensity
clear;
close all;
iteration_times=10;%iteration times to calculate frequency offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x=-10:0.1:10;
% M=8;
% number_of_code=300;
% 
% fo=0.01*pi;
% phase_offset=0;
% %generate the signal
% code=randi([0 M-1],number_of_code,1);
% %code=repmat([0,1,2,3]',number_of_code/4,1);
% PSK_mod=comm.PSKModulator('ModulationOrder',M);
% PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
% PSK_mod.PhaseOffset = phase_offset;
% s_PSK=step(PSK_mod,code);
% s_PSK=awgn(s_PSK,15);
% %s_PSK=s_PSK.*exp(-1i*fo*(0:(length(s_PSK)-1))');
% signal=s_PSK;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load from bin files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  fip=fopen('./data_test/8PSK_30dbm_1.bin');
%  long=8000;
%  signal=fread(fip,long,'int16');
%  signal=reshape(signal,2,numel(signal)/2);
%  signal=[1,1i]*signal;
%  signal=transpose(signal);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load from csv files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal=load('./data_test/8PSK_20dbm_1.csv');
signal=signal*[1;1i];
 signal=signal(1:2048);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal=reshape(signal,numel(signal),1);
signal=signal/max(abs(signal));
%signal=awgn(signal,20);
figure(1);
scatter(real(signal),imag(signal),'y.');
axis equal;
grid on;
title('Constellation of original signal');
%Illustrate the density of original signal
% saveas(gcf,'Constellation of received signals.fig');
% saveas(gcf,'Constellation of received signals.pdf');
figure(2);
[bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
title('Density of original signal');
mesh(X_ori,Y_ori,density_ori);
grid on;
% saveas(gcf,'Estimated density of received signals.fig');
% saveas(gcf,'Estimated density of received signals.pdf');
%Illustrate the density of original signal