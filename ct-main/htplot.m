clear all
clc
scale=2;
n=10;
addpath('NSCT')
addpath('trainedNET')
%%%%%%%%%%%%%%% load net %%%%%%%%%%%%%%
load('appcttestin.mat');
load('detcttestin1.mat');
load('detcttestin2.mat');
load('ininterpol.mat');
load('outground.mat');
[row ,col,band]=size(outground);
outrecon=zeros(row ,col,band);
[rows ,cols,bandd]=size(appcttestin);
mapsnrsr=zeros(n,2);
mapsnrinter=zeros(n,2);

mapssimsr=zeros(n,2);
mapssiminter=zeros(n,2);

mapsamsr=zeros(n,2);
mapsaminter=zeros(n,2);

mapergassr=zeros(n,2);
mapergasinter=zeros(n,2);


    %%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
    %nlevels = [0,0] ;        % Decomposition level
    pfilter = 'pyr' ;        % Pyramidal filter
    dfilter = 'dmaxflat7' ;      % Directional filter
    %%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%

for j=1:n
netapp = importKerasNetwork(['checkpointapp (' num2str(j) ').h5'],'OutputLayerType','regression');
netdet1 = importKerasNetwork(['checkpointdet1 (' num2str(j) ').h5'],'OutputLayerType','regression');
netdet2 = importKerasNetwork(['checkpointdet2 (' num2str(j) ').h5'],'OutputLayerType','regression');
outpredectapp = double(activations(netapp,ininterpol-appcttestin,9));
outpredectdet1 = double(activations(netdet1,detcttestin1,7));
outpredectdet2 = double(activations(netdet2,detcttestin2,7));

appcttestinn=appcttestin(7:rows-6 ,7:cols-6,5:bandd-4) ;   
 i=1;
   
 while i <= band
    
   
coeffshr=cell(1,3);
coeffshr{1}=outpredectapp(: ,:,i)+appcttestinn(: ,:,i);
coeffshr{2}=outpredectdet1(: ,:,i);
coeffshr{3}=outpredectdet2(: ,:,i);

imrecg = nsctrec( coeffshr, dfilter, pfilter ) ;
outrecon(:,:,i)=imrecg;
    i = i + 1;
end 
outinterpol=ininterpol(7:rows-6 ,7:cols-6,5:bandd-4);
MPSNRPREDICT = PSNRHSI(outground,outrecon);
MPSNRINTERPOL = PSNRHSI(outground,outinterpol);

MSSIMPREDICT = SSIMHSI(outground,outrecon);
MSSIMINTERPOL = SSIMHSI(outground,outinterpol);

[angle_SAMPREDICT,map] = SAM(outground,outrecon);
[angle_SAMINTERPOL,map] = SAM(outground,outinterpol);

ERGASPREDICT= ERGAS(outground,outrecon,scale);
ERGASINTERPOL= ERGAS(outground,outinterpol,scale);

mapsnrsr(j,1)=j;
mapsnrinter(j,1)=j;
mapssimsr(j,1)=j;
mapssiminter(j,1)=j;
mapsamsr(j,1)=j;
mapsaminter(j,1)=j;
mapergassr(j,1)=j;
mapergasinter(j,1)=j;

mapsnrsr(j,2)=MPSNRPREDICT;
mapsnrinter(j,2)=MPSNRINTERPOL;

mapssimsr(j,2)=MSSIMPREDICT;
mapssiminter(j,2)=MSSIMINTERPOL;

mapsamsr(j,2)=angle_SAMPREDICT;
mapsaminter(j,2)=angle_SAMINTERPOL;

mapergassr(j,2)=ERGASPREDICT;
mapergasinter(j,2)=ERGASINTERPOL;
j
end
figure(1),imshow(outground(:,:,25))
rectangle('Position',[95 30 35 35],'EdgeColor','b','LineWidth',2)
rectangle('Position',[5 10 35 35],'EdgeColor','g','LineWidth',2)

hold on
imm1=outground(10:45,5:40,25);
imm2=outground(30:65,95:130,25);
imshow(imm1,  'XData', [1 70],'YData',[68 138]);
imshow(imm2,  'XData', [72 138],'YData',[72 138]);
rectangle('Position',[1 68 70 70],'EdgeColor','g','LineWidth',2)
rectangle('Position',[72 72 66 66],'EdgeColor','b','LineWidth',2)
title('Ground-Truth')
hold off

figure(2),imshow(outinterpol(:,:,25))
rectangle('Position',[95 30 35 35],'EdgeColor','b','LineWidth',2)
rectangle('Position',[5 10 35 35],'EdgeColor','g','LineWidth',2)
hold on
imm1=outinterpol(10:45,5:40,25);
imm2=outinterpol(30:65,95:130,25);
imshow(imm1,  'XData', [1 70],'YData',[68 138]);
imshow(imm2,  'XData', [72 138],'YData',[72 138]);
rectangle('Position',[1 68 70 70],'EdgeColor','g','LineWidth',2)
rectangle('Position',[72 72 66 66],'EdgeColor','b','LineWidth',2)
title('interpol')
hold off

figure(3),imshow(outrecon(:,:,25))
rectangle('Position',[95 30 35 35],'EdgeColor','b','LineWidth',2)
rectangle('Position',[5 10 35 35],'EdgeColor','g','LineWidth',2)
hold on
imm1=outrecon(10:45,5:40,25);
imm2=outrecon(30:65,95:130,25);
imshow(imm1,  'XData', [1 70],'YData',[68 138]);
imshow(imm2,  'XData', [72 138],'YData',[72 138]);
rectangle('Position',[1 68 70 70],'EdgeColor','g','LineWidth',2)
rectangle('Position',[72 72 66 66],'EdgeColor','b','LineWidth',2)
title('outrecon')
hold off

matpsnr=[mapsnrsr(:,2),mapsnrinter(:,2)]
matssim=[mapssimsr(:,2),mapssiminter(:,2)]
matsam=[mapsamsr(:,2),mapsaminter(:,2)]
matergas=[mapergassr(:,2),mapergasinter(:,2)]
save('ctmatpsnrnn.mat','matpsnr');
save('ctmatssimnn.mat','matssim');
save('ctmatsamnn.mat','matsam');
save('ctmatergasnn.mat','matergas');

save('outreconct.mat','outrecon');
save('outinterpol.mat','outinterpol');
save('outground.mat','outground');