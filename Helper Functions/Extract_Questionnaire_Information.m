function [information, participant_ids] = Extract_Questionnaire_Information(path)

%%%
% Function that extracts information from an excel file containing the
% questionnaire responses from participants 
% 
% Lore Flipts
%
% INPUT:
%   path: string indicating the path to the excel file with columns
%   Participant_ID, Sex, RRS_TOTAL_SCORE
%
% OUTPUT:
%   information: N*2 double matrix (N = #participants) containing the sex
%       and rumination scores
%   participant_ids: N*1 double matrix containing the participant id's
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