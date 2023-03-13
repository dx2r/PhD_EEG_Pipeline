function [segment_label,segment_length]=Run_Length_Encoding(x)
%% RLE
% https://github.com/atpoulsen/Microstate-EEGlab-toolbox/blob/master/MST1.0/MicroStats.m#L340
% This function performs Run Length Encoding to a strem of data x.
% [d,c]=rl_enc(x) returns the element values in d and their number of
% apperance in c. All number formats are accepted for the elements of x.
% This function is built by Abdulrahman Ikram Siddiq in Oct-1st-2011 5:15pm.

if nargin~=1
    error('A single 1-D stream must be used as an input')
end

ind=1;
segment_label(ind)=x(1);
segment_length(ind)=1;

for i=2 :length(x)
    if x(i-1)==x(i)
        segment_length(ind)=segment_length(ind)+1;
    else ind=ind+1;
        segment_label(ind)=x(i);
        segment_length(ind)=1;
    end
end

end