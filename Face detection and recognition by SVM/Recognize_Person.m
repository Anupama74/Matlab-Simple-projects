function Person = Recognize_Person(If)

% If color then convert to gray
if size(If,3)==3
    If = rgb2gray(If);
end

% Convert to standard size
If = imresize(If,[112 92]);

% Go for segmentation for palm
% Extract ROI
% Ip = palm_ROI(Ip);

% Convert to standard size
% Ip= imresize(Ip,[150 150]);

%% Recognise Face
load classifier

% Perform curvelet for different level
opcell = perfrom_curvelet(If, 5);

opface = [];
for i2 = 1:length(opcell)
    Ft = opcell{i2}(:);

    % Classify
    % % Make class predictions using the test features.
    predictedLabels = predict(faceC(i2).classifier, Ft');
    
    opface = [opface predictedLabels];
%     % Append
%     Ft = [Ft opcell{i2}(:)];
%     facefeatures(i2).F = Ft;
end

% %% Recognise Palm
% 
% % Perform curvelet for different level
% opcell = perfrom_curvelet(Ip, 5);
% 
% oppalm = [];
% for i2 = 1:length(opcell)
%     Ft = opcell{i2}(:);
% 
%     % Classify
%     % % Make class predictions using the test features.
%     predictedLabels = predict(palmC(i2).classifier, Ft');
%     
%     oppalm = [oppalm predictedLabels];
% %     % Append
% %     Ft = [Ft opcell{i2}(:)];
% %     facefeatures(i2).F = Ft;
% end

%% Decision
% Concatinate both result
op = [opface];

% Find majority voting
for ii = 1:max(op(:))
    
    scores(ii) = sum(op==ii);
    
end

% Find maximum score
[val,ix] = max(scores);

if val>3
    % Recognised person is
    fprintf('Recognised person is %s\n',name1{1,ix});
    Person = name1{1,ix};
else
    fprintf('Recognised person is %s\n','Unknown');
    Person = 'Unrecognizable';
    ss=serial('COM4')
    fopen(ss)
    fprintf(ss,'%s','@1FRN000000')
    fclose(ss)
    run('mainfunction.m')
end
