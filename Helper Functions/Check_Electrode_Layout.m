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

electrode_layout = electrode_file;





end