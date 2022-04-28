function out = PSNRHSI(ref,tar)
[R,C,S]=size(ref);
MPSNR=0;
for i=1:S;
MPSNR=psnr(ref(:,:,i),tar(:,:,i))+MPSNR;
end
out=MPSNR/S;