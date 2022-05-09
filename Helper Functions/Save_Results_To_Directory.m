function [] = Save_Results_To_Directory(data, name, path)

%%%
%
% Function which saves results to a directory.
%
% Gert Vanhollebeke (06/12/2021 - 06/12/2021)
%
% INPUT:
%   data: mat object containing results of some sort (can be anything) which needs to be saved.
%   name: char/string array which contains the name that the saved file needs to be named.
%   path: char/string array containing the full path to the directory in which the file needs to be saved..
%
%%%
%Step 0: Tell what is going on
disp(['Saving ',char(name),'...']);
%Step 1: save the file
full_name = char(strcat(path,"\",name));
Data_Object = data;
temp = zeros(5);
save(full_name,'Data_Object');





end