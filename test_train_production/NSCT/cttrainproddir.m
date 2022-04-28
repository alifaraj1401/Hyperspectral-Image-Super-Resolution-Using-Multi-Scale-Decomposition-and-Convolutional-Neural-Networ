clear all; close all; clc;
load('patrain_mirror9.mat')
paviatrain=data;
scale=2;
i = 1;
pavia_train = modcrop(paviatrain, scale);
[rows ,cols,band]=size(pavia_train);
npatches = band;

%appcttrainin=zeros(rows ,cols,band);
detcttrainin11=zeros(rows ,cols,band);
detcttrainin12=zeros(rows ,cols,band);
%detcttrainin2=zeros(rows ,cols,band);
%appcttrainout=zeros(rows ,cols,band);
detcttrainout11=zeros(rows ,cols,band);
detcttrainout12=zeros(rows ,cols,band);
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
    coeffslr= nsctdec( Ibicubic, [1 0], dfilter, pfilter );
    coeffshr= nsctdec( HR, [1 0], dfilter, pfilter );
    
    %appcttrainin(: ,:,i)=Ibicubic-coeffslr{1};
    detcttrainin11(: ,:,i)=coeffslr{2}{1};
    detcttrainin12(: ,:,i)=coeffslr{2}{2};
    %detcttrainin2(: ,:,i)=coeffslr{3};
    %appcttrainout(: ,:,i)=coeffshr{1};
    detcttrainout11(: ,:,i)=coeffshr{2}{1};
    detcttrainout12(: ,:,i)=coeffshr{2}{2};
    %detcttrainout2(: ,:,i)=coeffshr{3};


    i = i + 1;
end

%size(appcttrainin)
size(detcttrainin11)
size(detcttrainin12)

%size(detcttrainin2)
%size(appcttrainout)
size(detcttrainout11)
size(detcttrainout12)

%size(detcttrainout2)

    %save('appcttrainin','appcttrainin');
    save('detcttrainin11','detcttrainin11');
    save('detcttrainin12','detcttrainin12');

    %save('detcttrainin2','detcttrainin2');
    %save('appcttrainout','appcttrainout');
    save('detcttrainout11','detcttrainout11');
    save('detcttrainout12','detcttrainout12');

    %save('detcttrainout2','detcttrainout2');
    
    
