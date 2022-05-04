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
%        'AEC': Amplitude envelope correlation
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

%Step 0: get dimensions of the dataset:
[timeseries_amount,timepoints_amount] = size(data);

%Step 1: check which functional connectivity measure needs to be calculated

%%%
% Amplitude Envelope Correlation
%%%
if (strcmp(connectivity_measure,"AEC"))
    %calculate useful variables
    epoch_amount = timepoints_amount/(epoch_length*sample_freq); % amount of epochs in the data
    epoch_timepoints = sample_freq*epoch_length; % amount of timepoints in a single epoch
    connectivity_values = zeros(timeseries_amount); % matrix which will containt the final connectivity values
    freq_range = varargin{1}; %get the frequency range
    %tell what will happen
    disp('Calculating the Amplitude Envelope Correlation...');
    disp('Starting the epoching procedure...');
    %Loop over each epoch
    for epoch_i = 1:epoch_amount
        %say which epoch is ran
        disp(['Epoch ',num2str(epoch_i),' of ',num2str(epoch_amount),'...']);
        current_epoch = data(:,((epoch_i - 1)*epoch_timepoints) + 1:((epoch_i - 1)*epoch_timepoints) + epoch_timepoints); %get the current epoch data
        current_AEC_values = TF_AAmplitude_Envelope_Correlation(current_epoch, sample_freq, freq_range); %calculate the AEC values for this epoch
        connectivity_values = connectivity_values + current_AEC_values; %add the AEC values to the general matrix
    end
    %divide the AEC values by the amount of epochs to obtain the average value for each connection
    connectivity_values = connectivity_values./epoch_amount;
    disp("Done with calculating...");
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