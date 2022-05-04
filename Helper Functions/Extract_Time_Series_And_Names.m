function [selected_timeseries, selected_names] = Extract_Time_Series_And_Names(varargin)

%%%
%
% Function which extracts the necessary timeseries out of the whole data. Returns those timeseries and their names.
% If a region is defined by multiple atlas-regions, the function aggragates the timeseries into a single one by taking the mean of the timeseries.
%
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   varargin: a varying amount of inputs, but with a certain structure:
%       varargin{1}: N x M matrix (N = #timeseries; M = #timepoints) containing the timeseries.
%       varargin{2,4,6,8,...}: integer/double or array of integers/doubles indicating the index/indices of the timeseries that needs to be extracted/aggragated
%       varargin{3,5,7,9,...}: string name containing the name of the region 
%           if "": the name should be taken from a table based on the index
%           if not "": this is the name for the aggragated region
%
% OUTPUT:
%   selected_timeseries: 
%%%

%Step 0: Tell what is going on
disp("Extracting Necessary Timeseries...");
%Step 1: check how many regions have been selected
region_amount = (size(varargin,2) - 1)/2; %-1 because the first argument is the data itself, /2 because for each region its index and name is given
if(region_amount < 1) %throw error if no regions are given
   error("You have not defined any regions. Please define the region index/indices."); 
end
%Step 2: get the size of the dataset
[timeseries_amount,timepoints_amount] = size(varargin{1});
%Step 3: build the selected dataframe
if(varargin{2} == -1 || varargin{3} == "whole Brain") %check if whole-brain analysis is needed
    disp("Whole brain analysis has been selected...");
    selected_timeseries = varargin{1}; %give back the whole dataset
    temp_var = Check_Brainregions;
    selected_names = temp_var(:,1); %five back all region names
else % only certain regions are selected
    selected_timeseries = zeros(region_amount, timepoints_amount); %emtpy structure for the timeseries
    selected_names = "Brain Region";
    brainregion_list = Check_Brainregions();
    brainregion_list = brainregion_list(:,1);
    for timeseries_i = 1:region_amount
        if(size(varargin{2*timeseries_i},2) ~= 1) %the current region is built from multiple regions in the atlas
            selected_timeseries(timeseries_i,:) = mean(varargin{1}(varargin{2*timeseries_i},:)); %mean of the selected timeseries
            selected_names(timeseries_i) = varargin{2*timeseries_i + 1}; %name that has been given as the argument
        else
            selected_timeseries(timeseries_i,:) = varargin{1}(varargin{2*timeseries_i},:); %selected timeseries
            if(varargin{2*timeseries_i + 1} == "") %check if no name is given
                selected_names(timeseries_i) = {table2cell(brainregion_list(varargin{2*timeseries_i},1))}; %long chain of indexing to obtain the string value itself, not a table element.
            else
                selected_names(timeseries_i) = varargin{2*timeseries_i + 1}; %name that has been given as the argument
            end
        end
    end
    selected_names = selected_names.'; %transpose for easier use
end