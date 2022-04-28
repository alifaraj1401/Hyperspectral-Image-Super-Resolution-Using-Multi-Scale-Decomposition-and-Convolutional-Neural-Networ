clear all; close all; clc;
addpath('NSCT')
load('paviatest_mirror.mat')
testin=data;
scale=2;
i = 1;
c=12;
testin = modcrop(testin, scale);
[rows ,cols,band]=size(testin);
npatches = band;

appcttestin=zeros(rows ,cols,band);
detcttestin1=zeros(rows ,cols,band);
detcttestin2=zeros(rows ,cols,band);
outground=testin(c/2+1:rows-c/2 ,c/2+1:cols-c/2,5:106);
ininterpol=zeros(rows ,cols,band);
while i <= npatches
    
    i
    Ilow = imresize(testin(:,:,i),1/scale,'bicubic');
    Ibicubic = imresize(Ilow,scale,'bicubic');
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffslr= nsctdec( Ibicubic, [0 0], dfilter, pfilter );
    
    appcttestin(: ,:,i)=coeffslr{1};
    detcttestin1(: ,:,i)=coeffslr{2};
    detcttestin2(: ,:,i)=coeffslr{3}; 
    ininterpol(: ,:,i)=Ibicubic;

    i = i + 1;
end


save('appcttestin','appcttestin');
save('detcttestin1','detcttestin1');
save('detcttestin2','detcttestin2');
save('outground','outground');
save('ininterpol','ininterpol');    
    
