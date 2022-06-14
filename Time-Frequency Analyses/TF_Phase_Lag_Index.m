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
% EXAMPLE: 
%   PLI_Values = TF_Phase_Lag_Index(data, 3, 512, [8 13]);
%
%%%

%Step 0: tell what is going on
disp("Computing Phase Lag Index...");
%Step 1: compute PLI
[timeseries_amount, timeseries_length] = size(data); %get info of data
data = data.'; %transpose data, works easier in following steps
data_bandpass = bandpass(data,freq_range, sample_freq); %bandpass data
data_hilbert = hilbert(data_bandpass); %compute hilbert transform
data_phase = angle(data_hilbert); %compute phase of singal from hilbert transform
%compute PLI for each combination of signals
PLI_values = zeros(timeseries_amount, timeseries_amount); %create empty matrix for PLI values storage
for loop_1 = 1:timeseries_amount-1
    for loop_2 = loop_1 + 1:timeseries_amount
        %get the two currently needed timeseries
        signal_1 = data_phase(:,loop_1);
        signal_2 = data_phase(:,loop_2);
        %obtain difference signal
        signal_difference = signal_1 - signal_2;
        %obtain sign function results from difference signal
        signal_sign = sign(signal_difference); 
        %obtain PLI value
        current_PLI = abs(mean(signal_sign));
        %store PLI value (twice, PLI is undirected)
        PLI_values(loop_1, loop_2) = current_PLI;
        PLI_values(loop_2, loop_1) = current_PLI;
    end
end









end