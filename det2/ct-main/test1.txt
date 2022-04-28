im=imread('lena.bmp');
%im=im2double(im);
figure,imshow(im)
%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%

nlevels = [2,2] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter
%%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%

coeffs= nsctdec( im, nlevels, dfilter, pfilter );
%%%%%%%%%%%%% Display the coefficients %%%%%%%%%%%%%%%

disp('Displaying the contourlet coefficients...') ;
shownsct( coeffs) ;

%%%%%%%%%%%% Reconstruct image %%%%%%%%

imrec = nsctrec( coeffs, dfilter, pfilter ) ;
%%%%%%%%%%%%% Display the reconstructed image %%%%%%%%%%%%%%%
disp('Displaying the reconstructed image...') ;
figure(5),imshow(uint8(imrec))
figure(6),histogram(im)
figure(7),histogram(coeffs{1})
figure(8),histogram(coeffs{2}{1})
figure(9),histogram(coeffs{3}{1})