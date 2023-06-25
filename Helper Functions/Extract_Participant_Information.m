function [participant_information] = Extract_Participant_Information(information, participant_ids, participant_id)

%%%
% Function that matches participant ID to the participant information
% including sex and rumination score
% 
% Lore Flipts
%
% INPUT:
%   data: N*P double matrix. (N = #timeseries, M = #gfp peaks) 
%   microstates_amount: N*K double matrix (N = #timeseries, K = #amount of microstates)
%   labels: N*1 double matrix indicating microstate labels
%
% OUTPUT:
%   dispersion: double indicating the total dispersion across all clusters
%
%%%

participant_num = regexp(participant_id, '\d+', 'match');
participant_num = str2num(participant_num);
sex = information(1, participant_ids == participant_num);
rumination_score = information(2, participant_ids == participant_num);
%reflection_score = information(3, participant_ids == participant_num);
%brooding_score = information(4, participant_ids == participant_num);
%participant_information = [sex, rumination_score, reflection_score, brooding_score];

participant_information = [sex, rumination_score];
end