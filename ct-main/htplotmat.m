clear all
clc
n=10;

matpsnr1=zeros(n,2);
matssim1=zeros(n,2);
matsam1=zeros(n,2);
matergas1=zeros(n,2);


load('ctmatpsnrnn.mat');
load('ctmatssimnn.mat');
load('ctmatsamnn.mat');
load('ctmatergasnn.mat');


matpsnr1(:,1)=matpsnr(:,2);
matpsnr1(:,2)=matpsnr(:,1);

matssim1(:,1)=matssim(:,2);
matssim1(:,2)=matssim(:,1);

matsam1(:,1)=matsam(:,2);
matsam1(:,2)=matsam(:,1);

matmatergas1(:,1)=matergas(:,2);
matmatergas1(:,2)=matergas(:,1);

figure(111)
plot(1:n,matpsnr1(:,1),'g')
hold on
plot(1:n,matpsnr1(:,2),'r')

hold off
legend('INTERPOL', '3dcnn','Location', 'SouthEast')
title('PSNR')
figure(112)
plot(1:n,matssim1(:,1),'g')
hold on
plot(1:n,matssim1(:,2),'r')

hold off
legend('INTERPOL', '3dcnn','Location', 'SouthEast')
title('SSIM')

figure(113)
plot(1:n,matsam1(:,1),'g')
hold on
plot(1:n,matsam1(:,2),'r')

hold off
legend('INTERPOL', '3dcnn','Location', 'SouthEast')
title('SAM')

figure(114)
plot(1:n,matmatergas1(:,1),'g')
hold on
plot(1:n,matmatergas1(:,2),'r')

hold off
legend('INTERPOL', '3dcnn','Location', 'SouthEast')
title('ERGAS')
