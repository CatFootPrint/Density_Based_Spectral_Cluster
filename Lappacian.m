%ksdensity
% clear;
% close all;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M=8;
% number_of_code=100;
% fo=0.01*pi;
% phase_offset=0;
% %generate the signal
% code=randi([0 M-1],number_of_code,1);
% %code=repmat([0,1,2,3]',number_of_code/4,1);
% PSK_mod=comm.PSKModulator('ModulationOrder',M);
% PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
% PSK_mod.PhaseOffset = phase_offset;
% s_PSK=step(PSK_mod,code);
% s_PSK=awgn(s_PSK,13);
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
% signal=load('./data_test/8PSK_30dbm_1.csv');
% signal=signal*[1;1i];
% %Illustrate the constellation of original signal
% figure(1);
% scatter(real(signal),imag(signal),'.');
% title('Constellation of signals');
% axis equal;
% grid on;
% [bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Laplacian matrix
sigma=0.25;
w=interp2(X_ori, Y_ori, density_ori, real(signal_recover),imag(signal_recover), 'spline');
weight=w*transpose(w);
distance=distance_matrix(signal_recover);
A=exp(-distance.^2/2/sigma^2);
A=A-eye(length(signal));
%D=diag(A*ones(numel(signal),1));
A=weight.*A;
D=diag(sum(A));
L=eye(length(signal_recover))-D^(-1/2)*A*D^(-1/2);
eigenvalue=eig(L);
eigenvalue=sort(eigenvalue);
%eigenvalue=eigenvalue(end:-1:1);
figure(2);
stop=16;%the area to watch eigenvalue
stem(1:length(eigenvalue(1:stop)),eigenvalue(1:stop),'.');
grid on;
title('Eigenvalue of Laplacian matrix in this paper');
text(8,eigenvalue(8)+0.015,['\downarrow',num2str(eigenvalue(8))]);
text(9,eigenvalue(9)+0.01,['\downarrow',num2str(eigenvalue(9))]);
figure(3)
A=exp(-distance.^2/2/sigma^2);
A=A-eye(length(signal_recover));
%D=diag(A*ones(numel(signal),1));
D=diag(sum(A));
L=eye(length(signal_recover))-D^(-1/2)*A*D^(-1/2);
eigenvalue=eig(L);
eigenvalue=sort(eigenvalue);
stem(1:length(eigenvalue(1:stop)),eigenvalue(1:stop),'.');
text(8,eigenvalue(8)+0.01,['\downarrow',num2str(eigenvalue(8))]);
text(9,eigenvalue(9)+0.01,['\downarrow',num2str(eigenvalue(9))]);
grid on;
title('Eigenvalue of Laplacian matrix by Ng');
%title('Eigenvalue of Laplacian matrix');
%save eigenvalue;
