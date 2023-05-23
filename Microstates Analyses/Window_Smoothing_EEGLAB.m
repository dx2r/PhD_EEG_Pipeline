function [labels_new] = Window_Smoothing_EEGLAB(data, labels, microstates, window_length, data_type, sample_frequency, epoch_length)
% [L,sig2,R2,MSE,ind] = window_smoothing(X,A,opts)
%  Implementation of the Segmentation Smoothing Algorithm, as described in
%  Table II of [1]. Smoothes using the interval t-b to t+b excluding t.
%  Note, that temporary allocation of labels (denoted with Lambda in [1])
%  is not necessary in this implementation, and steps 3 and 6 are therefore
%  left out.

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

% Step 4
%GEV = Calculate_Global_Explained_Variance(data, microstates, labels, data_type);

% Defining constant for step 5b
%tmp = sum(data.^2);
%const_5b = (repmat(tmp,K,1) - activations.^2) / ((2 * sum(sum(data.^2)) / N) * (1 - GEV_old));
%clear tmp

[~, correlation] = Backfitting(data, microstates, data_type);
%disp(abs(correlation(:,1:100)))

%% Iterations (step 5 to 8)
iter = 0;
while abs(GEV_old - GEV) >= thresh * GEV && max_iterations > iter  && mean(labels_old{rem(iter,2)+1} == labels) ~= 1
    iter = iter + 1;
    GEV_old = GEV;

    labels_old{abs(rem(iter,2)-2)} = labels;
    
    
    sum_neighbouring_labels = Calculate_Epoch_SumLabels(microstates, labels, window_length, sample_frequency, epoch_length);
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