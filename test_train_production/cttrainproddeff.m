clear all; close all; clc;
addpath('NSCT')
load('patrain_mirror.mat')
paviatrain=data;
scale=2;
i = 1;
pavia_train = modcrop(paviatrain, scale);
[rows ,cols,band]=size(pavia_train);
npatches = band;

appcttrainin=zeros(rows ,cols,band);
%detcttrainin1=zeros(rows ,cols,band);
%detcttrainin2=zeros(rows ,cols,band);
appcttrainout=zeros(rows ,cols,band);
%detcttrainout1=zeros(rows ,cols,band);
%detcttrainout2=zeros(rows ,cols,band);

while i <= npatches
    
    i
    HR=pavia_train(:,:,i);
    Ilow = imresize(HR,1/scale,'bicubic');
    Ibicubic = imresize(Ilow,scale,'bicubic');
    size(pavia_train)
    size(Ibicubic)
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffslr= nsctdec( Ibicubic, [0 0], dfilter, pfilter );
    coeffshr= nsctdec( HR, [0 0], dfilter, pfilter );

    appcttrainin(: ,:,i)=Ibicubic-coeffslr{1};
    detcttrainin1(: ,:,i)=coeffslr{2};
    detcttrainin2(: ,:,i)=coeffslr{3};
    appcttrainout(: ,:,i)=coeffshr{1}-coeffslr{1};
    detcttrainout1(: ,:,i)=coeffshr{2};
    detcttrainout2(: ,:,i)=coeffshr{3};

    i = i + 1;
end

size(appcttrainin)
%size(detcttrainin1)
%size(detcttrainin2)
size(appcttrainout)
%size(detcttrainout1)
%size(detcttrainout2)

save('appcttrainin','appcttrainin');
save('detcttrainin1','detcttrainin1');
save('detcttrainin2','detcttrainin2');
save('appcttrainout','appcttrainout');
save('detcttrainout1','detcttrainout1');
save('detcttrainout2','detcttrainout2');
    
    
