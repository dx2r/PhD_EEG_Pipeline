function [] = Plot_Sensor_Topography(data_timepoint, channel_information, plot_layout, i)

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
    %scatter(x_channel,y_channel, 10, 'k','filled');
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
%set(gcf, 'color', 'none');    
%set(gca, 'color', 'none');
%exportgraphics(gcf,'transparent.eps',...   % since R2020a
%    'ContentType','vector')%,...
    %'BackgroundColor','none')

%set(fig, 'visible', 'on'); 
path = 'D:\UGent\Burgie\Jaar 4\Thesis\Temp_Figures\cluster_4\' + sprintf("%d",i) + '.png';
%saveas(fig, path);

end
