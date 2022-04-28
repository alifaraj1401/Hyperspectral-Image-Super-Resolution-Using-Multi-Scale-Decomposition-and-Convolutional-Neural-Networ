clear all; close all; clc;
load('pa_mirror9.mat')
HR3D=data;
scale=2;
i = 1;
HR3D = modcrop(HR3D, scale);
[rows ,cols,band]=size(HR3D);
npatches = band;
appctin=zeros(rows ,cols,band);
appctout=zeros(rows ,cols,band);
detctin=zeros(rows ,cols,band);
detctout1=zeros(rows ,cols,band);
detctout2=zeros(rows ,cols,band);
while i <= npatches
    
    i
    I = HR3D(:,:,i);
    %I=im2double(I);
  
    Ilow = imresize(I,1/scale,'bicubic');
    Ibicubic = imresize(Ilow,scale,'bicubic');
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffshr= nsctdec( I, [0,0], dfilter, pfilter );
    coeffslr= nsctdec( Ibicubic, [0], dfilter, pfilter );
    appctin(: ,:,i)=coeffslr{1};
    appctout(: ,:,i)=coeffshr{1};
    detctin(: ,:,i)=coeffslr{2};
    detctout1(: ,:,i)=coeffshr{2};
    detctout2(: ,:,i)=coeffshr{3};

    i = i + 1;
end
    save('appctin','appctin');
    save('appctout','appctout');
    save('detctin','detctin');
    save('detctout1','detctout1');
    save('detctout2','detctout2');
    
    
