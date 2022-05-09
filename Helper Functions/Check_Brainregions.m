function [brainregions] = Check_Brainregions()

%%%
% 
% Function which returns the brainregions that are available.
%
% Gert Vanhollebeke (02/12/2021 - 02/12/2021)
%
% INPUT:
%   
% OUTPUT:
%   brainregions: 130 x 2 table (130 brainregions, 2 variables (name & region index) containing the names of the brainregions and their index in the brainstorm format.
%
%%%

%Step 1: create the brainregion indexes
Region_Index = 1:1:130;
Region_Index = Region_Index.';
%Step 2: create the brainregion names
Region_Name = ["angular gyrus - anterior L";...
               "angular gyrus - anterior R";...
               "angular gyrus - middle L";...
               "angular gyrus - middle R";...
               "angular gyrus - posterior L";...
               "angular gyrus - posterior R";...
               "anterior orbito-frontal gyrus L";...
               "anterior orbito-frontal gyrus R";...
               "cingulate gyrus - anterior L";...
               "cingulate gyrus - anterior R";...
               "cingulate gyrus - middle L";...
               "cingulate gyrus - middle R";...
               "cingulate gyrus - posterior L";...
               "cingulate gyrus - posterior R";...
               "cuneus - anterior L";...
               "cuneus - anterior R";...
               "cuneus - posterior L";...
               "cuneus - posterior R";...
               "fusiform gyrus - anterior L";...
               "fusiform gyrus - anterior R";...
               "fusiform gyrus - posterior L";...
               "fusiform gyrus - posterior R";...
               "gyrus rectus L";...
               "gyrus rectus R";...
               "inferior occipital gyrus - anterior L";...
               "inferior occipital gyrus - anterior R";...
               "inferior occipital gyrus - dorsoposterior L";...
               "inferior occipital gyrus - dorsoposterior R";...
               "inferior occipital gyrus - ventroposterior L";...
               "inferior occipital gyrus - ventroposterior R";...
               "inferior temporal gyrus - anterior R";...
               "inferior temporal gyrus - anterior R";...
               "inferior temporal gyrus - middle L";...
               "inferior temporal gyrus - middle R";...
               "inferior temporal gyrus - posterior L";...
               "inferior temporal gyrus - posterior R";...
               "insula - anterior L";...
               "insula - anterior R";...
               "insula - posterior L";...
               "insula - posterior R";...
               "lateral orbitofrontal gyrus - anterior L";...
               "lateral orbitofrontal gyrus - anterior R";...
               "lateral orbitofrontal gyrus - posterior L";...
               "lateral orbitofrontal gyrus - posterior R";...
               "lingual gyrus - anterior L";...
               "lingual gyrus - anterior R";...
               "lingual gyrus - posterior L";...
               "lingual gyrus - posterior R";...
               "middle frontal gyrus - anterior L";...
               "middle frontal gyrus - anterior R";...
               "middle frontal gyrus - posterior L";...
               "middle frontal gyrus - posterior R";...
               "middle occipital gyrus - dorsoanterior L";...
               "middle occipital gyrus - dorsoanterior R";...
               "middle occipital gyrus - posterior L";...
               "middle occipital gyrus - posterior R";...
               "middle occipital gyrus - ventroanterior L";...
               "middle occipital gyrus - ventroanterior R";...
               "middle orbito-frontal gyrus L";...
               "middle orbito-frontal gyrus R";...
               "middle temporal gyrus - anterior L";...
               "middle temporal gyrus - anterior R";...
               "middle temporal gyrus - dorsoposterior L";...
               "middle temporal gyrus - dorsoposterior R";...
               "middle temporal gyrus - middle L";...
               "middle temporal gyrus - middle R";...
               "middle temporal gyrus - ventroposterior L";...
               "middle temporal gyrus - ventroposterior R";...
               "paracentral lobule L";...
               "paracentral lobule R";...
               "parahippocampal gyrus L";...
               "parahippocampal gyrus R";...
               "pars opercularis - inferior L";...
               "pars opercularis - inferior R";...
               "pars opercularis - superior L";...
               "pars opercularis - superior R";...
               "pars orbitalis L";...
               "pars orbitalis R";...
               "pars triangularis - anterior L";...
               "pars triangularis - anterior R";...
               "pars triangularis - middle L";...
               "pars triangularis - middle R";...
               "pars triangularis - posterior L";...
               "pars triangularis - posterior R";...
               "postcentral gyrus - inferior L";...
               "postcentral gyrus - inferior R";...
               "postcentral gyrus - superior L";...
               "postcentral gyrus - superior R";...
               "posterior orbito-frontal gyrus L";...
               "posterior orbito-frontal gyrus R";...
               "precentral gyrus - inferior L";...
               "precentral gyrus - inferior R";...
               "precentral gyrus - superior L";...
               "precentral gyrus - superior R";...
               "precuneus - inferior L";...
               "precuneus - inferior R";...
               "precuneus - superior L";...
               "precuneus - superior R";...
               "subcallosal gyrus L";...
               "subcallosal gyrus R";...
               "superior frontal gyrus - anterior L";...
               "superior frontal gyrus - anterior R";...
               "superior frontal gyrus - posterior L";...
               "superior frontal gyrus - posterior R";...
               "superior occipital gyrus - inferior L";...
               "superior occipital gyrus - inferior R";...
               "superior occipital gyrus - superior L";...
               "superior occipital gyrus - superior R";...
               "superior parietal gyrus - anterior L";...
               "superior parietal gyrus - anterior R";...
               "superior parietal gyrus - posterior L";...
               "superior parietal gyrus - posterior R";...
               "superior temporal gyrus - anterior L";...
               "superior temporal gyrus - anterior R";...
               "superior temporal gyrus - middle L";...
               "superior temporal gyrus - middle R";...
               "superior temporal gyrus - posterior L";...
               "superior temporal gyrus - posterior R";...
               "supramarginal gyrus - anterior L";...
               "supramarginal gyrus - anterior R";...
               "supramarginal gyrus - posterior L";...
               "supramarginal gyrus - posterior R";...
               "temporal pole L";...
               "temporal pole R";...
               "transverse frontal gyrus - lateral L";...
               "transverse frontal gyrus - lateral R";...
               "transverse frontal gyrus - medial L";...
               "transverse frontal gyrus - medial R";...
               "transverse temporal gyrus L";...
               "transverse temporal gyrus R"];
%Step 3: build the table
brainregions = table(Region_Name,Region_Index);
end