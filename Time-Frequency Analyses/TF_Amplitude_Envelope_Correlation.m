function [AEC_values] = TF_Amplitude_Envelope_Correlation(data, sample_freq, freq_range)

%%%
%
% Function that computes the amplitude envelope correlation (AEC), now with Time domain based Ortghonalisation (Stabilized Gram-Schmidt Algorithm). 
% (see the following article for more information: https://doi.org/10.1038/nn.3101)
% note: since asymmetric orthogonalization is used, two orthogonalizations are run, and the average is obtained.
%
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   data: NxM matrix (N = #timeseries; M = #timepoints) containing the timeseries.
%   sample_freq: sample frequency (Hz)
%   freq_range: 1x2 vector containing the frequency range in which amplitude envelope correlation needs to be calculated
%       example: [4 10] 
%
% OUTPUT:
%   AEC_values: N x N double matrix (N = #timeseries) which contains the AEC values. This matrix is symmetric. 
%
%%%

%Step 1: get dimensions of the dataset:
[timeseries_amount,timepoints_amount] = size(data);
%Step 2: bandpass filter the data
data = data.'; %transpose the data as the following functions work on collumns, not rows
data_bandpass = bandpass(data,freq_range, sample_freq); 
%make empty AEC matrix
AEC_values = eye(timeseries_amount); %set diagonal to 1 since the autocorrelation is always 1
%Step 3: for loop since each combination of time series needs to be adressed seperately
for loop_1 = 1:timeseries_amount-1
    for loop_2 = loop_1 + 1:timeseries_amount
        %get the two currently needed timeseries
        signal_1 = data_bandpass(:,loop_1);
        signal_2 = data_bandpass(:,loop_2);
        %put them together (twice, since orthogonalization is not symmetric)
        signals_1 = [signal_1, signal_2];
        signals_2 = [signal_2, signal_1];
        %orthogonalize using stabilized Gram-Schmidt procedure
        ortho_1 = TF_Orthogonalize_Timeseries(signals_1);
        ortho_2 = TF_Orthogonalize_Timeseries(signals_2);
        %hilbert transform
        hilbert_1 = hilbert(ortho_1);
        hilbert_2 = hilbert(ortho_2);
        %absolute value of obtained hilbert transform (aka. power envelope)
        envelope_1 = abs(hilbert_1);
        envelope_2 = abs(hilbert_2);
        %compute correlations between power envelopes
        AEC_1 = corrcoef(envelope_1);
        AEC_2 = corrcoef(envelope_2);
        %fill in average AEC value in corresponding cell
        AEC_values(loop_1, loop_2) = ((AEC_1(1,2)) + AEC_2(1,2))/2; %average = (v1 + v2)/2
    end
end
%make AEC matrix symmetric (AEC is undirected).
AEC_values = AEC_values + triu(AEC_values,1).';
end