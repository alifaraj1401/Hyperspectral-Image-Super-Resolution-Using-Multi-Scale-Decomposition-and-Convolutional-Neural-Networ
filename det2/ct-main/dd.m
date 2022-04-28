clear all; close all; clc;
%E:\examing\images\val-image
%E:\sr-dataset\ukbench100
%E:\New folder\test
%trainImagesDir = fullfile('E:\','sr-dataset','ukbench100');
trainImagesDir = fullfile('E:\','New folder','test');
exts = {'.jpg'};
imagefiles = imageDatastore(trainImagesDir,'FileExtensions',exts);
npatches = size(imagefiles.Files,1); 

i = 1;

while i <= npatches
    
    fprintf('Generating patch # %d \n', i)
    Iycbcr = rgb2ycbcr(readimage(imagefiles,i));
    I = Iycbcr(:,:,1);
    I=im2double(I);
    I = modcrop(I, 2);
    [rows ,cols]=size(I); 
    Ilow = imresize(I,0.5,'bicubic');
    Ibicubic = imresize(Ilow,[rows cols],'bicubic');
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    nlevels = [2,2] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffs= nsctdec( I, nlevels, dfilter, pfilter );
    outdet2=zeros(rows ,cols,4);
    outdet3=zeros(rows ,cols,4);
    in=Ibicubic;
    outapp=coeffs{1};
    outdet2(:,:,1)=coeffs{2}{1};
    outdet2(:,:,2)=coeffs{2}{2};
    outdet2(:,:,3)=coeffs{2}{3};
    outdet2(:,:,4)=coeffs{2}{4};
    
    outdet3(:,:,1)=coeffs{3}{1};
    outdet3(:,:,2)=coeffs{3}{2};
    outdet3(:,:,3)=coeffs{3}{3};
    outdet3(:,:,4)=coeffs{3}{4};

    save(['in' num2str(i) '.mat'],'in');  
    save(['outapp' num2str(i) '.mat'],'outapp');
    save(['outdet2' num2str(i) '.mat'],'outdet2');
    save(['outdet3' num2str(i) '.mat'],'outdet3');
  
    i = i + 1;
end