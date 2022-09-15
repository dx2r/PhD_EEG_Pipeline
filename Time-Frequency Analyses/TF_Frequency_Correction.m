function [corrected_power_spectrum] = TF_Frequency_Correction(power_spectrum, freq_values, gamma)

%%%
% Function which corrects the power spectrum for 1/f noise. This is done by multiplying every power value in the power spectrum by f^gamma.
%
% INPUT:
%   power_spectrum: 1xN double array containing the power values for each specific frequency
%   freq_values: 1xN double array containing the specific frequency for which the power_spectrum was computed
%   gamma: double indicating the power to which the frequency should be risen to
%
% OUTPUT:
%   corrected_power_spectrum = 1*N double array containing the 1/f corrected power spectrum
%
% EXAMPLE: 
%   [corrected_power_spectrum] = TF_Frequency_Correction(power_spectrum, freq_values, 1);
%
% Gert Vanhollebeke (15/09/2022)
%
%%%

%Step 0: tell what is going on
disp('Correcting the power spectrum for 1/f noise...');
%Step 1: correcting the frequency spectrum
corrected_power_spectrum = power_spectrum.*(freq_values.^gamma);
end