function [data] = hpadd(data,mm)
[r,c,b]=size(data);
bb=zeros(r+mm,c+mm,b);
for i=1:b
  aa=data(:,:,i); 
  bb((mm/2+1):(r+mm/2),(mm/2+1):(c+mm/2),i)=aa;  
end
data=bb;
