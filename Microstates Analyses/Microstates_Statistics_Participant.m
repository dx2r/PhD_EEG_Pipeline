function [smoothened_label_timeseries, microstate_statistics] = Microstates_Statistics_Participant(maps, microstates, data_type, sample_frequency, epoch_length, window_length)

%%%
% Function that ...
% 
% Lore Flipts
%
% INPUT:
%   
%
% OUTPUT:
%   
%
%%%

% % Average re-reference data
% if(strcmp(data_type, "sensor"))
%     maps = maps - mean(maps,1);
% end


% Absolute value for source data
if(strcmp(data_type, "source"))
    maps = abs(maps);
end

% Average re-reference data
if(strcmp(data_type, "sensor"))
    maps = maps - mean(maps,1);
end

% Backfitting
label_timeseries = Backfitting(maps, microstates, data_type);
%smoothened_microstate_label_timeseries = Temporal_Smoothing(microstates, microstate_label_timeseries, 8, sample_frequency, epoch_length);

% Temporal smoothing
smoothened_label_timeseries = Window_Smoothing_EEGLAB(maps, label_timeseries, microstates, window_length, data_type, sample_frequency, epoch_length);
% 

%smoothened_label_timeseries = Backfitting_peaks(maps, microstates, data_type, sample_frequency, epoch_length);

% n = 300;
% time = linspace(1,length(label_timeseries(1:n))/sample_frequency*1000, length(label_timeseries(1:n)));
% figure;
% plot(time, label_timeseries(1:n),'.', Color='b', MarkerSize=15, DisplayName="Original labels")
% hold on
% plot(time, smoothened_label_timeseries(1:n),'o',Color='r',MarkerSize=5, LineWidth=0.9, DisplayName="Smoothened labels")
% ylabel('Microstate label', FontSize=14)
% xlabel('Time [ms]', FontSize=14)
% legend(FontSize=12)
% ylim([0 5])

% Calculate microstate statistics
microstate_statistics = Calculate_Microstate_Statistics(maps, smoothened_label_timeseries, microstates, data_type, sample_frequency, epoch_length);

end