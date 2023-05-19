function [column_names] = Create_Extra_Column_Names_Statistical_Table(columns_amount, microstates_amount)

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
column_names = cell(1,columns_amount);
column_names(1,1) = cellstr("Participant_Name");
column_names(1,2) = cellstr("Sex");
column_names(1,3) = cellstr("Age");
column_names(1,4) = cellstr("Rumination_Score");
column_names(1,5) = cellstr("Reflection_Score");
column_names(1,6) = cellstr("Brooding_Score");
for microstate_k = 1:microstates_amount
    column_names(1,6+microstate_k) = cellstr("GEV_"+num2str(microstate_k));
    column_names(1,6+microstates_amount+microstate_k) = cellstr("Freq_of_Occ_"+num2str(microstate_k));
    column_names(1,6+2*microstates_amount+microstate_k) = cellstr("Duration_"+num2str(microstate_k));
    column_names(1,6+3*microstates_amount+microstate_k) = cellstr("Coverage_"+num2str(microstate_k));
end

for microstate_k = 1:microstates_amount
    for microstate_j = 1:microstates_amount
        column_names(1,6+(4+(microstate_j-1))*microstates_amount+microstate_k) = cellstr("T_Prob_"+num2str(microstate_j)+"_"+num2str(microstate_k));
    end
end
disp(column_names);
end