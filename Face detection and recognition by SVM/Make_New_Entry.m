function Make_New_Entry(Data_Face)

% Popup an input dilogue box to enter the name of the person
New_Folder_Name = inputdlg('Enter The Name:','Folder Name');

% Get the main code folder name
Main_Folder = cd;

% Change the current Folder to the Database folder
cd('Database');

% Create the new folder with the input name
mkdir(New_Folder_Name{1});

% Change the current directry to the new folder
cd(New_Folder_Name{1});

% Get the New Folder Path
% New_Folder = cd;

% Create two new folders 'Face Database' and 'Palm Database'
% mkdir('Face');

% Change the current directry to Face Database and save the face image
% cd([New_Folder]);

for i = 1:size(Data_Face,4)
    
    filename = [num2str(i),'.pgm'];
    
    imwrite(Data_Face(:,:,:,i),filename);
    
end

% Change the directry back to the main code
cd(Main_Folder);
