function [] = Plot_Global_Field_Power(data, gfp_values, gfp_peaks, sample_frequency)

%%%
% Function that plots the global field power and the eeg signals together
% 
% Lore Flipts
%
% INPUT:
%   data: N*M double matrix. (N = #timeseries, M = #timepoints) 
%   gfp_values: 1*M double matrix containing the global field power values
%   gfp_peaks: 1*P double matrix containing the indices of the gfp peaks (P = #gfp peaks)
%   sample_freq: double indicating the sample frequency (Hz)
%
%%%

data = transpose(data);
time = linspace(1,length(gfp_values)/sample_frequency*1000, length(gfp_values));
gfp_peaks = gfp_peaks./sample_frequency .*1000;
fig = figure();

fig.Position = [100 100 2500 500];
left_color = [0 0 0]; %[235 0 0]./255;
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis right
plot(time, gfp_values, LineWidth=3, Color=[235 0 0]./255, DisplayName='Global Field Power');
xlim([0 time(end)]);
ylim([0,50]);
ylabel('Global Field Power [µV]', FontSize=28)
xlabel('Time [ms]', FontSize=18)
hold on

yyaxis left
plot(time, data(:,1),'k-',LineWidth=0.05, DisplayName='EEG measurements');
plot(time, data,'k-',LineWidth=0.05, HandleVisibility='off');
ylabel('EEG signals [µV]', FontSize=28)
ylim([-100,40]);


xline(gfp_peaks, LineWidth=1, Color='k', alpha=0.15, HandleVisibility='off');

lgd = legend();
lgd.FontSize = 25;
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',25)

end