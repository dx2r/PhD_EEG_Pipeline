function [] = Plot_Global_Field_Power(eeg_values, gfp_values, gfp_peaks)

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
figure;
%tiledlayout(2,1);
%nexttile;
yyaxis left
plot(eeg_values,'k-');
ylim([-100,60]);
%nexttile;
yyaxis right
plot(gfp_values, LineWidth=3);
xline(gfp_peaks, LineWidth=1);
ylim([0,60]);
end