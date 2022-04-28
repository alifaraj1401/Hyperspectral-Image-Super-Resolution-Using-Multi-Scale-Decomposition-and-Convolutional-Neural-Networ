function [data] = hpaddd(data,mm)
[r,c,b]=size(data);
data=[data(:,1:mm/2,:),data,data(:,c-mm/2+1:c,:)];
data=[data(1:mm/2,:,:);data;data(r-mm/2+1:r,:,:)];
