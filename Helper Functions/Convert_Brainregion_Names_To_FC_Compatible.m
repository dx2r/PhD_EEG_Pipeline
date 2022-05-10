function [name_combinations] = Convert_Brainregion_Names_To_FC_Compatible(brainregion_names, directionality)

%%%
% 
% Function which converts the brainregion names to a FC compatible version. This function is used in the "Build_Statistical_Table.m" function.
%
% Gert Vanhollebeke (10/05/2022 - 10/05/2022)
%
% INPUT:
%   brainregion_names: 1*N string array containing the names of all brainregions included in the analysis
%   directionality: string containing whether the FC measure is undirection of directional
%       possiblities:
%           "directional"
%           "undirectional"
%
% OUTPUT:
%   name_combinations: cell array containing the FC connection names 
%
% example:
%   FC_names = Convert_Brainregion_Names_To_FC_Compatible(brainregion_names, "undirectional");
%
%%%

%Step 1: get amount of brainregions in the analysis
brainregion_amount = size(brainregion_names,2);
%Step 2: build empty cell array for all FC combination names
name_combinations = cell(1,(brainregion_amount*(brainregion_amount-1))/2);
%Step 3: build FC combinations
%check for directionality
if(strcmp(directionality,"undirectional"))
    counter = 1;
    for n_row = 1:brainregion_amount-1
        for n_column = n_row+1:brainregion_amount
            current_FC_combination = strcat(brainregion_names(1,n_row)," <-> ",brainregion_names(1,n_column));
            name_combinations(1,counter) = cellstr(current_FC_combination);
            counter = counter + 1;
        end
    end
elseif(strcmp(directionality,"directional"))
    disp("currently not implemented");
else
    error("Wrong Directionality Name Is Given.");
end




end