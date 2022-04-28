function out = SSIMHSI(ref,tar)
[R,C,S]=size(ref);
MSSIM=0;
for i=1:S;
MSSIM=ssim(ref(:,:,i),tar(:,:,i))+MSSIM;
end
out=MSSIM/S;