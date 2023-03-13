function [rumination_score] = Extract_Participant_Rumination_Score(rumination_scores, participant_ids, participant_id)

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
rumination_score = rumination_scores(participant_ids == participant_num);
disp(rumination_score);

end