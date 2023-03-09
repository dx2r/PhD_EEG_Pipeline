function [] = Plot_Sensor_Topography(data_timepoint, channel_information)

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

[names, x_channel, y_channel, headshape] = Extract_Channel_Locations(channel_information);

x_interpolated = linspace(min(x_channel), max(x_channel), 1000);
y_interpolated = linspace(min(y_channel), max(y_channel), 1000);

[x_grid, y_grid] = meshgrid(x_interpolated, y_interpolated);

potential = griddata(x_channel, y_channel, data_timepoint, x_grid, y_grid, 'cubic');
figure;
contourf(x_grid, y_grid, potential, 100, LineColor='None');
hold on;
scatter(x_channel,y_channel, 20, 'k','filled');
text(x_channel, y_channel, names, FontSize=6, HorizontalAlignment='center', VerticalAlignment='bottom');
hold on;
for i = 1:length(headshape)
    plot(headshape{1,i}(:,1), headshape{1,i}(:,2), 'k');
    hold on
end
axis square
cmap = Build_Red_Blue_Colormap();
colormap(cmap);

end
