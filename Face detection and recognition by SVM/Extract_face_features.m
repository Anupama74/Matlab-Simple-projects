function Extract_face_features()

% Get the information of the folder Database
D = dir('Database');

for i2 = 1:5
    facefeatures(i2).F = [];
%     palmfeatures(i2).F = [];
end

faceT = [];
% palmT = struct;
name1 = cell(1,1);
fidx = 0;

for ii = 3:length(D)
    
    % Folder path
    fpath = ['Database/' D(ii).name];
    if isdir(fpath)
        fidx = fidx+1;
        name1{1,fidx} = D(ii).name;
       
        % Get face image
        faceD = dir([fpath '/*.pgm']);
        
        % REad face image
        for nn = 1:length(faceD)
            
            % Create face path
            facepath = [fpath '/' faceD(nn).name];
            
            % Read image
            faceim = imread(facepath);
            
            % If color then convert to gray
            if size(faceim,3)==3
                faceim = rgb2gray(faceim);
            end
            
            % Convert to standard size
            faceim = imresize(faceim,[112 92]);
            
            % Show image
            imshow(faceim);
            title(D(ii).name)
            % Perform curvelet for different level
            opcell = perfrom_curvelet(faceim, 5);
           
            for i2 = 1:length(opcell)
                Ft = facefeatures(i2).F;
                
                % Append
                Ft = [Ft opcell{i2}(:)];
                facefeatures(i2).F = Ft;
            end

            faceT = [faceT ii-2];
            pause(0.001)
        end
 
    end
end

save face facefeatures faceT name1
