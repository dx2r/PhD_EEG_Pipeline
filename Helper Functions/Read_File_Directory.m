function [path_new] = Read_File_Directory(path_original,directory_name,file_name)

%%%
% 
% Function which creates an empty directory in the specified path.
% 
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   path_original: char array containing the full path to where the directory needs to be created.
%   directory_name: char array containing the name of the directory that needs to be created.
%
% OUTPUT:
%   path_new; char array containing the full path to the newly created directory.
%
%%%
%Step 0: Tell what is going on
disp("Generating path to file...");

%Step 1: generate the new absolute path
path_new = char(strcat(path_original,"\",directory_name,"\",file_name+".mat"));

end