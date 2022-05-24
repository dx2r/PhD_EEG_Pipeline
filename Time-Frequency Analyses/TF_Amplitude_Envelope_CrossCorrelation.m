function [xcorr_values, xcorr_lags] = TF_Amplitude_Envelope_CrossCorrelation(data, sample_freq, freq_range, max_delay)

%%%
%
% Function which computes the amplitude envelope cross correlation (AEcC). The approach is similar to amplitude envelope correlation,
% but a key difference is present. No orthogonalization is conducted since spurious correlations between regions
% due to the limited spatial resolution is assumed to be instantanious. If only cross-correlation values (eg. no 0 shift value
% is considered), orthogonalization should not be conducted.
%
% Gert Vanhollebeke (18/05/2022 - )
% INPUT:
%   data: 2xM double matrix (M = #timepoints) containing the two timeseries for which AEcC should be computed.
%   sample_freq: integer indicating the sample frequency (Hz)
%   freq_range: 1x2 vector containing the frequency range in which amplitude envelope cross-correlation needs to be calculated
%       example: [4 10]
%   max_delay: double indicating the maximum delay (seconds) in which cross-correlation should be computed
% 
% OUTPUT:
%   temporary: TODO
%
%%%

%Step : bandpass the data
data = data.'; %transpose for easier working
data_bandpass = bandpass(data, freq_range, sample_freq);
%Step : Hilbert transform the data
data_hilbert = hilbert(data_bandpass);
%Step : Obtain envelopes
data_envelope = abs(data_hilbert);
%Step : compute cross-correlation
%compute how many timepoints should be used for the shifting
shift_amount = sample_freq*max_delay;
disp(shift_amount);
disp(data_envelope(:,1));
[xcorr_values, xcorr_lags] = xcorr(data_envelope(:,1), data_envelope(:,2), shift_amount, 'normalized');







end