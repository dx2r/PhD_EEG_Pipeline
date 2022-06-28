function [dynamic_values] = TF_Calculate_Dynamic_Measures(data, sample_freq, epoch_length, measure, window_length, timeshift, varargin)

%%%
%
% Wrapper function which runs a dynamic analysis (power or functional connectivity). A window (without transformation, so no hanning of hamming) is used.
%
% Gert Vanhollebeke (28/06/2022 - )
%
% INPUT:
%   data: NxM double array (N = #timeseries; M = #timepoints) which is the EEG data that needs to be analyzed.
%   sample_freq: double reflecting the sample frequency (Hz)
%   epoch_length: double reflecting the length of each epoch (seconds)
%   measure: char array containing the name of the connectivity measure which should be used
%        'relative_power_specific': Relative Power within specific frequency range
%        'amplitude_envelope_correlation': Amplitude envelope correlation
%   window_length: double indicating the length of the window which needs to be used (unit: seconds)
%   timeshift: double indicating the shift which needs to be 
%   varargin: additional arguments depending on the measure
%        'average_relative_power_specific':
%            bin_width: double indicating bin width for the power calculation (unit: Hz)
%            freq_range_interest: 1*2 integer indicating the lower and upper bound of the frequency range of interest
%            freq_range_whole: 1*2 integer indicating the lower and upper bound of the frequency range in which the signal is assumed
%        'amplitude_envelope_correlation':
%            freq_range: 1 x 2 double containing the range in which AEC needs to be calculated.   
%
% OUTPUT:
%   dynamic_values: output dependable on the connectivity measure that is ran.
%       'relative_power_specific': K x 1 x N matrix (K = dynamic size, N = #timeseries)
%       'amplitude_envelope_correlation': K x N x N matrix (N = #timeseries)
%
% EXAMPLE:
%   AEC:
%       [AEC_values] = TF_calculate_functional_connectivity(data, 512, 3, 'AEC', [8 13]);
%%%