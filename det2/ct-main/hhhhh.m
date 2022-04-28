clear all
%%%%%%%%%%%%%%% load net %%%%%%%%%%%%%%

modelfile = 'CNNCTSRAPP.json';
weights = 'CNNCTSRAPP.h5';
netapp = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')

modelfile = 'CNNCTSRDET.json';
weights = 'CNNCTSRDET.h5';
netdet = importKerasNetwork(modelfile,'WeightFile',weights,'OutputLayerType','regression')
%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
nlevels = [0] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter
%%%%%%%%%%%%%%%%%%%%% test image %%%%%%%%%%%%%%%%
%E:\sr-dataset\BSDS300\images\test
trainImagesDir = fullfile('G:\','test','set5');
%trainImagesDir = fullfile('G:\','test','set14');
%trainImagesDir = fullfile('G:\','test','set14','New folder')
%trainImagesDir = fullfile('G:\','test','test');
exts = {'.bmp'};
testIm = imageDatastore(trainImagesDir,'FileExtensions',exts);
npatches = size(testIm.Files,1); 
i = 1;
scale=2;
sumsrssim=0;
sumbicubicssim=0;
sumsrpsnr=0;
sumbicubicpsnr=0;
while i <= npatches
Ireference = readimage(testIm,i);

%% work on illuminance only
if size(Ireference,3)>1
    Ireference = rgb2ycbcr(Ireference);
    Ireference = Ireference(:, :, 1);
end
Iy = Ireference;
%Iy=im2double(Iy);
Iy = modcrop(Iy, scale);
%%%%%%%%%%%%%% Improve Image Resolution Using Bicubic Interpolation %%%%%%%%%%%%%%%
%[nrows ncols]=size(Iy);

Ilow = imresize(Iy,1/scale,'bicubic');
Ibicubic = imresize(Ilow,scale,'bicubic');

%%figure(2),imshow(Ibicubic)
%%title('High-Resolution Image Obtained Using Bicubic Interpolation')
coeffslr= nsctdec(Ibicubic, [0], dfilter, pfilter );
%%%%%%%%%%%% net output %%%%%%%5%
coeffshr=cell(1,3);

app = double(activations(netapp,coeffslr{1}/255,7));
det = double(activations(netdet,coeffslr{2}/100,7));
[nrows ncols]=size(Iy);
coeffslr{1}=coeffslr{1}(7:(nrows-6),7:(ncols-6));
coeffshr{1}=app*255+coeffslr{1};
coeffshr{2}=det(:,:,1)*100;
coeffshr{3}=det(:,:,2)*100;
%coeffshr{2}=det(:,:,1);
%coeffshr{3}=det(:,:,2);
%%%%%%%%%%%% Reconstruct image %%%%%%%5%

imrec = nsctrec( coeffshr, dfilter, pfilter ) ;
%%%%%%%%%%%%%%%%%%%%%%%%%% Visual and Quantitative Comparison %%%%%%%%%%%%%%%%%%%5
imrec=uint8(imrec);
Ibicubic=uint8(Ibicubic);
Iy=uint8(Iy);
[nrows ncols]=size(Iy);
Ibicubic=Ibicubic(7:(nrows-6),7:(ncols-6));
Iy=Iy(7:(nrows-6),7:(ncols-6));
%%figure(4),imshow(Iy)
%%title('High-Resolution Reference Image')
%%figure(5),imshow(Ibicubic)
%%title('Ibicubic Image ')
%%figure(6),imshow(imrec)
%%title('reconstruction Image ')
bicubicPSNR = psnr(Ibicubic,Iy)
srPSNR = psnr(imrec,Iy)
%Measure the structural similarity index (SSIM) of each image.
bicubicSSIM = ssim(Ibicubic,Iy);
srSSIM = ssim(imrec,Iy);
sumsrssim=sumsrssim+srSSIM;
sumbicubicssim=sumbicubicssim+bicubicSSIM;
sumsrpsnr=sumsrpsnr+srPSNR;
sumbicubicpsnr=sumbicubicpsnr+bicubicPSNR;

   
    i = i + 1;
end
npatches
sumsrssim=sumsrssim/npatches
sumbicubicssim=sumbicubicssim/npatches
sumsrpsnr=sumsrpsnr/npatches
sumbicubicpsnr=sumbicubicpsnr/npatches
figure(1),imshow(Iy);
title('High-Resolution Reference Image')
figure(2),imshow(Ibicubic);
title('Ibicubic Image')
figure(3),imshow(imrec);
title('imrec Image')