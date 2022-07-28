function [index_of_electrode] = Find_Index_Of_Electrode(electrode_name, electrode_list)

%%%
%
% Function which returns the index of an electrode in the list of electrodes accompanying a dataset.
% Note: this is a very inefficient way of doing this, but makes sure the no case-sensitive problems arise.
%
% Gert Vanhollebeke (28/07/2022 - 28/07/2022)
%
% INPUT:
%   electrode_name: character/string vector containing the name of the electrode
%   electrode_list: Nx1 table containing the names of all electrodes included in the current dataset
%
% OUTPUT: 
%   index_of_electrode: integer indicating the index of the electrode in the electrode list
%
%%%

%loop over all electrode names in the electrode_list until electrode_name is found
counter = 1; %use while loop, since the loop size is not known in advance
list_size = max(size(electrode_list));
while(strcmpi(electrode_name, string(electrode_list{counter,1})) == 0 && counter <= list_size)
    counter = counter + 1;
end    
%check if counter is not bigger than list_size (meaning that the electrode is not found
if(counter > list_size)
    %normally this error is never thrown, since the first check of the while loop will give an error (can be solved with a try catch statement)
    error('Electrode is not present in the Electrode List...');
end
%return counter (is equal to the index of the electrode)
index_of_electrode = counter;
end