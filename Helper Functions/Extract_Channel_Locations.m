function[channel_names, x_coordinates, y_coordinates, headshape] = Extract_Channel_Locations(channel_information)

%%%
% 

%%%
    channel_information = open(channel_information);
    structure_fieldname = fieldnames(channel_information); %get the field name of the mat object
    channel_information = getfield(channel_information, structure_fieldname{1,1}); %Get the field with the variable name
    channel_names = channel_information.label;
    x_coordinates = cell2mat(channel_information.location(:,1));
    y_coordinates = cell2mat(channel_information.location(:,2));
    headshape = channel_information.headshape;
end

