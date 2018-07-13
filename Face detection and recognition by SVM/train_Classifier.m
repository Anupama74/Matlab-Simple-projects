function train_Classifier()

load face 

% Train SVM for face
faceC = struct;

h1 = waitbar(0,'Please wait while training...!');
for ii = 1:5
    waitbar(ii/5);
    Xf = facefeatures(ii).F;
    Yf = faceT;
    % fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
    classifier = fitcecoc(Xf', Yf');
    
    % Save classifier
    faceC(ii).classifier = classifier;
end

close(h1)

save classifier faceC name1

msgbox('Training is done')
