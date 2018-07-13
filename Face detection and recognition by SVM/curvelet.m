function curvelet(X, R)

% X=double(imread('Lena.jpg'));

% Forward curvelet transform

figure;

for i=1:R

    C = Discrete_curvelet_transform(X,i);

    % Obtain Approx. Curvelet coefficients
    a=C{1};
    A=a{1};

    % Display original image and the curvelet coefficient image
    
%     subplot(1,2,1);
%     imshow(X,[]); 
%     axis('image'); 
%     title('original image');

%     subplot(1,R,i);
%     imshow(abs(A),[]); 
%     axis('image'); 
%     string=['level' num2str(i)];
%     title(string);

end
