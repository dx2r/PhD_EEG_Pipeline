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
%       'relative_power_specific': 1 x N x K matrix (K = dynamic size, N = #timeseries)
%       'amplitude_envelope_correlation': N x N x K matrix (K = dynamic size, N = #timeseries)
%
% EXAMPLE:
%   'relative_power_specific':
%       pow_varargin = {0.5, [8 12], [0.5 40]};
%       [dynamic_values] = TF_Calculate_Dynamic_Measures(data, 512, 3, 'relative_power_specific',1, 1/512, pow_varargin);
%   AEC:
%       fc_varargin{[8 13]};
%       [dynamic_values] = TF_calculate_Dynamic_Measures(data, 512, 3, 'amplitude_envelope_correlation', fc_varargin);
%%%

%Step 0: tell what is going on
disp('Computing Dynamic Measure...');
%Step 1: compute length of the final output measure (= K)
[data_timeseries_amount, data_timepoints_amount] = size(data);
window_timepoints_amount = round(window_length*sample_freq); %convert window length to timepoints
timeshift_timepoints_amount = round(timeshift*sample_freq); %convert timeshift to timepoints
dynamic_size = (data_timepoints_amount - window_timepoints_amount)/timeshift_timepoints_amount;
%Step 2: compute dynamic measures
% this is done by calling the function once and seeing what data structure is given back,
% then building a 3D matrix with 2 dimensions being equal to the output of the function,
% and the third dimension being K. Afterwards a for loop is used to compute the measure for each timeshift
if strcmp(measure,'relative_power_specific')
    %relative power is selected
    disp("Relative Specific Power is selected..."); %Tell what is going on
    varargin = varargin{1}; %"decell" variable input
    temp_values = TF_Relative_Power_Specific(data, sample_freq, varargin{1}, varargin{2}, varargin{3}); %compute once for output size
    [size1, size2] = size(temp_values);
    dynamic_values = zeros(size1, size2, dynamic_size);
    clear temp_values; %remove temp_values from memory
    %for loop to compute on each timeshift
    for dynamic_i = 1:dynamic_size
        %extract necessary data
        current_data = data(:,((dynamic_i-1)*timeshift_timepoints_amount) + 1:((dynamic_i-1)*timeshift_timepoints_amount + window_timepoints_amount));
        %compute measure on the selected data and save it 
        dynamic_values(:,:,dynamic_i) = TF_Relative_Power_Specific(current_data, sample_freq, varargin{1}, varargin{2}, varargin{3});
    end
    disp('Dynamic Measure Calculated...');
elseif strcmp(measure,'amplitude_envelope_correlation')
    %amplitude envelope correlation is selected
    disp("Amplitude Envelope Correlation is selected...");
    varargin = varargin{1}; %"decell" variable input
    temp_values = TF_Amplitude_Envelope_Correlation(data, sample_freq, varargin{1});
    [size1, size2] = size(temp_values);
    dynamic_values = zeros(size1, size2, dynamic_size);
    clear temp_values; % remove temp_values from memory
    %for loop to compute on each timeshift
    for dynamic_i = 1:dynamic_size
        disp(dynamic_i);
        %extract necessary data
        current_data = data(:,((dynamic_i-1)*timeshift_timepoints_amount) + 1:((dynamic_i-1)*timeshift_timepoints_amount + window_timepoints_amount));
        %compute measure on the selected data and save it
        dynamic_values(:,:,dynamic_i) = TF_Amplitude_Envelope_Correlation(current_data, sample_freq, varargin{1});
    end
    disp('Dynamic Measure Calculated...');
else
    error("No known measure is selected.");
end
end

