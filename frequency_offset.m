clear;
close all;
x=-10:0.1:10;
M=4;
number_of_code=2000;
fo=0.000;
phase_offset=0;
%code=randi([0 M-1],number_of_code,1);
code=repmat([0,1,2,3]',number_of_code/4,1);
PSK_mod=comm.PSKModulator('ModulationOrder',M);
PSK_Demod=comm.PSKDemodulator('ModulationOrder',M);
PSK_mod.PhaseOffset = phase_offset;
s_PSK=step(PSK_mod,code);
s_PSK=awgn(s_PSK,30);
signal=load('./data/qpsk_-50dBm.csv');
signal=signal(4:8:end,:)*[1;1i];
signal=s_PSK.*exp(-1i*fo*(0:(length(s_PSK)-1))');
% apply routine
figure(1);
scatter(real(signal),imag(signal),'.');
axis equal;
grid on;
title('调整前的星座图');
figure(2);
number=20;
buffer=Inf*ones(number,1);
[bandwidth,density_ori,X,Y]=kde2d([real(signal),imag(signal)]);
mesh(X,Y,density_ori);
density_2D_before=density_ori*ones(length(density_ori),1);
[pks,locs] = findpeaks(density_2D_before,'MinPeakHeight',0.5*max(density_2D_before));
select_density_before=density_2D_before(locs(1):locs(end));
title('调整前的三维图');

for times=0:1:number-1
    signal_tem=signal.*exp(1i*((times/number-0.5))*2*pi*(1:length(signal))');
    [bandwidth,density,X,Y]=kde2d([real(signal_tem),imag(signal_tem)]);
    density_2D=density*ones(length(density),1);
    [pks,locs] = findpeaks(density_2D,'MinPeakHeight',0.5*max(density_2D));
    select_density=density_2D(locs(1):locs(end));
    buffer(times+1)=abs(max(max(density)));
    fprintf([num2str(times+1),'\n']);
    fprintf(['buffer=',num2str(buffer(times+1)),'\n']);
    fprintf(['times/number-0.5=',num2str(times/number-0.5),'\n']);
end
[value,position]=max(buffer);
% plot the data and the density estimate
%surf(X,Y,density,'LineStyle','none'), view([0,70])

%a=findpeaks(density);
%b=reshape(density,numel(density),1);
%plot(1:length(b),b)
figure(3);
signal_adjust=signal.*exp(1i*((position)/number-0.5)*2*pi*(1:length(signal))');
[bandwidth,density,X,Y]=kde2d([real(signal_adjust),imag(signal_adjust)]);
mesh(X,Y,density);
title('调整后的三维图');
% plot(1:length(density),density_2D);
% hold on;
% [pks,locs] = findpeaks(density_2D,'MinPeakHeight',0.5*max(density_2D));
% text(locs+.02,pks,num2str((1:numel(pks))'));
grid on;
figure(4)
scatter(real(signal_adjust),imag(signal_adjust),'.');
title('调整后的星座图');
grid on;
axis equal;
figure(5)
plot(1:length(density),density_2D_before);
title(['调整前的2D','abs(max(select_density))=',num2str(abs(max(select_density_before)))]);
grid on;
figure(6)
plot(1:length(density),density_2D);
grid on;
title(['调整后的2D','abs(max(select_density))=',num2str(abs(max(select_density)))]);