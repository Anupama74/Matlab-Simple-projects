function Folder_Names = Get_Folders()

% Get the main code folder name
Main_Folder = cd;

% Change the current directry to the Database folder
cd('Database');

% Get the contents of the current directry
Folder_Contents = dir;

% Initialyze the output variable
Folder_Names = {'New Entry'};

% Check weather all the contents of the folder are folders
for i = 3:length(Folder_Contents)
    
    if isdir(Folder_Contents(i).name)
        
        % List all the Folders in the Directry
        Folder_Names(i-1,:) = {Folder_Contents(i).name};
        
    end
    
end

% Change the directry back to the main code
cd(Main_Folder);