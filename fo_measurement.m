clear;
close all;
x=-10:0.1:10;
% %simulation
% M=4;
% number_of_code=2000;
% fo=0.1*pi;
% phase_offset=0;
% %generate the signal
% code=randi([0 M-1],number_of_code,1);
% %code=repmat([0,1,2,3]',number_of_code/4,1);
% PSK_mod=comm.PSKModulator('ModulationOrder',M);
% PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
% PSK_mod.PhaseOffset = phase_offset;
% s_PSK=step(PSK_mod,code);
% s_PSK=awgn(s_PSK,15);
% s_PSK=s_PSK.*exp(-1i*fo*(0:(length(s_PSK)-1))');
% signal=s_PSK;
%load the real data
signal=load('./data/qpsk_-30dBm.csv');
signal=signal*[1;1i];
signal=signal(1:16:end/16);
%Illustrate the constellation of original signal
figure(1);
scatter(real(signal),imag(signal),'.');
axis equal;
grid on;
title('Constellation of original signal');
%Illustrate the density of original signal
figure(2);
[bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
mesh(X_ori,Y_ori,density_ori);
grid on;
title('Density of original signal');
%Illustrate the density of original signal
figure(3);
density_ori_2D=density_ori*ones(length(density_ori),1);
plot(1:length(density_ori_2D),density_ori_2D);
title('2D of original density');
grid on;
%iteration of frequency offset
    iteration_times=100;%iteration times to calculate frequency offset
    density_buffer=Inf*ones(length(density_ori),iteration_times);%A buffer which store the density. i-th column stores the i-th density
    density_buffer_1=Inf*ones(iteration_times,1);
    density_buffer_2=Inf*ones(iteration_times,1);
    for counter=1:iteration_times
        frequency_offset=(counter-iteration_times/2)/iteration_times*2*pi;
        %fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
        signal_adjust=signal.*exp(1i*frequency_offset*(0:(length(signal)-1))');
        [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(signal_adjust),imag(signal_adjust)]);
        density_adjust_2D_1=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
        density_adjust_2D_2=ones(1,length(density_adjust))*density_adjust;%convert the density to 2D form
        density_buffer(:,counter)=density_adjust_2D_1;
        [peaks_adjust,location_adjust] = findpeaks(density_adjust_2D_1,'MinPeakHeight',0.5*max(density_adjust_2D_1));
        density_adjust_2D_main_1=density_adjust_2D_1(location_adjust(1):location_adjust(end));
        density_adjust_2D_main_2=density_adjust_2D_2(location_adjust(1):location_adjust(end));
        density_buffer_1(counter)=abs(max(density_adjust_2D_main_1)/min(density_adjust_2D_main_1));
        density_buffer_2(counter)=abs(max(density_adjust_2D_main_2)/min(density_adjust_2D_main_2));
    end
[max_density,position]=max(density_buffer_1+density_buffer_2);
frequency_offset_adjust=(position-iteration_times/2)/iteration_times*2*pi;%position denotes the location of maxmun of frequency offset
signal_recover=signal.*exp(1i*frequency_offset_adjust*(0:(length(signal)-1))');
%Illustrate the constellation of recovered signal
figure(4);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
title('Constellation of Recovered signal');
%Illustrate the density of recovered signal
figure(5);
[bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
mesh(X_recover,Y_recover,density_recover);
grid on;
title('Density of recovered signal');
%Illustrate the 2D density of recovered signal
figure(6);
density_recover_2D=density_recover*ones(length(density_ori),1);
plot(1:length(density_recover_2D),density_recover_2D);
grid on;
title(['2D of recovered density, frequency offset=',num2str((position-iteration_times/2)/iteration_times*2*pi),' f_s']);