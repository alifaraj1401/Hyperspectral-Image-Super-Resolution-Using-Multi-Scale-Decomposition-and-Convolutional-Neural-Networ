function [data] = hpadddd(data,mm)
[r,c,b]=size(data);
data=[data(:,mm/2:-1:1,:),data,data(:,c:-1:c-mm/2+1,:)];
data=[data(mm/2:-1:1,:,:);data;data(r:-1:r-mm/2+1,:,:)];