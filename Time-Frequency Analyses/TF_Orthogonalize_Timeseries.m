function [orthogonal_timeseries] = TF_Orthogonalize_Timeseries(timeseries)

%%%
% 
% Function that return two orthogonal timeseries when given two non-orthogonal timeseries.
% Note: this orthogonalzstation is not symmetric (eg. func([sig1 , sig2] != func([sig2, sig1]))
% so for correct analysis this function should be run twice with mirrored timeseries.
%
% Algorithm based on the Gram-Schmidt Orthogonalisation (code based on function of Reza Ahmadzadeh).
% link: https://www.mathworks.com/matlabcentral/fileexchange/51467-stabilized-gram-schmidt-orthonormal-method
%
% Gert Vanhollebeke (03/05/2022 - 03/05/2022)
%
% INPUT: 
%   timeseries: Nx2 matrix containing two timeseries of length N
%
% OUTPUT:
%   orthogonal_timeseries: Nx2 matrix containing two orthgonal timeseries of length N
%
%%%
%obtain data and datasizes
[timeseries_length, timeseries_amount] = size(timeseries);
timeseries_1 = timeseries(:,1);
timeseries_2 = timeseries(:,2);
%Step 0: check if only two timeseries are given
assert(timeseries_amount==2, 'Only two timeseries should be given as input. If orthogonalisation of more timeseries is wanted, use "TF_Orthogonalise_Multiple_Timeseries.m" instead.');
%Step 1: get unit vector of first timeseries by dividing it by its norm.
timeseries_1 = timeseries_1/norm(timeseries_1);
%Step 2: obtain orthogonalized version of second timeseries by subtracting the projection of the first to the second timeseries
timeseries_2 = timeseries_2 - (dot(timeseries_2, timeseries_1) / dot(timeseries_1, timeseries_1)) * timeseries_1;
%Step 3: get unit vector of timeseries (similar to Step 1)
timeseries_2 = timeseries_2/norm(timeseries_2);
%Step 4: return orthogonalized timeseries
orthogonal_timeseries = [timeseries_1 , timeseries_2];
end