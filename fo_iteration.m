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
signal=load('./data_test/8QAM_20dbm_1.csv');
signal=signal*[1;1i];
 signal=signal(1:1:2048);
 %signal=signal/max(abs(signal));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal=reshape(signal,numel(signal),1);
signal=awgn(signal,50);
figure(1);
scatter(real(signal),imag(signal),'y.');
axis equal;
grid on;
title('Constellation of original signal');
% saveas(gcf,'Constellation of received signals.fig');
% saveas(gcf,'Constellation of received signals.pdf');
%Illustrate the density of original signal
figure(2);
[bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
mesh(X_ori,Y_ori,density_ori);
title('Density of original signal');
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
iteration_times=20;%iteration times to calculate frequency offset
loop_max=20;
density_buffer=Inf*ones(length(density_ori),iteration_times);%A buffer which store the density. i-th column stores the i-th density
begin=-pi/2;
stop=pi/2;
for loop=1:loop_max
for counter=1:iteration_times
    frequency_offset=begin+(counter)/iteration_times*(stop-begin);
    %fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
    signal_adjust=signal.*exp(1i*frequency_offset*(0:(length(signal)-1))');
    [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(signal_adjust),imag(signal_adjust)]);
    density_adjust_2D_1=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
    density_adjust_2D_2=ones(1,length(density_adjust))*density_adjust;%convert the density to 2D form
    density_buffer(:,counter)=(density_adjust_2D_1+transpose(density_adjust_2D_2))/2;
end
    [max_density,position]=max(max(density_buffer));
    begin=(position-1)/iteration_times*2*pi;
    stop=(position+1)/iteration_times*2*pi;
    fo=begin+(position)/iteration_times*(stop-begin);
%     fprintf(['begin=',num2str(begin),'\n']);
%     fprintf(['stop=',num2str(stop),'\n']);
    fprintf([num2str((loop_max+1-loop)),'\n']);
end

frequency_offset_adjust=(position-iteration_times/2)/iteration_times*2*pi;%position denotes the location of maxmun of frequency offset
%frequency_offset_adjust=fo;
signal_recover=signal.*exp(1i*fo*(0:(length(signal)-1))');
%Illustrate the constellation of recovered signal
figure(4);
scatter(real(signal_recover),imag(signal_recover),'y.');
axis equal;
grid on;
title(['Constellation of Recovered signal','  frequency offset=',num2str(frequency_offset_adjust),'fs']);
% saveas(gcf,'Constellation of recovered signals.fig');
% saveas(gcf,'Constellation of recovered signals.pdf');
%Illustrate the density of recovered signal
figure(5);
[bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
mesh(X_recover,Y_recover,density_recover);
title('Density of recovered signal');
grid on;
% saveas(gcf,'Estimated density of recovered signals.fig');
% saveas(gcf,'Estimated density of recovered signals.pdf');
%Illustrate the 2D density of recovered signal
% figure(6);
% density_recover_2D=density_recover*ones(length(density_ori),1);
% plot(1:length(density_recover_2D),density_recover_2D);
% title(['2D of recovered density, frequency offset=',num2str(frequency_offset_adjust),'fs']);
% grid on;
% sigma=0.1;
% w=interp2(X_recover, Y_recover, density_recover, real(signal),imag(signal), 'spline');
% weight=w*transpose(w);
% distance=distance_matrix(signal);
% A=weight.*exp(-distance.^2/2/sigma^2);
% D=diag(A*ones(numel(signal),1));
% L=diag(ones(numel(signal),1))-D^(-1/2)*A*D^(-1/2);
% eigenvalue=eig(L);
% eigenvalue=sort(eigenvalue);
% %eigenvalue=eigenvalue(end:1);
% stem(1:length(eigenvalue),eigenvalue,'y');
% title('Eigenvalue of Laplacian matrix');
% % saveas(gcf,'Eigenvalue of Laplacian matrix.fig');
% % saveas(gcf,'Eigenvalue of Laplacian matrix.pdf');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;
% close all;
% M=4;
% number_of_code=2000;
% fo_set=0;
% phase_offset=0;
% %generate the signal
% code=randi([0 M-1],number_of_code,1);
% %code=repmat([0,1,2,3]',number_of_code/4,1);
% PSK_mod=comm.PSKModulator('ModulationOrder',M);
% PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
% PSK_mod.PhaseOffset = phase_offset;
% s_PSK=step(PSK_mod,code);
% s_PSK=awgn(s_PSK,20);
% s_PSK=s_PSK.*exp(-1i*fo_set*(0:(length(s_PSK)-1))');
% signal=s_PSK;
% 
% 
% %  fip=fopen('./0806/4PSK_0.5M_1.bin');
% %  long=6000;
% %  signal=fread(fip,long,'int16');
% %  signal=reshape(signal,2,numel(signal)/2);
% %  signal=[1,1i]*signal;
% %  signal=transpose(signal);
% %  signal=signal(abs(signal)>(0.5*max(abs(signal))));
% %  signal=signal(1:1000);
% % fo=0.01*pi;
% % signal=signal.*exp(1i*fo*(0:(length(signal)-1))');
% 
% %Illustrate the constellation of original signal
% figure(1);
% scatter(real(signal),imag(signal),'y.');
% axis equal;
% grid on;
% title('Constellation of original signal');
% %Illustrate the density of original signal
% figure(2);
% [bandwidth_ori,density_ori,X_ori,Y_ori]=kde2d([real(signal),imag(signal)]);
% mesh(X_ori,Y_ori,density_ori);
% title('Density of original signal');
% grid on;
% %Illustrate the density of original signal
% figure(3);
% density_ori_2D=density_ori*ones(length(density_ori),1);
% plot(1:length(density_ori_2D),density_ori_2D);
% title('2D of original density');
% grid on;
% %iteration of frequency offset
% % iteration_times=2^4;%iteration times to calculate frequency offset
% % loop_max=20;
% % density_buffer=Inf*ones(length(density_ori),iteration_times);%A buffer which store the density. i-th column stores the i-th density
% % begin=-pi/2;
% % stop=pi/2;
% % for loop=1:loop_max
% % for counter=1:iteration_times
% %     %frequency_offset=begin+(counter)/iteration_times*(stop-begin);
% %     frequency_offset=begin+(stop-begin)/iteration_times;
% %     signal_adjust=signal.*exp(1i*frequency_offset*(0:(length(signal)-1))');
% %     [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(signal_adjust),imag(signal_adjust)]);
% %     density_adjust_2D_1=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
% %     density_adjust_2D_2=ones(1,length(density_adjust))*density_adjust;%convert the density to 2D form
% %     density_buffer(:,counter)=(density_adjust_2D_1+transpose(density_adjust_2D_2))/2;
% % end
% %     [max_density,position]=max(max(density_buffer));
% %     begin=begin+(position-1)/iteration_times*2*pi;
% %     stop=stop-(position+1)/iteration_times*2*pi;
% %     fo=(begin+stop)/2;
% % %     fprintf(['begin=',num2str(begin),'\n']);
% % %     fprintf(['stop=',num2str(stop),'\n']);
% %     fprintf([num2str((loop_max+1-loop)),'\n']);
% % end
% segment=4;%diveide every angle to 20 parts
% begin=0;%minimum angle allowed in iteration
% stop=pi/8;%maximum angle allowed in iteration
% iteration_times=20;%iteration times for calculating
% buffer=Inf*ones(segment,1);
% number=0;
% for counter=1:iteration_times
%     divide_order=(stop-begin)/segment*((1:segment)-0.5)+begin;%divide order, row vector
%     shift=((0:(numel(signal)-1))');
%     frequency_offset=exp(1i*kron(shift,divide_order));%matrix of frequency offset row is the divide order column is the signal order
%     adjust_matrix=repmat(signal,1,segment).*frequency_offset;
%     %fprintf(['counter=',num2str(counter),'\n']);
%     for i=1:segment
%         [bandwidth_adjust,density_adjust,X_adjust,Y_adjust]=kde2d([real(adjust_matrix(:,i)),imag(adjust_matrix(:,i))]);
%         density_adjust_2D_1=density_adjust*ones(length(density_adjust),1);%convert the density to 2D form
%         density_adjust_2D_2=ones(1,length(density_adjust))*density_adjust;%convert the density to 2D form
%         %criteria=max((density_adjust_2D_1+transpose(density_adjust_2D_2)))/2;
%         [~,location_1]=findpeaks(density_adjust_2D_1);
%         [~,location_2]=findpeaks(density_adjust_2D_1);
%         criteria=var(density_adjust_2D_1(location_1(1):location_1(end)))+var(density_adjust_2D_2(location_2(1):location_2(end)));
%         buffer(i)=criteria;
%         total_times=iteration_times*segment;
%         number=number+1;
%         fprintf(['Iteration has ',num2str(total_times-number),' times left','\n']);
%     end
%     [~,position]=max(buffer);
%     begin=(stop-begin)/segment*(position-1)+begin;
%     stop=(stop-begin)/segment*position+begin;
%     frequency_offset_adjust=(stop+begin)/2;
%     fo=frequency_offset_adjust;
%     fprintf(['begin=',num2str(begin),'\n']);
%     fprintf(['stop=',num2str(stop),'\n']);
%     fprintf(['fo=',num2str(fo),'\n']);
% end
% %frequency_offset_adjust=(position-iteration_times/2)/iteration_times*2*pi;%position
% %denotes the location of maxmun of frequency offset
% signal_recover=signal.*exp(1i*fo*(0:(length(signal)-1))');
% %Illustrate the constellation of recovered signal
% figure(4);
% scatter(real(signal_recover),imag(signal_recover),'y.');
% axis equal;
% grid on;
% title(['Constellation of Recovered signal','  frequency offset=',num2str(frequency_offset_adjust),'fs']);
% %Illustrate the density of recovered signal
% figure(5);
% [bandwidth_recover,density_recover,X_recover,Y_recover]=kde2d([real(signal_recover),imag(signal_recover)]);
% mesh(X_recover,Y_recover,density_recover);
% title('Density of recovered signal');
% grid on;
% %Illustrate the 2D density of recovered signal
% figure(6);
% density_recover_2D=density_recover*ones(length(density_ori),1);
% plot(1:length(density_recover_2D),density_recover_2D);
% title(['2D of recovered density, frequency offset=',num2str(frequency_offset_adjust),'fs']);
% grid on;