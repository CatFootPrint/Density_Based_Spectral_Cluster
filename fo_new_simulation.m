%ksdensity
clear;
close all;
iteration_times=6000;%iteration times to calculate frequency offset
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
 %long=8000;
%  signal=fread(fip,long,'int16');
%  signal=reshape(signal,2,numel(signal)/2);
%  signal=[1,1i]*signal;
%  signal=transpose(signal);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load from csv files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% 
signal_1=load('./data_test/8QAM_20dbm_1.csv');
signal_1=signal_1*[1;1i];
signal_1=signal_1(47:(46+100*800));
 signal_1=reshape(signal_1,100,numel(signal_1)/100);
 signal_1=sum(signal_1);%%%%%%%%%%%
signal_2=load('./data_test/8QAM_20dbm_2.csv');
signal_2=signal_2*[1;1i];
signal_2=signal_2(8:1997);
 signal_2=reshape(signal_2,10,numel(signal_2)/10);
 signal_2=sum(signal_2);
 signal_3=load('./data_test/8QAM_20dbm_3.csv');
signal_3=signal_3*[1;1i];
signal_3=signal_3(4:1993);
 signal_3=reshape(signal_3,10,numel(signal_3)/10);
 signal_3=sum(signal_3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signal_1=load('./data_test/8PSK_20dbm_2.csv');
% signal_1=signal_1*[1;1i];
% signal_1=signal_1(41:(40+100*1000));
%  signal_1=reshape(signal_1,100,numel(signal_1)/100);
%  signal_1=sum(signal_1);%%%%%%%%%%%
% signal_2=load('./data_test/8PSK_20dbm_2.csv');
% signal_2=signal_2*[1;1i];
% %signal_2=signal_2(8:1997);
%  signal_2=reshape(signal_2,10,numel(signal_2)/10);
%  signal_2=sum(signal_2);
%  signal_3=load('./data_test/8PSK_20dbm_3.csv');
% signal_3=signal_3*[1;1i];
% %signal_3=signal_3(4:1993);
%  signal_3=reshape(signal_3,10,numel(signal_3)/10);
%  signal_3=sum(signal_3);
 %signal=signal/max(abs(signal));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signal=[signal_1;signal_2;signal_3];
signal=reshape(signal_1,numel(signal_1),1);
% signal=load('11.csv','-ascii');
% signal=signal*[1;1i];

%Illustrate the constellation of original signal
figure(1);
scatter(real(signal),imag(signal),'.');
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
figure(3);
density_ori_2D=density_ori*ones(length(density_ori),1);
plot(1:length(density_ori_2D),density_ori_2D);
title('2D of original density');
grid on;
%iteration of frequency offset
density_buffer=Inf*ones(length(density_ori),iteration_times);%A buffer which store the density. i-th column stores the i-th density
number=0;
for counter=1:iteration_times
    frequency_offset=(counter-iteration_times/2)/iteration_times*2*pi;
    fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
    signal_adjust=signal.*exp(1i*frequency_offset*(1:length(signal))');
    [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(signal_adjust),imag(signal_adjust)]);
    density_adjust_2D=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
    density_buffer(:,counter)=density_adjust_2D;
    number=number+1;
    fprintf(['There are ',num2str(iteration_times-number),' times for iteration','\n']);
end
[max_density,position]=max(max(density_buffer));
frequency_offset_adjust=(position-iteration_times/2)/iteration_times*2*pi;%position denotes the location of maxmun of frequency offset
signal_recover=signal.*exp(1i*frequency_offset_adjust*(1:length(signal))');
%Illustrate the constellation of recovered signal
figure(4);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
title(['Constellation of Recovered signal', ', the frequency offset is ',num2str(frequency_offset_adjust),'fs']);
%Illustrate the density of recovered signal
% saveas(gcf,'Constellation of recovered signals.fig');
% saveas(gcf,'Constellation of recovered signals.pdf');
figure(5);
[bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
title('Density of recovered signal');
mesh(X_recover,Y_recover,density_recover);
grid on;
% saveas(gcf,'Estimated density of recovered signals.fig');
% saveas(gcf,'Estimated density of recovered signals.pdf');
%Illustrate the 2D density of recovered signal
figure(6);
density_recover_2D=density_recover*ones(length(density_ori),1);
plot(1:length(density_recover_2D),density_recover_2D);
title(['2D of recovered density, frequency_offset=',num2str((position-iteration_times/2)/iteration_times*2*pi),'f_s']);
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Laplacian matrix
% sigma=0.23;
% w=interp2(X_recover, Y_recover, density_recover, real(signal),imag(signal), 'spline');
% weight=w*transpose(w);
% distance=distance_matrix(signal);
% A=weight.*exp(-distance.^2/2/sigma^2);
% % D=diag(A*ones(numel(signal),1));
% % L=1-diag(ones(numel(signal),1))-D^(-1/2)*A*D^(-1/2);
% % eigenvalue=eig(L);
% % eigenvalue=eigenvalue(end:-1:1);
% % stem(1:length(eigenvalue),eigenvalue,'y');
% % %title('Eigenvalue of Laplacian matrix');
% % save eigenvalue;
% A=A-eye(length(A));
% %D=diag(A*ones(numel(signal),1));
% D=diag(sum(A));
% L=eye(length(A))-D^(-1/2)*A*D^(-1/2);
% eigenvalue=eig(L);
% eigenvalue=sort(eigenvalue);
% %eigenvalue=eigenvalue(end:-1:1);
% %figure off;
% figure(7);
% stem(1:length(eigenvalue),eigenvalue,'.');
% title('Eigenvalue of Laplacian matrix');
% grid on;
% % saveas(gcf,'Eigenvalue of Laplacian matrix.fig');
% % saveas(gcf,'Eigenvalue of Laplacian matrix.pdf');