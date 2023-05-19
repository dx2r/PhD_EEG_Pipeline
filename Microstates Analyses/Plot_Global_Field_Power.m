function [] = Plot_Global_Field_Power(eeg_values, gfp_values, gfp_peaks, sample_frequency)

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

eeg_values = transpose(eeg_values);
time = linspace(1,length(gfp_values)/sample_frequency*1000, length(gfp_values));
gfp_peaks = gfp_peaks./sample_frequency .*1000;
fig = figure();
%fig.Position = [100 100 1500 300];
fig.Position = [100 100 1200 500];
left_color = [0 0 0]; %[235 0 0]./255;
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis right
plot(time, gfp_values, LineWidth=3, Color=[235 0 0]./255, DisplayName='Global Field Power');
xlim([0 time(end)]);
ylim([0,80]);
ylabel('Global Field Power [µV]', FontSize=17)
xlabel('Time [ms]', FontSize=17)
hold on

yyaxis left
plot(time, eeg_values(:,1),'k-',LineWidth=0.05, DisplayName='EEG measurements');
plot(time, eeg_values,'k-',LineWidth=0.05, HandleVisibility='off');
ylabel('EEG of 127 channels [µV]', FontSize=17)
ylim([-100,60]);
%nexttile;

xline(gfp_peaks, LineWidth=1, Color='k', alpha=0.15, HandleVisibility='off');
%xlim([0 time(end)]);
%ylim([-75,75])
%xlabel('Time [ms]', FontSize=17)
lgd = legend();
lgd.FontSize = 14;
%set(gcf, 'color', 'none');    
%set(gca, 'color', 'none');
%exportgraphics(gcf,'transparent.emf',...   % since R2020a
%    'ContentType','vector',...
%    'BackgroundColor','none')
end