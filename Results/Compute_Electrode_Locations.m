% dataset2_locations = cell(length(electrode_names),3);
% electrode_names{127,1} = 'Cz';
% for i = 1:length(electrode_names)
%     electrode_name = electrode_names{i,1};
%     dataset2_locations{i,1} = electrode_name;
%     for j = 1:length(lay.label)
%         label = lay.label(j);
%         label = label{1,1};
%         newLabel = insertAfter(label,"E","EG");
%         if strcmp(newLabel,electrode_name) == 1
%             dataset2_locations{i,2} = lay.pos(j,1);
%             dataset2_locations{i,3} = lay.pos(j,2);
%         end
%     end
% end

lay.label{132,1} = 'EEGVREF';
electrode_names = transpose(label_order);
sum = 0;
locations = cell(length(electrode_names),2);
for i = 1:length(electrode_names)
    electrode_name = electrode_names{i,1};
    electrode_information.label{i,1} = electrode_name;
    for j = 1:length(lay.label)
         label = lay.label(j);
         label = label{1,1};
         if strcmp(label,'EEGVREF') == 0
            label = insertAfter(label,"E","EG");
         end
         if strcmp(label,electrode_name) == 1
             sum = sum + 1;
             electrode_information.location{i,1} = lay.pos(j,1);
             electrode_information.location{i,2} = lay.pos(j,2);
         end
    end
end
disp(sum)
electrode_information.headshape = lay.outline;

figure;
for i = 1:length(electrode_information.headshape)
    line(electrode_information.headshape{1,i}(:,1), electrode_information.headshape{1,i}(:,2));
    hold on
end
axis square


