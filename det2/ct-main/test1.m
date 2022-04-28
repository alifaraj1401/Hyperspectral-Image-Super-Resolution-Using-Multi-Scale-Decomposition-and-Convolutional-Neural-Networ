clc
clear all
load('pa_mirror9.mat')
%HR=imread('lena.bmp');
HR=data(100:200,100:200,25);
%im=im2double(im);
%figure,imshow(HR)
if size(HR,3)>1
    HR = rgb2ycbcr(HR);
    HR = HR(:, :, 1);
end
[nrows ncols]=size(HR);
scaleFactor = 0.5;
Ilow = imresize(HR,scaleFactor,'bicubic');

Ibicubic = imresize(Ilow,[nrows ncols],'bicubic');
%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%

%nlevels = [0,0,0,0] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter
%%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%

coeffshr= nsctdec( HR, [0,0], dfilter, pfilter );

coeffslr= nsctdec( Ibicubic, [0], dfilter, pfilter );
%%%%%%%%%%%%% Display the coefficients %%%%%%%%%%%%%%%

disp('Displaying the contourlet coefficients...HR') ;
shownsct( coeffshr) ;
disp('Displaying the contourlet coefficients...LR') ;
shownsct( coeffslr) ;
%%%%%%%%%%%% Reconstruct image %%%%%%%%

imrec = nsctrec( coeffshr, dfilter, pfilter ) ;
figure(6),imshow((HR))
title('ground true')
figure(7),imshow((imrec))
title('imrec')
%%%%%%%%%%%%% Display the reconstructed image %%%%%%%%%%%%%%%
%figure(5),imshow(uint8(imrec))
figure(10),histogram(coeffshr{1})
title('coeffshr{1}')
figure(11),histogram(coeffshr{2})
title('coeffshr{2}')
figure(12),histogram(coeffshr{3})
title('coeffshr{3}')
figure(14),histogram(coeffslr{1})
title('coeffslr{1}')
figure(15),histogram(coeffslr{2})
title('coeffslr{2}')
