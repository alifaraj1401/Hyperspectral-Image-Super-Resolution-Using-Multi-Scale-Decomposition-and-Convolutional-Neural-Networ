clc
clear all
load('appoutput.mat')
load('detoutput.mat')
detoutput1=detoutput(:,:,:,1);
detoutput2=detoutput(:,:,:,2);
[rows ,cols,band]=size(appoutput);
size(appoutput)
size(detoutput1)
size(detoutput2)
npatches = band;
recout=zeros(rows ,cols,band);
i = 1;
while i <= npatches
    
    i
    app = appoutput(:,:,i);
    det1 = detoutput1(:,:,i);
    det2 = detoutput2(:,:,i);
    coeffshr=cell(1,3);
    coeffshr{1}=double(app);
    coeffshr{2}=double(det1);
    coeffshr{3}=double(det2);
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet reconstruction %%%%%%%%%%%%%%%%
    imrec = nsctrec( coeffshr, dfilter, pfilter ) ;
    size(imrec)
    recout(:,:,i)=imrec;
    i = i + 1;
end
    size(recout)
    save('recout','recout');
