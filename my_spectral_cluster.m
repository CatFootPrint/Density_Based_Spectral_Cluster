function output=my_spectral_cluster(input,M)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[output.bandwidth,density,X,Y]=kde2d([real(input),imag(input)]);
density=density/max(max(density));
weight_inter=interp2(X, Y, density, real(input),imag(input), 'spline');
weight=weight_inter*transpose(weight_inter);
figure;
mesh(X, Y, density);
grid on;
title('density of norm');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[output.label,output.centers,output.eigenvalue]=myspectral([real(input),imag(input)],M,weight);
end