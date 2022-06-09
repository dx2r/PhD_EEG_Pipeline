function [PLI_values] = TF_Phase_Lag_Index(data, epoch_length, sample_freq, freq_range)
%%%
%
% Function which computes the Phase Lag Index (PLI), as defined by Stam et al. (2007) (DOI: 10.1002/hbm.20346)
%
% Gert Vanhollebeke (09/06/2022 - 09/06/2022)
%
% INPUT:
%   data: NxM double array containing the timeseries (N: amount of timeseries ; M: amount of timepoints)
%   epoch_length: double indicating epoch length (unit: seconds)
%   sample_freq: double indicating sampling frequency (unit: Hz)
%   freq_range: 1x2 double indicating the frequency range in which PLI should be computed 
%
% OUTPUT:
%   PLI_Values: NxN double array, containing the PLI values.
%
%%%

%Step 0: tell what is going on
disp("Computing Phase Lag Index...");

%Step 1: compute PLI
data = data.'; %transpose data, works easier in following steps
data_bandpass = bandpass(data,freq_range, sample_freq); %bandpass data
data_hilbert = hilbert(data_bandpass); %compute hilbert transform









end