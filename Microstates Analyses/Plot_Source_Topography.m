function [] = Plot_Source_Topography(data_timepoint, region_information, tissue_information)

%%%
% Code for this function is based on : 
% Tait and Zhang (2021), +microstate: A MATLAB toolbox for brain microstate analysis in sensor and cortical EEG/MEG,
% bioRxiv 2021.07.13.452193. doi: 10.1101/2021.07.13.452193
% 
% 
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

tissue = open(tissue_information);
regions = open(region_information);

tissue.facecolor = 'interp' ; 
tissue.linestyle = 'none' ; 

cmap = brewermap(64,'OrRd');

headshape = tissue ; 
headshape.facecolor = 0.8*ones(1,3); 

figure;
patch(headshape);

region_patches = nan(length(tissue.vertices),1); 
for j = 1:max(regions.tissue)
    region_index = find(regions.tissue == j) ; 
    region_patches(region_index) = abs(data_timepoint(j));
end

tissue.facevertexcdata = region_patches; 
patch(tissue)

axis off
hold off
axis equal

ax = gca; 
colormap(ax,cmap);
caxis([0,max(abs(data_timepoint),[],"all")]);
disp(max(abs(data_timepoint)));
camlight (-10,-90) ; lighting gouraud ; material dull

end
