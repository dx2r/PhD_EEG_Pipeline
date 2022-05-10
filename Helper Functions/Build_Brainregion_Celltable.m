function [celltable] = Build_Brainregion_Celltable(data, brainregion_amount, brainregion_indices, brainregion_names)

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

%Step 1: create celltable object by checking how many cell are needed
celltable = cell(1, 1 + 2*brainregion_amount);
%Fill in the information
celltable(1,1) = {data};
for region_i = 1:brainregion_amount
    celltable(1,2*region_i) = {brainregion_indices{region_i}};
    celltable(1,2*region_i + 1) = cellstr(brainregion_names(region_i));
end






end