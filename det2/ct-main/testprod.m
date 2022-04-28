clear all; close all; clc;
load('pa_mirror9.mat')
HR3D=data;
scale=2;
i = 1;
HR3D = modcrop(HR3D, scale);
[rows ,cols,band]=size(HR3D);
npatches = band;
a=100;
b=200;
c=6;
bandmirr=8;
appcttestin=zeros(a ,a,band);
detcttestin=zeros(a ,a,band);
outgroung=zeros(a-2*c,a-2*c,band);
size(outgroung)
outinterpol=zeros(a-2*c,a-2*c,band);
size(outinterpol)
while i <= npatches
    
    i
    I = HR3D(a:b-1,a:b-1,i);
    size(I)
    %I=im2double(I);
  
    Ilow = imresize(I,1/scale,'bicubic');
    Ibicubic = imresize(Ilow,scale,'bicubic');
    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
    coeffslr= nsctdec( Ibicubic, [0], dfilter, pfilter );
    appcttestin(: ,:,i)=coeffslr{1};
    detcttestin(: ,:,i)=coeffslr{2};
    outgroung(: ,:,i)=I(c+1:a-c ,c+1:a-c);
    outinterpol(: ,:,i)=Ibicubic(c+1:a-c ,c+1:a-c);
    i = i + 1;
end
outgroung=outgroung(: ,:,bandmirr/2+1:band-(bandmirr/2));
outinterpol=outinterpol(: ,:,bandmirr/2+1:band-(bandmirr/2));
size(appcttestin)
size(detcttestin)
size(outgroung)
size(outinterpol)
    save('appcttestin','appcttestin');
    save('detcttestin','detcttestin');
    save('outgroung','outgroung');
    save('outinterpol','outinterpol');
    
    
