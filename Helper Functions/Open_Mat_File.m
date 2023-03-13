function [file] = Open_Mat_File(path)

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

%Step 1: Open file
file = open(path);
structure_fieldname = fieldnames(file); %get the field name of the mat object
file = getfield(file, structure_fieldname{1,1}); %Get the field with the variable name

end