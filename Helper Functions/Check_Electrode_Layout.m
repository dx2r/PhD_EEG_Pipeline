function [electrode_layout] = Check_Electrode_Layout(path_to_electrode_file)

%%%
% 
% Function which returns the electrodes that are available.
%
% Gert Vanhollebeke (28/07/2022 - 28/07/2022)
%
% INPUT:
%   path_to_electrode_file: char or string array containing the path to the .mat file which contains the electrode information
%   
% OUTPUT:
%   brainregions: N x 1 table (N electrodes) containing the names of the electrodes.
%
%%%

electrode_file = open(path_to_electrode_file);
structure_fieldname = fieldnames(electrode_file); %get the field name of the mat object
electrode_file = getfield(electrode_file, structure_fieldname{1,1}); %Get the field with the variable name
%now we have a cell array containing the electrodes, make sure that the structure is N x 1
[size1, size2] = size(electrode_file);
if(size2 > size1)
    electrode_file = electrode_file.'; %transpose
end
disp("The available electrodes are: ");
disp(electrode_file);
electrode_layout = table(electrode_file);
electrode_layout.Properties.VariableNames = {'Available_Electrodes'};



end