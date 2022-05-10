function [line_output] = Convert_Undirected_FC_Matrix_To_Line(fc_matrix)

%%%
%
% Function that turns all useful values in an undirected FC matrix into a single line.
% Useful for statistical purposes.
%
% Gert Vanhollebeke (07/12/2021 - 07/12/2021)
%
% INPUT:
%   fc_matrix: N x N double matrix containing the FC values of an undirected FC measure.
%
% OUTPUT:
%   line_output: N x (N-1))/2 x 1 double array containing all useful FC values (extracted row by row).
%
%   Visually:
%
%   |---|---|---|---|---|
%   |   | A | B | C | D |
%   |---|---|---|---|---|
%   |   |   | E | F | G |
%   |---|---|---|---|---|
%   |   |   |   | H | I |  => (A B C D E F G H I J)
%   |---|---|---|---|---|
%   |   |   |   |   | J |
%   |---|---|---|---|---|
%   |   |   |   |   |   |
%   |---|---|---|---|---|
%
%%%

%Step 0: Tell what is going on
disp("Transforming fc matrix...");
%Step 1: build empty double array for results
brainregion_amount = size(fc_matrix,1); %square matrix, doesn't matter which dimension is taken
line_output = zeros(1,(brainregion_amount*(brainregion_amount-1))/2);
%Step 2: build line_output
counter = 1;
for n_row = 1:brainregion_amount-1
    for n_column = n_row+1:brainregion_amount
        line_output(1,counter) = fc_matrix(n_row,n_column);
        counter = counter+1;
    end
end
end