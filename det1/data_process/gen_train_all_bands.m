clear;close all;
savepath = 'pavia_trainappct.h5';
size_input = 33;
size_label = 21;
scale = 2;
load('detcttrainin1.mat');
appctin=detcttrainin1;
load('detcttrainout1.mat');
appctout=detcttrainout1;
stride = 18;

%% initialization
dataa = zeros(size_input, size_input, 110, 1,1);
label = zeros(size_label, size_label, 110, 1,1);
padding = abs(size_input - size_label)/2;
count = 0;

tic

    im_input = im2double(appctin(:, :, :));
    image_true=appctout(:, :, :);
    [hei,wid,l] = size(im_input);
   % disp(i)
    for x = 1 : stride : hei-size_input+1
        disp(x )
        for y = 1 :stride : wid-size_input+1
            
            subim_input = im_input(x : x+size_input-1, y : y+size_input-1,:);
            subim_label = image_true(x+padding : x+padding+size_label-1, y+padding : y+padding+size_label-1,:);

            count=count+1;
            dataa(:, :, :,1, count) = subim_input;
            label(:, :, :, 1,count) = subim_label;
        end
    end

size(dataa)
size(label)
order = randperm(count);
dataa = dataa(:, :, :, order);
label = label(:, :, :, order); 
%% writing to HDF5
chunksz = 128;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = dataa(:,:,:,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,:,last_read+1:last_read+chunksz);
    disp([batchno, floor(count/chunksz)])
    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
toc

h5disp(savepath);

