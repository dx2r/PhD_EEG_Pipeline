function [corr_value_ratio, max_corr_lag] = TF_Amplitude_Envelope_CrossCorrelation(data, sample_freq, freq_range, max_delay)

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
%   corr_value_ratio: double indicating the ratio between the maximum correlation value and the zero lag correlation value (unitless, [1,+infinite]
%   max_corr_lag: double indicating the lag for where the maximum correlation value has been found (unit: milliseconds)
%
%%%

%Step : bandpass the data
data = data.'; %transpose for easier working
data_bandpass = bandpass(data, freq_range, sample_freq);

%Step : Hilbert transform the data
data_hilbert = hilbert(data_bandpass);
%Step : Obtain envelopes
data_envelope = abs(data_hilbert);
disp(size(data_envelope));
%Step : compute cross-correlation
%compute how many timepoints should be used for the shifting
shift_amount = sample_freq*max_delay;
[xcorr_values, xcorr_lags] = xcorr(data_envelope(:,1),data_envelope(:,2), shift_amount, 'coeff'); %compute crosscorrelation
%find the index of the "zero-lag" correlation
zero_lag_index = find(xcorr_lags == 0);
%get value of the zero lag correlation
zero_lag_corr_value = xcorr_values(zero_lag_index,1);
%find maximum correlation value
max_corr_value = max(xcorr_values);
%find index of maximum correlation value
max_corr_index = find(xcorr_values == max_corr_value);
%find lag for maximum correlation value and convert to milliseconds
max_corr_lag = (xcorr_lags(1,max_corr_index)/sample_freq)*1000;
%compute ratio between zero lag correlation value and maximum correlation value
corr_value_ratio = max_corr_value/zero_lag_corr_value;
disp(corr_value_ratio);
end