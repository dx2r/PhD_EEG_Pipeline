function [participant_information] = Extract_Participant_Rumination_Scores(information, participant_ids, participant_id)

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
participant_num = regexp(participant_id, '\d+', 'match');
participant_num = str2num(participant_num);
sex = information(1, participant_ids == participant_num);
rumination_score = information(2, participant_ids == participant_num);
%reflection_score = information(3, participant_ids == participant_num);
%brooding_score = information(4, participant_ids == participant_num);
%participant_information = [sex, rumination_score, reflection_score, brooding_score];

participant_information = [sex, rumination_score];
end