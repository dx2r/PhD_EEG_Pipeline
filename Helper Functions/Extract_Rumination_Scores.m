function [information, participant_ids] = Extract_Rumination_Scores(path)

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

participant_ids = [trait_questionnaires.Participant_ID];
information = zeros(2, length(participant_ids));

information(1,:) = [trait_questionnaires.Sex];
information(2,:) = [trait_questionnaires.RRS_TOTAL_SCORE];
%information(3,:) = [trait_questionnaires.RRS_REFLECTION_SCORE];
%information(4,:) = [trait_questionnaires.RRS_BROODING_SCORE];

end