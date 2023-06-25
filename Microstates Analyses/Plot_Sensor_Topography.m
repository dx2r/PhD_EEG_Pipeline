function [] = Plot_Sensor_Topography(data_timepoint, path_electrode_positions, plot_layout)

%%%
% Function that plots a sensor topography map
% 
% Lore Flipts
%
% INPUT:
%   data_timepoint: N*1 double matrix containing a single map (e.g. a microstate map). (N = #timeseries) 
%   path_electrode_positions: path to file containing the 2D electrode positions for the used cap 
%       (e.g. '\...\Extern\electrode_information_d1.mat')
%   plot_layout: boolean indicating if the headshape should be plotted
%
%%%

[names, x_channel, y_channel, headshape] = Extract_Electrode_Positions(path_electrode_positions);

x_interpolated = linspace(min(x_channel), max(x_channel), 400);
y_interpolated = linspace(min(y_channel), max(y_channel), 400);

[x_grid, y_grid] = meshgrid(x_interpolated, y_interpolated);

potential = griddata(x_channel, y_channel, data_timepoint, x_grid, y_grid, 'cubic');
%fig = figure('visible','off', Position=[0 0 150 150]);
figure;
contourf(x_grid, y_grid, potential, 100, LineColor='None');
%caxis([-30 30]);
%colorbar;
%surf(x_grid, y_grid, potential, EdgeColor='None');

if plot_layout
    hold on;
    scatter(x_channel,y_channel, 20, 'r','filled');
    text(x_channel, y_channel+0.005, names, FontSize=6, HorizontalAlignment='center', VerticalAlignment='bottom', FontWeight='bold');
    hold on;
    for i = 1:length(headshape)
        plot(headshape{1,i}(:,1), headshape{1,i}(:,2), 'k');
        hold on
    end
end
axis square
axis off
cmap = Build_Red_Blue_Colormap();
colormap(cmap);


end
