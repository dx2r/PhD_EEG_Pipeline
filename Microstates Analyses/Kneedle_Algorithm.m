function Ncomp = Kneedle_Algorithm(px,k,kq)

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
    
    if nargin < 2
        k = (1:length(px))' ; 
    end
    if size(k,2) >1
        k = k' ; 
    end
    if nargin < 3
        kq = (min(k):max(k))' ; 
    end
    if size(kq,2) > 1
        kq = kq' ; 
    end
    % validateattributes(px,{'numeric'},{'column','nondecreasing','real'})
    validateattributes(k,{'numeric'},{'column','nondecreasing','real'})
    % determine number of components using kneedle algorithm
    px = fit(k,px,'smoothingspline') ; px = px(kq) ; % smoothed with spline
    pt = (kq-min(k))/(max(k)-min(k)) ; px = (px-min(px))/(max(px)-min(px)) ; % unit square
    dx = px-pt ; % difference between x and y
    [pks,Ncomp] = findpeaks(dx,kq) ;
    if length(pks)>1
        warning('multiple knees found, taking one with maximum difference')
        [pks,ni] = max(pks) ; 
        Ncomp = Ncomp(ni) ; 
    end
       
end