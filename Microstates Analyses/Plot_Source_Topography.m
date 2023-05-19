function [] = Plot_Source_Topography(data_timepoint, region_information, tissue_information)

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
camlight headlight ; lighting gouraud ; material dull

end
