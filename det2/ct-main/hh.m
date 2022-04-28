clear all
%%%%%%%%%%%%%%% load net %%%%%%%%%%%%%%
modelfile = 'CNNCTSRAPP.json';
weights = 'CNNCTSRAPP.h5';
netapp = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')

modelfile = 'CNNCTSRDET2.json';
weights = 'CNNCTSRDET2.h5';
netdet2 = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')

modelfile = 'CNNCTSRDET3.json';
weights = 'CNNCTSRDET3.h5';
netdet3 = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')
%%%%%%%%%%%%%%%%%%%%% test image %%%%%%%%%%%%%%%%
trainImagesDir = fullfile('G:\','test');
exts = {'.jpg'};
testIm = imageDatastore(trainImagesDir,'FileExtensions',exts);
Ireference = readimage(testIm,4);
%Ireference = im2double(Ireference);

%%%%%%%%%%%%%%%%%%%%%%%%% Create a low-resolution %%%%%%%%%%%%%%%%%%%%%%%
Iycbcr = rgb2ycbcr(Ireference);
Iy = Iycbcr(:,:,1);
Iy=im2double(Iy);
%figure(1),imshow(Iy)
%title('High-Resolution Reference Image')
%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
nlevels = [2,2] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter
%%%%%%%%%%%%%%%%%%%%%%%%%% Improve Image Resolution Using Bicubic Interpolation %%%%%%%%%%%%%%%
[nrows ncols]=size(Iy);
scaleFactor = 0.5;
Ilow = imresize(Iy,scaleFactor,'bicubic');

Ibicubic = imresize(Ilow,[nrows ncols],'bicubic');
%figure(2),imshow(Ibicubic)
%title('High-Resolution Image Obtained Using Bicubic Interpolation')

up_scale = 2;

coeffs=cell(1,3);
%%%%%%%%%%%% net output %%%%%%%5%
app = double(activations(netapp,Ibicubic,7));
det2 = double(activations(netdet2,Ibicubic,7));
det3 = double(activations(netdet3,Ibicubic,7));
figure(1),imshow(det2(:,:,1))
figure(2),imshow(det2(:,:,2))
figure(3),imshow(det2(:,:,3))
figure(4),imshow(det2(:,:,4))
figure(5),imshow(det3(:,:,1))
figure(6),imshow(det3(:,:,2))
figure(7),imshow(det3(:,:,3))
figure(8),imshow(det3(:,:,4))
coeffs{1}=app;
coeffs{2}{1}=det2(:,:,1);
coeffs{2}{2}=det2(:,:,2);
coeffs{2}{3}=det2(:,:,3);
coeffs{2}{4}=det2(:,:,4);
coeffs{3}{1}=det3(:,:,1);
coeffs{3}{2}=det3(:,:,2);
coeffs{3}{3}=det3(:,:,3);
coeffs{3}{4}=det3(:,:,4);
%%%%%%%%%%%% Reconstruct image %%%%%%%5%

imrec = nsctrec( coeffs, dfilter, pfilter ) ;
figure(55),imshow(imrec)
%%%%%%%%%%%%%%%%%%%%%%%%%% Visual and Quantitative Comparison %%%%%%%%%%%%%%%%%%%5
imrec=uint8(imrec);
Ibicubic=uint8(Ibicubic);
Iy=uint8(Iy);
%imrec = shave(uint8(imrec * 255), [up_scale, up_scale]);
%Iy = shave(uint8(Iy * 255), [up_scale, up_scale]);
%Ibicubic = shave(uint8(Ibicubic * 255), [up_scale, up_scale]);
[nrows ncols]=size(Ibicubic);
Ibicubic=Ibicubic(7:(nrows-6),7:(ncols-6));
Iy=Iy(7:(nrows-6),7:(ncols-6));

figure(9),imshow(Iy)
title('High-Resolution Reference Image')
figure(10),imshow(Ibicubic)
title('Ibicubic Image ')
figure(11),imshow(uint8(imrec))
title('reconstruction Image ')
%imrec=uint8(imrec);
bicubicPSNR = psnr(Ibicubic,Iy)
vdsrPSNR = psnr(imrec,Iy)

%Measure the structural similarity index (SSIM) of each image.
bicubicSSIM = ssim(Ibicubic,Iy)
vdsrSSIM = ssim(imrec,Iy)

%Measure perceptual image quality using the Naturalness Image Quality Evaluator (NIQE). Smaller NIQE scores indicate better perceptual quality. See niqe for more information about this metric.
bicubicNIQE = niqe(Ibicubic)
vdsrNIQE = niqe(imrec)
