function [connectivity_values] = TF_Calculate_Functional_Connectivity(data, sample_freq, epoch_length, connectivity_measure, varargin)

%%%
%
% Wrapper function which runs a functional connectivity measure analysis and return their corresponding values. 
% The main use of this function is that no splitting in epochs is needed in the higher level programming, this is all done in this function.
%
% Gert Vanhollebeke (01/12/2021 - )
%
% INPUT:
%   data: NxM double array (N = #timeseries; M = #timepoints) which is the EEG data that needs to be analyzed.
%   sample_freq: double reflecting the sample frequency (Hz)
%   epoch_length: double reflecting the length of each epoch (seconds)
%   connectivity_measure: char array containing the name of the connectivity measure which should be used
%        'amplitude_envelope_correlation': Amplitude envelope correlation
%        'ACoh': Amplitude-squared coherence
%        'ICoh': Imaginary coherence
%   varargin: additional arguments depending on the connectivity measure
%        'AEC':
%            freq_range: 1 x 2 double containing the range in which AEC needs to be calculated.
%       
%
% OUTPUT:
%   connectivity_values: output dependable on the connectivity measure that is ran.
%       Amplitude Envelope Correlation: N x N matrix (N = #timeseries). For more information, see TF_Amplitude_Envelope_Correlation.m
%
%
% EXAMPLE:
%   AEC:
%       [AEC_values] = TF_calculate_functional_connectivity(data, 512, 3, 'AEC', [8 13]);
%%%

%Step 1: check which functional connectivity measure needs to be calculated

%%%
% Amplitude Envelope Correlation
%%%

if(strcmp(connectivity_measure, "amplitude_envelope_correlation"))
    freq_range = varargin{1};
    connectivity_values = TF_Average_Amplitude_Envelope_Correlation(data, sample_freq, epoch_length, freq_range);
end

%%%
% Amplitude-squared Coherence
%%%    
if(strcmp(connectivity_measure,"ACoh"))

end   
    
%%%
% Imaginary Coherence
%%%     
if(strcmp(connectivity_measure,"ICoh"))
   
end

end