clear all
clc
n=15;

matpsnr1=zeros(n,3);
matssim1=zeros(n,3);
matsam1=zeros(n,3);
matergas1=zeros(n,3);


load('ctmatpsnrl1.mat');
load('ctmatssiml1.mat');
load('ctmatsaml1.mat');
load('ctmatergasl1.mat');


matpsnr1(:,1)=matpsnr(1:n,2);
matpsnr1(:,2)=matpsnr(1:n,1);

matssim1(:,1)=matssim(1:n,2);
matssim1(:,2)=matssim(1:n,1);

matsam1(:,1)=matsam(1:n,2);
matsam1(:,2)=matsam(1:n,1);

matmatergas1(:,1)=matergas(1:n,2);
matmatergas1(:,2)=matergas(1:n,1);

load('ctmatpsnrl2.mat');
load('ctmatssiml2.mat');
load('ctmatsaml2.mat');
load('ctmatergasl2.mat');

matpsnr1(:,3)=matpsnr(1:n,1);
matssim1(:,3)=matssim(1:n,1);
matsam1(:,3)=matsam(1:n,1);
matmatergas1(:,3)=matergas(1:n,1);

figure(11)
plot(1:n,matpsnr1(:,1),'g')
hold on
plot(1:n,matpsnr1(:,2),'r')
hold on
plot(1:n,matpsnr1(:,3),'b')
hold off
legend('INTERPOL','3dcnn', 'ct3dcnn','Location', 'SouthEast')
title('PSNR')

figure(12)
plot(1:n,matssim1(:,1),'g')
hold on
plot(1:n,matssim1(:,2),'r')
hold on
plot(1:n,matssim1(:,3),'b')
hold off
legend('INTERPOL', '3dcnn', 'ct3dcnn','Location', 'SouthEast')
title('SSIM')

figure(13)
plot(1:n,matsam1(:,1),'g')
hold on
plot(1:n,matsam1(:,2),'r')
hold on
plot(1:n,matsam1(:,3),'b')

hold off
legend('INTERPOL','3dcnn', 'ct3dcnn','Location', 'SouthEast')
title('SAM')

figure(14)
plot(1:n,matmatergas1(:,1),'g')
hold on
plot(1:n,matmatergas1(:,2),'r')
hold on
plot(1:n,matmatergas1(:,3),'b')
hold off
legend('INTERPOL', '3dcnn', 'ct3dcnn','Location', 'SouthEast')
title('ERGAS')


