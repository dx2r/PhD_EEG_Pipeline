function [labels_new] = Microstates_Temporal_Smoothing(data, labels, microstates, window_length, data_type, sample_frequency, epoch_length)

%  this function is based on the function window_smoothing from EEGlab [1] and
%  on the segmentation smoothing algorithm from Pascual-Marqui [2]
%
%  [1] A. T. Poulsen, A. Pedroni, N. Langer, and L. K. Hansen, “Microstate EEGlab toolbox: An
%  introductory guide," Mar. 2018, pages: 289850 Section: New Results. [Online]. Available: https://www.biorxiv.org/content/10.1101/289850v1
%  [2] Pascual-Marqui RD, Michel CM, Lehmann D. Segmentation of brain electrical activity into microstates: model estimation and validation. 
%  IEEE Trans Biomed Eng. 1995 Jul;42(7):658-65. doi: 10.1109/10.391164. PMID: 7622149.

%% Initialisation (step 1 to 4)
lambda = 2;

max_iterations = 1000;
thresh = 1e-6;

% Step 1
GEV_old = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);
GEV = 0;


% Step 2
activations = microstates' * data;


%Check to avoid the loop getting caught and switching one label back and
% forth between iterations.
labels_old{1} = zeros(size(labels));
labels_old{2} = zeros(size(labels));

[~, correlation] = Microstates_Backfitting(data, microstates, data_type);

%% Iterations (step 5 to 8)
iter = 0;
while abs(GEV_old - GEV) >= thresh * GEV && max_iterations > iter  && mean(labels_old{rem(iter,2)+1} == labels) ~= 1
    iter = iter + 1;
    GEV_old = GEV;

    labels_old{abs(rem(iter,2)-2)} = labels;
    
    
    sum_neighbouring_labels = Calculate_Sum_Neighbour_Labels(microstates, labels, window_length, sample_frequency, epoch_length);
    sum_neighbouring_labels = sum_neighbouring_labels ./ (window_length * 2);

    correlation_with_reward = abs(correlation) + lambda * sum_neighbouring_labels;
    [~, labels] = max(correlation_with_reward, [], 1);

    % Step 5b
    %[~,labels_2] = min(const_5b - lambda*sum_neighbouring_labels);
    
    % Step 7
    GEV = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);
    %fprintf("GEV: %.7f \n", GEV);
end

labels_new = labels;
