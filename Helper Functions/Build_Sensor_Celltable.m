function [celltable] = Build_Sensor_Celltable(data, sensor_amount, sensor_names)

%%%
% 
% Function which builds a cell array with all information needed. Helper function for easier working.
%
% Gert Vanhollebeke (10/05/2022 - 10/05/2022)
%
% INPUT:
%   data: N*M double array containing N timeseries of length M 
%   brainregion_amount: integer indicating how many brainregions have been selected for analysis
%   brainregion_indices: cell array containing the indices of the brainregions which have been included in the analysis
%   brainregion_names: string array containing the names of the brainregions which have been included in the analysis
%
% OUTPUT:
%   celltable: cellular table containing all information necessary for the "Extract_Time_Series_And_Names.m"
%
%%%
% Step 1: Check if whole brain analysis is selected
if(sensor_amount == -1 || strcmp(sensor_names(1),'All_Electrodes'))
    celltable = cell(1, 3);
    celltable(1,1) = {data};
    celltable(1,2) = {-1};
    celltable(1,3) = {"All_Electrodes"};
else
    celltable = cell(1, 1 + sensor_amount);
    %Fill in the information
    celltable(1,1) = {data};
    for sensor_i = 2:(sensor_amount+1)
        celltable(1,sensor_i) = {sensor_names{sensor_i-1}};
    end
end
end