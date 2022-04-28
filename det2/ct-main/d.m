clear all; close all; clc;
%E:\sr-dataset\ourBSD\train
%E:\sr-dataset\ourBSD\val
%trainImagesDir = fullfile('E:\','sr-dataset','ukbench100');
%trainImagesDir = fullfile('E:\','sr-dataset','ourBSD','train');
trainImagesDir = fullfile('E:\','sr-dataset','ourBSD','val');
%E:\sr-dataset\eee\BSDS300\images\train
%trainImagesDir = fullfile('E:\','sr-dataset','ggggg');
exts = {'.jpg'};
imagefiles = imageDatastore(trainImagesDir,'FileExtensions',exts);
npatches = size(imagefiles.Files,1); 

i = 1;

while i <= npatches
    
    fprintf('Generating patch # %d \n', i)
    Iycbcr = rgb2ycbcr(readimage(imagefiles,i));
    I = Iycbcr(:,:,1);
    %I=im2double(I);
    I = modcrop(I, 2);
    [rows ,cols]=size(I);  
    Ilow = imresize(I,0.5,'bicubic');
    Ibicubic = imresize(Ilow,[rows cols],'bicubic');
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffshr= nsctdec( I, [0,0], dfilter, pfilter );
    coeffslr= nsctdec( Ibicubic, [0], dfilter, pfilter );
            
    inapp=coeffslr{1}/255;
    outapp=(coeffshr{1}-coeffslr{1})/255;
    
    indet=coeffslr{2}/100;
    outdet=zeros(rows ,cols,2);
    outdet(:,:,1)=coeffshr{2}/100;
    outdet(:,:,2)=(coeffshr{2}-coeffshr{3})/100;


    save(['inapp' num2str(i) '.mat'],'inapp'); 
    save(['indet' num2str(i) '.mat'],'indet');  
    save(['outapp' num2str(i) '.mat'],'outapp');
    save(['outdet' num2str(i) '.mat'],'outdet');

    i = i + 1;
end