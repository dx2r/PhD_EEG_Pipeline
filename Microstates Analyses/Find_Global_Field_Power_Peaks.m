function [gfp_peaks_indices] = Find_Global_Field_Power_Peaks(gfp_values,thresh)

%%%
% Function that ...
% 
% Lore Flipts
%
% INPUT:
%   
%
% OUTPUT:
%   
%
%%%
[gfp_peaks, gfp_peaks_indices] = findpeaks(gfp_values); % peak locations

gfp_peaks_indices = gfp_peaks_indices(gfp_peaks >= thresh);

end