%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%name:distance_matrix
%input:input which is a vector, no matter it is row vector or column vector
%output:the L2 norm matrix, the (i,j) element of output is ||x_j-x_i||_2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output=distance_matrix(input)
    input=reshape(input,numel(input),1);%convert the vector to column column, no matter input is row vector or column vector
    input_matrix=repmat(input,1,length(input))-transpose(repmat(input,1,length(input)));%repeat the vector to column
    %input_matrix_square=input_matrix.*conj(input_matrix);%the square of L2 norm
    output=(abs(input_matrix));
end