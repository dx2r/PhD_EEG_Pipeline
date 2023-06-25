function [] = Plot_Source_Topography(data_timepoint, path_aal_atlas_regions, path_head_layout_information)

%%%
% Code for this function is based on the microstate plus toolbox function: 
% Tait and Zhang (2021), +microstate: A MATLAB toolbox for brain microstate analysis in sensor and cortical EEG/MEG,
% bioRxiv 2021.07.13.452193. doi: 10.1101/2021.07.13.452193
% 
%
% Function that plots a source topography map using the AAL atlas
% 
% Lore Flipts
%
% INPUT:
%   data_timepoint: N*1 double matrix containing a single map (e.g. a microstate map). (N = #timeseries) 
%   path_aal_atlas_regions: path to file containing the aal atlas region coordinates ('\...\Extern\aal.mat')
%   path_head_layout_information: path to file containing the head layout information ('\...\Extern\inflated.mat')
%
%%%

source_map_aal = Convert_USCB_To_AAL(data_timepoint);

tissue = open(path_head_layout_information);
regions = open(path_aal_atlas_regions);

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
    region_patches(region_index) = abs(source_map_aal(j));
end

tissue.facevertexcdata = region_patches; 
patch(tissue)

axis off
hold off
axis equal

ax = gca; 
colormap(ax,cmap);
caxis([0,max(abs(source_map_aal),[],"all")]);
camlight left ; lighting gouraud ; material dull

end
