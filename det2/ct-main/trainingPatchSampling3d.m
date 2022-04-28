clear all; close all; clc;
%F:\CNNWSR-master\BSDS300-images\BSDS300\images\train
%G:\my works\02
%F:\CNNWSR\TEST\BSDS300-images\BSDS300\images\train
%G:\my works\papers-files\CNNWSR\back up\BSDS300-images\BSDS300\images\train
%trainImagesDir = fullfile('G:\','my works','papers-files','CNNWSR','back up','BSDS300-images','BSDS300','images','train');
trainImagesDir = fullfile('G:\','my works','02');
exts = {'.jpg'};
imagefiles = imageDatastore(trainImagesDir,'FileExtensions',exts);

%imdir = './ourBSD/train';
%imagefiles = dir([imdir, '/*.jpg']);

npatches = 50000; %number of patches required
insize = 39; outsize = 21; % input-output patch sizes
inhalf = floor(insize/2);outhalf = floor(outsize/2);
inoutdiff = insize - outsize;
%wavelet = 'db9'; % wavelet choice
i = 1;
in = zeros(npatches, insize*insize);
outdet = zeros(npatches, outsize*outsize,4);
    %%%%%% NSCT transform %%%%%%%%%%
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%

nlevels = [2] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter

while i <= npatches
    
    %%%%%%%%% Randomly pick up an image %%%%%%%%
    fprintf('Generating patch # %d \n', i)
    r = randi([1 size(imagefiles.Files,1)],1,1);
    Iycbcr = rgb2ycbcr(readimage(imagefiles,r));
    %I = rgb2gray(readimage(imagefiles,r));
    I = Iycbcr(:,:,1);
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%

    coeffs= nsctdec( I, nlevels, dfilter, pfilter );
    approx=coeffs{1};
    det1=coeffs{2}{1};
    det2=coeffs{2}{2};
    det3=coeffs{2}{3};
    det4=coeffs{2}{4};
    % Generate bounds for patch sampling
    xbounds = [insize+1, size(approx,1)-insize];
    ybounds = [insize+1,size(approx,2)-insize];
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %1 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %2 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %3 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %4 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %5 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %6 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %7 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %8 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %9 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
    %10 Generate patch sampling indices
    xind = randi([xbounds(1) xbounds(2)],1,1);
    yind = randi([ybounds(1) ybounds(2)],1,1);  
    % Sample input patch
    inpatch   = approx(xind-inhalf:xind+inhalf, yind-inhalf:yind+inhalf);
    detpatch1 = det1(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch2 = det2(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch3 = det3(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    detpatch4 = det4(xind-outhalf:xind+outhalf, yind-outhalf:yind+outhalf);
    in(i,:) = inpatch(:)';
    outdet(i,:,1) = detpatch1(:)';
    outdet(i,:,2) = detpatch2(:)';
    outdet(i,:,3) = detpatch3(:)';
    outdet(i,:,4) = detpatch4(:)';
    i = i + 1;
    
end
in3921=in;
outdet3921=outdet;
save('in3921','in3921');
save('outdet3921','outdet3921');

