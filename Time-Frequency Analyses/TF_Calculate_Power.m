function [power_values] = TF_Calculate_Power(data, sample_freq, epoch_length, power_measure, varargin)

%%%
% 
% Wrapper function which runs a power measure analysis and return their corresponding values. 
% The main use of this function is that no splitting in epochs is needed in the higher level programming, this is all done in this function.
%
% INPUT:
%   data: NxM double array (N = #timeseries; M = #timepoints) which is the EEG data that needs to be analyzed.
%   sample_freq: double reflecting the sample frequency (Hz)
%   epoch_length: double reflecting the length of each epoch (seconds)
%   power_measure: string array indicating the power measure that needs to be ran.
%       - average_relative_power: average relative power: see "TF_Average_Relative_Power.m"
%   varargin: variable amount of input values depending on the power measure:
%       average_relative_power_all:
%       - bin_width: size of the bins for which the power needs to be calculated (Hz)
%       - delta_range: 1*2 integer indicating the lower and upper range of the delta band (Hz)
%       - theta_range: 1*2 integer indicating the lower and upper range of the theta band (Hz)
%       - alpha_range: 1*2 integer indicating the lower and upper range of the alpha band (Hz)
%       - beta_range: 1*2 integer indicating the lower and upper range of the beta band (Hz)       
%
% OUTPUT:
%   power_values: output dependable on the power measure
%       average_relative_power:
%       - 4*N double indicating the relative power value of each frequency band, for each time series 
%
% Gert Vanhollebeke (25/01/2022 - )
%
%%%

%Step 1: check which power measure is selected.

%%%
% AVERAGE RELATIVE POWER ALL FREQUENCY BANDS
%%%

if(strcmp(power_measure, "average_relative_power_all"))
    %tell what is going on
    disp("Average relative power for known frequency bands is selected...");
    %collect the varargin argument
    additional_info = varargin{1};
    power_values = TF_Average_Relative_Power_All_Frequencybands(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3}, additional_info{4}, additional_info{5});
    disp("Calculation Done...");
end

%%%
% AVERAGE RELATIVE POWER SPECIFIC FREQUENCY BAND
%%%

if(strcmp(power_measure, "average_relative_power_specific"))
    %tell what is going on
    disp("Average relative power for specific frequency range is selected...");
    %collect the varargin argument
    additional_info = varargin{1};
    power_values = TF_Average_Relative_Power_Specific_Frequencyband(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3});
    disp("Calculation Done...");
end

%%%
% AVERAGE ABSOLUTE POWER SPECIFIC FREQUENCY BAND
%%%

if(strcmp(power_measure, "average_absolute_power_specific"))
   %tell what is going on
   disp("Average absolute power for specific frequency range is selected...");
   %collect the varargin argument
   additional_info = varargin{1};
   power_values = TF_Average_Absolute_Power_Specific_Frequencyband(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3});
   disp("Calculation Done...");    
end

%%%
% AVERAGE LOG TRANSFORMED ABSOLUTE POWER SPECIFIC FREQUENCY BAND
%%%

if(strcmp(power_measure, "average_log_absolute_power_specific"))
    %tell what is going on
    disp("Average log transformed absolute power for specific frequency range is selected...");
    %collect the varargin argument
    additional_info = varargin{1};
    power_values = TF_Average_Log_Absolute_Power_Specific_Frequencyband(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3});
    disp("Calculation Done...");
end

%%%
% AVERAGE RELATIVE POWER SPECIFIC FREQUENCY BAND CORRECTED FOR 1/F NOISE
%%%

if(strcmp(power_measure, "average_relative_power_specific_fcorrected"))
    %tell what is going on
    disp("Average relative power for specific frequency range with 1/f correction...");
    %collect the varargin argument
    additional_info = varargin{1};
    power_values = TF_Average_Relative_Power_Specific_Frequencyband_FCorrected(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3}, additional_info{4});
    disp("Calculation Done...");
end

%%%
% COMBINED AVERAGE RELATIVE POWER FOR MULTIPLE ARTICLES, SPECIFIC FREQUENCYBAND? 1/F NOISE CORRECTION
%%%

if(strcmp(power_measure, "combined_relative_power_specific_fcorrected"))
    %tell what is going on
    disp("The combined mean power for specific frequency range with 1/f correction...");
    %collect the varargin argument
    additional_info = varargin{1};
    power_values = TF_Average_Relative_Power_Specific_Frequencyband_FCorrected(data, sample_freq, epoch_length, additional_info{1}, additional_info{2}, additional_info{3}, additional_info{4});
    power_values = mean(power_values); %compute mean
    disp("Calculation Done...");
end





end