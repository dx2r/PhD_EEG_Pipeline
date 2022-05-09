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
%Step 1: 








end