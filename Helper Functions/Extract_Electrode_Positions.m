function[channel_names, x_coordinates, y_coordinates, headshape] = Extract_Electrode_Positions(path_electrode_positions)

%%%
% Function that extracts 2D electrode locations from path
% 
% Lore Flipts
%
% INPUT:
%   path_electrode_positions: path to file containing the 2D electrode positions for the used cap 
%       (e.g. '\...\Extern\electrode_information_d1.mat')
%
% OUTPUT:
%   channel_names: 1*N list of electrode names
%   x_coordinates: 1*N double matrix containing the x coordinate position of each electrode
%   y_coordinates: 1*N double matrix containing the y coordinate position of each electrode
%   headshape: coordinates of the headshape layout (from fieldtrip toolbox)
%%%

    path_electrode_positions = open(path_electrode_positions);
    structure_fieldname = fieldnames(path_electrode_positions); %get the field name of the mat object
    path_electrode_positions = getfield(path_electrode_positions, structure_fieldname{1,1}); %Get the field with the variable name
    channel_names = path_electrode_positions.label;
    x_coordinates = cell2mat(path_electrode_positions.location(:,1));
    y_coordinates = cell2mat(path_electrode_positions.location(:,2));
    headshape = path_electrode_positions.headshape;
end

