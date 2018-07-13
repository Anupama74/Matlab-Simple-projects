function Update_Existing(val,Data_Face)

% Get the current main directry
Main_Folder = cd;

% Change the current directry to the Database folder
cd('Database');

% Get all the folders from the directry
Folder_Contents = ls;

for i = 3:size(Folder_Contents,1)
    
    % Compare the input folder name and folder contents
    if strcmpi(val,strtrim(Folder_Contents(i,:)))
        
        % Change the current directry to that folder
        cd(Folder_Contents(i,:));
        
        % Get the Directry
%         Updating_Folder = cd;
        
        % Change the current directry to Face Database
%         cd('Face');
        
        % Get the contents of the folder
        Faces = dir;
        
        % Get the total no. of faces
        No_of_Faces = size(Faces,1)-2;
        
        j = 1;
        
        for i = No_of_Faces+1:No_of_Faces+size(Data_Face,4)
    
            filename = [num2str(i),'.pgm'];
    
            imwrite(Data_Face(:,:,:,j),filename);
            
            j = j+1;
    
        end
        
        % Break the loop
        break;
        
    end
    
end

% Go back to the main Folder
cd(Main_Folder);
