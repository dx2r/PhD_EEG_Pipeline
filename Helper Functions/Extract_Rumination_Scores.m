function [rumination_scores, participant_ids] = Extract_Rumination_Scores(path)

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

trait_questionnaires = Open_Excel_File(path);
trait_questionnaires = table2struct(trait_questionnaires);
rumination_scores = [trait_questionnaires.RRS_TOTAL_SCORE];
participant_ids = [trait_questionnaires.Participant_ID];

end