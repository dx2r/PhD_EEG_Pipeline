function [gfp_peaks_indices] = Extract_Global_Field_Power_Peaks(global_field_power)

%%%
% Function that extracts the peak indices from the global field power.
% 
% Lore Flipts
%
% INPUT:
%   global_field_power: 1*M double matrix. (M = #timepoints)
%
% OUTPUT:
%   gfp_peaks_indices: 1*P double matrix containing the indices of the
%       global field power peaks
%
%%%
[~, gfp_peaks_indices] = findpeaks(global_field_power); % peak locations

end