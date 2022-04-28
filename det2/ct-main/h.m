clear all
%%%%%%%%%%%%%%% load net %%%%%%%%%%%%%%
modelfile = 'CNNCTSRAPP.json';
weights = 'CNNCTSRAPP.h5';
netapp = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')

modelfile = 'CNNCTSRDET.json';
weights = 'CNNCTSRDET.h5';
netdet = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')
%%%%%%%%%%%%%%%%%%%%% test image %%%%%%%%%%%%%%%%
trainImagesDir = fullfile('G:\','test');
exts = {'.jpg'};
testIm = imageDatastore(trainImagesDir,'FileExtensions',exts);
Ireference = readimage(testIm,9);
%Ireference = im2double(Ireference);

%%%%%%%%%%%%%%%%%%%%%%%%% Create a low-resolution %%%%%%%%%%%%%%%%%%%%%%%
Iycbcr = rgb2ycbcr(Ireference);
Iy = Iycbcr(:,:,1);
Iy=im2double(Iy);
%figure(1),imshow(Iy)
%title('High-Resolution Reference Image')
%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
nlevels = [2] ;        % Decomposition level
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

coeffs=cell(1,2);
%%%%%%%%%%%% net output %%%%%%%5%
app = double(activations(netapp,Ibicubic,7));
det = double(activations(netdet,Ibicubic,7));

figure(1),imshow(det(:,:,1))
figure(2),imshow(det(:,:,2))
figure(3),imshow(det(:,:,3))
figure(4),imshow(det(:,:,4))
coeffs{1}=app;
coeffs{2}{1}=det(:,:,1);
coeffs{2}{2}=det(:,:,2);
coeffs{2}{3}=det(:,:,3);
coeffs{2}{4}=det(:,:,4);
%%%%%%%%%%%% Reconstruct image %%%%%%%5%

imrec = nsctrec( coeffs, dfilter, pfilter ) ;

%%%%%%%%%%%%%%%%%%%%%%%%%% Visual and Quantitative Comparison %%%%%%%%%%%%%%%%%%%5
imrec = shave(uint8(imrec * 255), [up_scale, up_scale]);
Iy = shave(uint8(Iy * 255), [up_scale, up_scale]);
Ibicubic = shave(uint8(Ibicubic * 255), [up_scale, up_scale]);
[nrows ncols]=size(Ibicubic);
Ibicubic=Ibicubic(7:(nrows-6),7:(ncols-6));
Iy=Iy(7:(nrows-6),7:(ncols-6));

figure(5),imshow(Iy)
title('High-Resolution Reference Image')
figure(6),imshow(Ibicubic)
title('Ibicubic Image ')
figure(7),imshow(uint8(imrec))
title('reconstruction Image ')
imrec=uint8(imrec);
bicubicPSNR = psnr(Ibicubic,Iy)
vdsrPSNR = psnr(imrec,Iy)

%Measure the structural similarity index (SSIM) of each image.
bicubicSSIM = ssim(Ibicubic,Iy)
vdsrSSIM = ssim(imrec,Iy)

